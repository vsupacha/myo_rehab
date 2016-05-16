// plug bluetooth adapter
// permission to ttyACM0 - must restart linux user after this
sudo usermod -a -G dialout $USER

// dependencies
sudo apt-get install python-pip
sudo pip install pySerial --upgrade
sudo pip install enum34
sudo pip install PyUserInput
sudo apt-get install python-Xlib
sudo apt-get install python-tk

// now reboot

###credit: http://www.fernandocosentino.net/pyoconnect/
