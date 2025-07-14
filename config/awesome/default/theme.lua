---------------------------
-- Default awesome theme --
---------------------------

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local themes_path = "/home/pearmeow/.config/awesome/"

local theme = {}
theme.font_nosize = "JetBrainsMono Nerd Font Mono Bold "
theme.font = "JetBrainsMono Nerd Font Mono Bold 16"
theme.bar_bg = "#282424"
theme.bar_fg = "#FFFFFF"
theme.bar_border_width = dpi(10)
theme.widget_border = "#FFFFFF"
theme.widget_hover = "#008b8b"

theme.widget_unaffected = "#00ffff"
theme.widget_good = "#90ee90"
theme.widget_normal = "#ffff00"
theme.widget_critical = "#ff0000"
theme.widget_text_margins = dpi(15)
theme.widget_icon_margins = dpi(10)
theme.widget_border_width = dpi(2)

theme.bg_normal = "#222222"
theme.bg_focus = "#535d6c"
theme.bg_urgent = "#ff0000"
theme.bg_minimize = "#444444"

theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

theme.useless_gap = dpi(5)
theme.border_width = dpi(3)
theme.border_normal = "#3b4b54"
theme.border_focus = "#67a2c4"

theme.border_marked = "#91231c"

theme.taglist_bg_focus = "#282424"
theme.taglist_fg_focus = "#00ffff"
theme.taglist_shape = gears.shape.rectangle
theme.taglist_shape_border_width = dpi(2)
theme.taglist_shape_border_color = "#FFFFFF"
-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:

-- Variables set for theming notifications:
theme.notification_font = "JetBrainsMono Nerd Font Mono 18"
theme.notification_fg = "#FFFFFF"
theme.notification_bg = "#6770a0"
theme.notification_icon_size = dpi(100)
theme.notification_max_height = dpi(300)
theme.notification_width = dpi(1000)
theme.notification_shape = gears.shape.rounded_rect
theme.notification_border_color = "#FFFFFF"
theme.notification_border_width = dpi(3)
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.wallpaper = themes_path .. "default/background.jpg"

-- CPU and RAM icons
theme.cpu = ""
theme.ram = ""

-- Battery icons
theme.battery_100 = "󰁹"
theme.battery_80 = "󰂁"
theme.battery_60 = "󰁿"
theme.battery_40 = "󰁽"
theme.battery_20 = "󰁻"
theme.battery_critical = "󰂃"
theme.battery_charging = "󰂄"

-- Volume icons
theme.volume_mute = "󰝟"
theme.volume_variant_mute = "󰸈"
theme.volume_low = "󰕿"
theme.volume_medium = "󰖀"
theme.volume_high = "󰕾"

-- Brightness icon
theme.brightness = "󰃞"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
