for icons download it from here: https://fontawesome.com/download
for autotiling do this
```bash
sudo apt install python3-pip
pip3 install --user i3ipc
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py -O autotiling
chmod +x autotiling
sudo mv autotiling /usr/local/bin/
Edit your Sway configuration file (~/.config/sway/config) and add the following line to start autotiling:
exec_always autotiling (in the file config file provided, its already there).
```
