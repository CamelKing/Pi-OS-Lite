sudo apt update
sudo apt upgrade -y

sudo apt install git -y

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global pull.rebase true

cd
mkdir src
cd src
git clone https://github.com/CamelKing/setup-pi-os-lite
cd setup-pi-os-lite
ls

