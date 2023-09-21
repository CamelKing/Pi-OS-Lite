to change console screen text/font/size
- sudo dpkg-reconfigure console-setup
- UTF-8
- Latin 1
- VGA
- 16x32

Connect Bluetooth mouse from command line

- bluetoothctl
- scan on
- pair <mac address of mouse>
- trust <mac address of mouse> # to auto reconnect
- connect <mac address of mouse> # to connect and activate mouse
- exit # exit bluetooth mode

Prepare to install Python 3.11.5
- sudo apt install build-essential checkinstall 
- sudo apt install libreadline-gplv2-dev libncursesw5-dev libssl-dev
- sudo apt install libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev 
