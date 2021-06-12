#!/bin/bash

		echo -e "============================================================================================================================="
		echo -e "                             Installing GRAPHICAL VNC (tightvncserver) "
  		echo -e "============================================================================================================================="
		apt-get update -y && sudo apt-get upgrade -y
		sudo apt-get install xfce4 xfce4-goodies xorg lxde-core tightvncserver -y --allow-unauthenticated
		vncserver
		vncserver -kill :1
		mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
		echo "#!/bin/bash
		xrdb $HOME/.Xresources
		startxfce4 &
		lxterminal &
		/usr/bin/lxsession -s LXDE &" >> ~/.vnc/xstartup
		sudo chmod +x ~/.vnc/xstartup
		echo "#!/bin/bash
		PATH="$PATH:/usr/bin/"
		export USER="user"
		DISPLAY="1"
		DEPTH="16"
		GEOMETRY="1024x768"
		OPTIONS="-depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -localhost"
		. /lib/lsb/init-functions" >> /etc/init.d/vncserver
		sudo chmod +x /etc/init.d/vncserver
		vncserver
		su
		clear
		echo -e "============================================================================================================================="
		myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
		echo "Connect it!!! Using :-  ${myip}:1 in VNC Viewer."
    
