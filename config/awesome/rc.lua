-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init("/home/pearmeow/.config/awesome/default/theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"
-- local editor = os.getenv("EDITOR") or "vim"
-- local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	-- awful.layout.suit.floating,
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- Sets wallpaper using path found in beautiful
local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget({
	{
		{
			{
				{
					-- Format: Shorthand weekday, year-month-day hour:second
					format = "%a %Y-%m-%d %H:%M:%S",
					widget = wibox.widget.textclock,
					refresh = 5,
				},
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = beautiful.widget_text_margins,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.bar_fg,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

mytextclock:connect_signal("mouse::enter", function()
	mytextclock.bg = beautiful.widget_hover
end)
mytextclock:connect_signal("mouse::leave", function()
	mytextclock.bg = beautiful.bar_bg
end)

local ram_icon = wibox.widget({
	markup = beautiful.ram,
	widget = wibox.widget.textbox,
	font = beautiful.font_nosize .. "30",
})

local ram_percent = awful.widget.watch("free -L", 10, function(widget, stdout)
	local _, _, _, cacheuse, _, memuse, _, memfree =
		stdout:match("(%w+)%s+(%d+)%s+(%w+)%s+(%d+)%s+(%w+)%s+(%d+)%s+(%w+)%s+(%d+)%s+")
	local usage = memuse / (memuse + cacheuse + memfree)
	local padding = ""
	if usage < 0.1 then
		padding = " "
	end
	if usage < 0.33 then
		ram_widget.fg = beautiful.widget_good
	elseif usage < 0.66 then
		ram_widget.fg = beautiful.widget_normal
	else
		ram_widget.fg = beautiful.widget_critical
	end
	widget:set_markup("[RAM] " .. padding .. math.floor(usage * 1000) / 10 .. "%")
end)

ram_widget = wibox.widget({
	{
		{
			{
				ram_icon,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_icon_margins,
			left = beautiful.widget_text_margins,
		},
		{
			{
				ram_percent,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.bar_fg,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

ram_widget:connect_signal("mouse::enter", function()
	ram_widget.bg = beautiful.widget_hover
end)
ram_widget:connect_signal("mouse::leave", function()
	ram_widget.bg = beautiful.bar_bg
end)

local cpu_icon = wibox.widget({
	markup = beautiful.cpu,
	widget = wibox.widget.textbox,
	font = beautiful.font_nosize .. "28",
})

local maincpu = {}
local cpu_percent = awful.widget.watch("grep --max-count=1 '^cpu.' /proc/stat", 10, function(widget, stdout)
	local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
		stdout:match("(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)")
	local total = user + nice + system + idle + iowait + irq + softirq + steal
	local diff_idle = idle - tonumber(maincpu["idle_prev"] == nil and 0 or maincpu["idle_prev"])
	local diff_total = total - tonumber(maincpu["total_prev"] == nil and 0 or maincpu["total_prev"])
	local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10
	maincpu["total_prev"] = total
	maincpu["idle_prev"] = idle
	local padding = ""
	if diff_usage < 10 then
		padding = " "
	end
	if diff_usage < 33 then
		cpu_widget.fg = beautiful.widget_good
	elseif diff_usage < 66 then
		cpu_widget.fg = beautiful.widget_normal
	else
		cpu_widget.fg = beautiful.widget_critical
	end
	widget:set_markup("[CPU] " .. padding .. math.floor(diff_usage * 10) / 10 .. "%")
end)

cpu_widget = wibox.widget({
	{
		{
			{
				cpu_icon,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_icon_margins,
			left = beautiful.widget_text_margins,
		},
		{
			{
				cpu_percent,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.bar_fg,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

cpu_widget:connect_signal("mouse::enter", function()
	cpu_widget.bg = beautiful.widget_hover
end)
cpu_widget:connect_signal("mouse::leave", function()
	cpu_widget.bg = beautiful.bar_bg
end)

local function makeBar(num)
	local percent = num * 100
	local filled = math.floor(percent / 10)
	local empty = 10 - filled
	local bar = "["
	for _ = 1, filled do
		bar = bar .. "▓"
	end
	for _ = 1, empty do
		bar = bar .. "▒"
	end
	local offset = ""
	if percent < 100 then
		offset = offset .. " "
	end
	if percent < 10 then
		offset = offset .. " "
	end
	if percent == 0 then
		percent = 0.0
	end
	bar = bar .. "]" .. offset .. percent .. "%"
	return bar
end

local battery_icon = wibox.widget({
	markup = beautiful.battery_charging,
	font = beautiful.font_nosize .. "22",
	widget = wibox.widget.textbox,
})

local battery_bar = awful.widget.watch("acpi", 3, function(widget, stdout)
	local text = ""
	for _ in stdout:gmatch("unavailable") do
		text = "[▓▓▓▓▓▓▓▓▓▓] ∞%"
		widget:set_markup(text)
		return
	end
	--  TODO: make this work for laptop
	widget:set_markup(text)
end)

-- TODO: implement this on laptop
local function changeBattery() end

local battery_widget = wibox.widget({
	{
		{
			{
				battery_icon,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = beautiful.widget_text_margins,
			right = beautiful.widget_icon_margins,
		},
		{
			{
				battery_bar,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.widget_good,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

battery_widget:connect_signal("mouse::enter", function()
	battery_widget.bg = beautiful.widget_hover
end)
battery_widget:connect_signal("mouse::leave", function()
	battery_widget.bg = beautiful.bar_bg
end)

local brightness_icon = wibox.widget({
	markup = beautiful.brightness_off,
	font = beautiful.font_nosize .. "34",
	widget = wibox.widget.textbox,
})

local brightness_bar = wibox.widget({
	-- Ascii for bar ▓▒
	markup = "[▓▓▓▓▓▒▒▒▒▒] 50%",
	widget = wibox.widget.textbox,
})

local brightness_widget = wibox.widget({
	{
		{
			{
				brightness_icon,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = beautiful.widget_text_margins,
			right = beautiful.widget_icon_margins,
		},
		{
			{
				brightness_bar,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.widget_unaffected,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

brightness_widget:connect_signal("mouse::enter", function()
	brightness_widget.bg = beautiful.widget_hover
end)
brightness_widget:connect_signal("mouse::leave", function()
	brightness_widget.bg = beautiful.bar_bg
end)

local function changeBrightness()
	local cmd = "light -G"
	awful.spawn.easy_async(cmd, function(stdout)
		local num = tonumber(stdout:match("%d%p%d+"))
		brightness_bar.markup = makeBar(num)
	end)
end

brightness_widget:buttons(gears.table.join(
	awful.button({}, 4, function()
		local cmd = "light -A 3"
		awful.spawn.easy_async(cmd, changeBrightness)
	end),
	awful.button({}, 5, function()
		local cmd = "light -U 3"
		awful.spawn.easy_async(cmd, changeBrightness)
	end)
))

local vol_icon = wibox.widget({
	markup = beautiful.volume_medium,
	font = beautiful.icon_font,
	widget = wibox.widget.textbox,
})

local vol_bar = wibox.widget({
	-- Ascii for bar ▓▒
	markup = makeBar(0.28),
	widget = wibox.widget.textbox,
})

local audio_widget = wibox.widget({
	{
		{
			{
				vol_icon,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			left = beautiful.widget_text_margins,
			right = beautiful.widget_icon_margins,
		},
		{
			{
				vol_bar,
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.margin,
			right = beautiful.widget_text_margins,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.widget_good,
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	shape_border_width = beautiful.widget_border_width,
	shape_border_color = beautiful.widget_border,
})

local function changeVol()
	local cmd = "wpctl get-volume @DEFAULT_SINK@"
	awful.spawn.easy_async(cmd, function(stdout)
		local _, strNum = stdout:match("(%a+:)%s(%d%p%d+)")
		local num = tonumber(strNum) or 0.28
		local icon = ""
		local fontcolor = beautiful.widget_good
		if num >= 0.60 then
			icon = beautiful.volume_high
			fontcolor = beautiful.widget_critical
			vol_icon.font = beautiful.font_nosize .. "34"
		elseif num > 0.40 then
			icon = beautiful.volume_medium
			fontcolor = beautiful.widget_normal
			vol_icon.font = beautiful.font_nosize .. "28"
		elseif num > 0.20 then
			icon = beautiful.volume_medium
			vol_icon.font = beautiful.font_nosize .. "28"
		elseif num > 0 then
			icon = beautiful.volume_low
			vol_icon.font = beautiful.font_nosize .. "20"
		else
			icon = beautiful.volume_variant_mute
			vol_icon.font = beautiful.font_nosize .. "30"
		end
		if stdout:len() > 13 then
			icon = beautiful.volume_mute
			vol_icon.font = beautiful.font_nosize .. "40"
		end
		audio_widget.fg = fontcolor
		vol_icon:set_markup(icon)
		vol_bar:set_markup(makeBar(num))
	end)
end

audio_widget:connect_signal("mouse::enter", function()
	audio_widget.bg = beautiful.widget_hover
end)
audio_widget:connect_signal("mouse::leave", function()
	audio_widget.bg = beautiful.bar_bg
end)

audio_widget:buttons(gears.table.join(
	awful.button({}, 1, function()
		local cmd = "wpctl set-mute @DEFAULT_SINK@ toggle"
		awful.spawn.easy_async(cmd, changeVol)
	end),
	awful.button({}, 4, function()
		local cmd = "wpctl set-volume -l 1 @DEFAULT_SINK@ 2%+"
		awful.spawn.easy_async(cmd, changeVol)
	end),
	awful.button({}, 5, function()
		local cmd = "wpctl set-volume -l 1 @DEFAULT_SINK@ 2%-"
		awful.spawn.easy_async(cmd, changeVol)
	end)
))

local separator = wibox.widget({
	markup = "  ",
	widget = wibox.widget.textbox,
})

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table and is set with the layout in awful.layout.layouts[1]
	awful.tag({ "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]", "[0]" }, s, awful.layout.layouts[1])

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		border_width = beautiful.bar_border_width,
		bg = beautiful.bar_bg,
		border_color = beautiful.bar_bg,
		visible = true,
	})

	s.taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.selected,
		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = beautiful.widget_text_margins,
				right = beautiful.widget_text_margins,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, _, _, _) --luacheck: no unused args
				self:connect_signal("mouse::enter", function()
					self.bg = beautiful.widget_hover
				end)
				self:connect_signal("mouse::leave", function()
					self.bg = beautiful.bar_bg
				end)
			end,
		},
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.taglist,
			separator,
			cpu_widget,
			separator,
			ram_widget,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			mytextclock,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			battery_widget,
			separator,
			audio_widget,
			separator,
			brightness_widget,
		},
	})
end)
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	-- Rofi
	awful.key({ modkey }, "p", function()
		awful.spawn.with_shell("~/.config/rofi/launchers/type-6/launcher.sh")
	end, { description = "show rofi", group = "launcher" }),
	-- Flameshot
	awful.key({ modkey, "Shift" }, "s", function()
		awful.spawn.with_shell("flameshot gui")
	end, { description = "take screenshot with flameshot", group = "launcher" }),
	-- Audio keybinds
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.easy_async("wpctl set-volume -l 1 @DEFAULT_SINK@ 2%+", changeVol)
	end, { description = "raise volume", group = "awesome" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.easy_async("wpctl set-volume -l 1 @DEFAULT_SINK@ 2%-", changeVol)
	end, { description = "lower volume", group = "awesome" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.easy_async("wpctl set-mute @DEFAULT_SINK@ toggle", changeVol)
	end, { description = "toggle mute", group = "awesome" }),
	-- Brightness keybinds
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.easy_async("light -A 3", changeBrightness)
	end, { description = "raise brightness", group = "awesome" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("light -U 3", changeBrightness)
	end, { description = "lower brightness", group = "awesome" })
)

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ modkey }, "t", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			maximized_vertical = false,
			maximized_horizontal = false,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"org.gnome.Nautilus",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
				"Steam Settings",
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
	{ rule = { class = "brave-browser", "Brave-browser" }, properties = { screen = 1, tag = "1" } },
	{ rule = { class = "com.github.xournalpp.xournalpp" }, properties = { screen = 1, tag = "4" } },
	{ rule = { class = "steam" }, properties = { screen = 1, tag = "9" } },
	{ rule = { class = "vesktop", "vencorddesktop", "VencordDesktop" }, properties = { screen = 1, tag = "10" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- No, this is not a function I made; it is defined by awesomewm
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- Disable minimizing and maximizing windows (not fullscreen)
client.connect_signal("property::minimized", function(c)
	c.minimized = false
end)
client.connect_signal("property::maximized", function(c)
	c.maximized = false
end)

-- Jump to urgent client immediately (for opening links and such)
client.connect_signal("property::urgent", function(c)
	c:jump_to()
end)

-- }}}
-- XDG autostart
awful.spawn.with_shell(
	'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;'
		.. 'xrdb -merge <<< "awesome.started:true";'
		.. 'dex --environment Awesome --autostart --search-paths "${XDG_CONFIG_HOME:-$HOME/.config}/autostart:${XDG_CONFIG_DIRS:-/etc/xdg}/autostart";'
)

-- Autostart script & commands to run on startup
-- Windows don't go to correct tags
-- awful.spawn.with_shell("~/.config/awesome/scripts/autorun.sh")
-- Need to run changevol twice and with a delay because of wireplumber issues
awful.spawn.easy_async("sleep 1", changeVol)
changeVol()
changeBrightness()
changeBattery()
