``change_wallpaper_winlight``
=================

This is a little script that randomly choose a wallpaper from a folder where [WinLight](https://github.com/Biswa96/WinLight/) was run.

[WinLight](https://github.com/Biswa96/WinLight/) download Windows 10 Spotlight Lock screen images.

# How to install
*   `mkdir -p ~/.local/bin/ ~/.local/share/systemd/user/`
*   `cp change_wallpaper_winlight.sh ~/.local/bin/ && chmod +x ~/.local/bin/change_wallpaper_winlight.sh `
*   `cp change_wallpaper_winlight.{timer,service} ~/.local/share/systemd/user/`
*   Edit `~/.local/bin/change_wallpaper_winlight.sh` and change *IMAGE_DIR* to the directory where you store images
*   Edit `~/.local/share/systemd/user/change_wallpaper_winlight.service` and change *ExecStart* to the right path
*   `systemctl --user daemon-reload && systemctl --user enable change_wallpaper_winlight.timer && systemctl --user start change_wallpaper_winlight.timer`

