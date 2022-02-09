Bash script to setup, tune for gaming, and debloat Pop_OS!
## Run the script
First download the script cloning the Github repository or downloading the ZIP file.
To run this script, open a terminal, and use the command:
`bash ~/Downloads/pop_debloat.sh`
Answer the first question, and let the script do the magic!
## Finding video card manufacter
If you don't know your video card manufacter, you can use the command
`lspci | grep VGA`
For example, my video card is AMD.
[![lspci-VGA-command-example.png](https://i.postimg.cc/pdQgVdL1/lspci-VGA-command-example.png)](https://postimg.cc/DWZCBnsq)
## Used software
I personally choose the software that you will find in the script:
### Gaming software
- [Mesa drivers](https://gitlab.freedesktop.org/mesa)
- [Steam](https://store.steampowered.com)
- [Discord](https://discord.com)
- [OpenJDK 17](https://openjdk.java.net/projects/jdk/17)
- [Xanmod kernel](https://xanmod.org)
- [WineHQ stable](https://www.winehq.org)
- [Lutris](https://lutris.net)
- [FeralInteractive Gamemode](https://github.com/FeralInteractive/gamemode)
- [ProtonUP](https://github.com/AUNaseef/protonup)
- [Heroic](https://heroicgameslauncher.com)
### Additional softwares
- [Micro Editor](https://micro-editor.github.io)
- [Pluma Editor](https://wiki.mate-desktop.org/mate-desktop/applications/pluma)
- [Gnome Tweaks](https://wiki.gnome.org/Apps/Tweaks)
- [Kitty Terminal Emulator](https://github.com/kovidgoyal/kitty)
- [SSH](https://www.ssh.com/academy/ssh)
There are few software the script contain which are not being installed by default:
- ZSH
- [Qemu](https://www.qemu.org)
- [Oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
These software requires some extras configuration. To install it, you have to uncomment (simply remove the "#") the command.
## Issues and request
If you have any issue or request, open an issue via Github.

