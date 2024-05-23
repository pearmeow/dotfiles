 - Finished
file manager: thunar (thunar)
browser: brave

Display manager: sddm (sddm, sudo systemctl start sddm.service)
Screen locker: i3lock
Audio control: wpctl (wpct set-volume/set-mute @device@ value)
Polkit authentication agent: polkit-kde-agent (spawnOnce)
Screen capture: flameshot (spawnOnce))
Wallpaper setter: feh (feh --bg-scale dotfiles/themes/katana.jpg, spawnOnce ~/.fehbg &)
Backlight control: light (aur, only for laptop)
Power management: btop (btop)
Clipboard: clipmenu (env: CM_LAUNCHER=rofi, sudo systemctl --user enable clipmenud.service)

 - TODO
 - Urgent
DONE                    Make things fullscreen with no border
DONE                    Display volume on bar
DONE                    Fix fullscreen issue with chromium browsers
Make dunst send a warning at critical battery levels
Startup certain apps in certain workspaces
Pull certain apps to certain workspaces
Make certain apps float by default

Change cursor to look better
Media control: ncmpcpp for music


 - Partially done
window manager: xmonad (xmonad, xmonad-contrib)
taskbar: xmobar (xmobar)
terminal emulator: alacritty (alacritty)
text editor: nvim (neovim)
Desktop compositor (Xorg) : picom (picom)
Notification daemon: dunst (dunst)
Application launcher: rofi (rofi drun something)
