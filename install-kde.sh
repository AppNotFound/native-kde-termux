#!/data/data/com.termux/files/usr/bin/bash

set -e

# ================= COLORS =================
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ================= START CLEAN =================
clear

clear

printf "\033[1;36m====================================\n"
printf " KDE PLASMA 6 ON TERMUX INSTALLER\n"
printf "      (No root, no proot-distro)\n"
printf "====================================\033[0m\n"
# ================= STEP 1 =================
echo -e "${YELLOW}[1/5] Updating system...${RESET}"
pkg update -y && pkg upgrade -y

clear
echo -e "${YELLOW}[2/5] Enabling repositories...${RESET}"

pkg install x11-repo tur-repo -y
pkg update -y

clear
echo -e "${YELLOW}[3/5] Installing KDE + X11 stack...${RESET}"

pkg install termux-x11-nightly termux-api pulseaudio -y

pkg install plasma-desktop plasma-workspace konsole dolphin kwin-x11 xwayland --no-install-recommends -y
pkg install firefox -y
clear
echo -e "${YELLOW}[4/5] Creating startkde script...${RESET}"

cat > $PREFIX/bin/startkde << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "===================================="
echo " STARTING KDE PLASMA SESSION"
echo "===================================="

killall termux-x11 Xwayland kwin_x11 plasmashell 2>/dev/null

pulseaudio --start --exit-idle-time=-1

termux-x11 :0 &
sleep 2

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity

export DISPLAY=:0
export PULSE_SERVER=127.0.0.1
export XDG_RUNTIME_DIR=$TMPDIR
export QT_QPA_PLATFORM=xcb
export XDG_SESSION_TYPE=x11

echo "Launching KDE Plasma..."
dbus-launch --exit-with-session startplasma-x11
EOF

clear
echo -e "${YELLOW}[5/5] Creating stopkde script...${RESET}"

cat > $PREFIX/bin/stopkde << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

echo "===================================="
echo " STOPPING KDE PLASMA SESSION"
echo "===================================="

killall startplasma-x11 kwin_x11 plasmashell 2>/dev/null
killall termux-x11 Xwayland 2>/dev/null
pulseaudio --kill 2>/dev/null

echo "KDE Plasma stopped safely."
EOF

# ================= FINAL SETUP =================
echo -e "${YELLOW}Making scripts executable...${RESET}"

chmod +x $PREFIX/bin/startkde
chmod +x $PREFIX/bin/stopkde

clear

echo -e "${GREEN}===================================="
echo " INSTALLATION COMPLETE"
echo "===================================="
echo "To start KDE : startkde"
echo "To stop KDE  : stopkde"
echo "====================================${RESET}"
