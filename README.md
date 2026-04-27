# KDE Termux installer (native)
This script allows you to install the KDE Plasma Desktop on your Android without root access or proot-distro

## Features

1) No root required 
2) Uses Termux:X11 for fast using
3) Creates start and stop scripts
4) Automated script which does everything

### Requirements

1) Min. 2GiB RAM
2) Min. 8GiB storage
3) Android 8+
4) Termux and Termux:X11 installed

#### Installation

```bash
pkg update
pkg install git
git clone https://github.com/AppNotFound/native-kde-termux.git
cd native-kde-termux
bash install-kde.sh

##### Commands after installation

startkde       # Starts KDE Plasma
stopkde        # Stops KDE Plasma 
