<h1>dotfile for Arch Linux</h1>
- This is an early version. Many things are still incomplete

<h2>TODO</h2>
<h3>Urgent</h3>
<ul>
    <li>Make dunst send a warning at critical battery levels</li>
    <li>Startup certain apps in certain workspaces</li>
    <li>Pull certain apps to certain workspaces</li>
    <li>Make certain apps float by default</li>
</ul>

<h3>Not so urgent</h3>
<ul>
    <li>Change cursor to look better</li>
    <li>Media control: ncmpcpp for music</li>
</ul>

<h2>Partially Done</h2>
<ul>
    <li>window manager: xmonad (xmonad, xmonad-contrib)</li>
    <li>taskbar: xmobar (xmobar)</li>
    <li>terminal emulator: alacritty (alacritty)</li>
    <li>text editor: nvim (neovim)</li>
    <li>Desktop compositor (Xorg) : picom (picom)</li>
    <li>Notification daemon: dunst (dunst)</li>
    <li>Application launcher: rofi (rofi drun something)</li>
</ul>

<h2>Complete</h2>
<ul>
    <li>Make things fullscreen with no border</li>
    <li>Display volume on bar</li>
    <li>Fix fullscreen issue with chromium browsers</li>
</ul>

<h2>Software List, Packages, and Start Instructions</h2>
<ul>
    <li>Description: software (package, how to start & misc info)</li>
    <li>File manager: thunar (thunar)</li>
    <li>Browser: brave</li>
    <li>Display manager: sddm (sddm, sudo systemctl start sddm.service)</li>
    <li>Screen locker: i3lock (i3lock)</li>
    <li>Audio control: wpctl (wireplumber, set-volume/set-mute @device@ value)</li>
    <li>Polkit authentication agent: polkit-kde-agent (spawnOnce)</li>
    <li>Screen capture: flameshot (flameshot, spawnOnce)</li>
    <li>Wallpaper setter: feh (feh --bg-scale dotfiles/themes/katana.jpg, spawnOnce ~/.fehbg &)</li>
    <li>Backlight control: light (light aur, only for laptop)</li>
    <li>Power management: btop (btop)</li>
    <li>Clipboard: clipmenu (clipmenu, env: CM_LAUNCHER=rofi, sudo systemctl --user enable clipmenud.service)</li>
</ul>
