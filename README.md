<h1>dotfile for Arch Linux</h1>
- This is an early version. Many things are still incomplete

<h2>TODO</h2>
<h3>Urgent</h3>
- Make dunst send a warning at critical battery levels
- Startup certain apps in certain workspaces
- Pull certain apps to certain workspaces
- Make certain apps float by default

<h3>Not so urgent</h3>
- Change cursor to look better
- Media control: ncmpcpp for music

<h2>Partially Done</h2>
- window manager: xmonad (xmonad, xmonad-contrib)
- taskbar: xmobar (xmobar)
- terminal emulator: alacritty (alacritty)
- text editor: nvim (neovim)
- Desktop compositor (Xorg) : picom (picom)
- Notification daemon: dunst (dunst)
- Application launcher: rofi (rofi drun something)

<h2>Complete</h2>
- Make things fullscreen with no border
- Display volume on bar
- Fix fullscreen issue with chromium browsers

<h2>Software List, Packages, and Start Instructions</h2>
- Description: software (package, how to start & misc info)
- File manager: thunar (thunar)
- Browser: brave
- Display manager: sddm (sddm, sudo systemctl start sddm.service)
- Screen locker: i3lock (i3lock)
- Audio control: wpctl (wireplumber, set-volume/set-mute @device@ value)
- Polkit authentication agent: polkit-kde-agent (spawnOnce)
- Screen capture: flameshot (flameshot, spawnOnce)
- Wallpaper setter: feh (feh --bg-scale dotfiles/themes/katana.jpg, spawnOnce ~/.fehbg &)
- Backlight control: light (light aur, only for laptop)
- Power management: btop (btop)
- Clipboard: clipmenu (clipmenu, env: CM_LAUNCHER=rofi, sudo systemctl --user enable clipmenud.service)
