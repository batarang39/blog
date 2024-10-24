---
title: "Linux"
date: 2024-09-19T18:20:42+10:00
draft: false
---
linux is a big topic and is very important

linux distributions




linux kernel

linux commands
-
- # Basic Linux Commands
- ## hotkeys
  
  is used to search for used commands  
  
  note it used more that onces  
  ```bash
  ctrl + r
  ```
  to paste in terminal  
  ```bash
  ctrl + shift + v
  ```
- ## movement
- show working directory
  ```bash
  pwd
  ```
- to show file in folders
  
  ```bash
  ls
  ```
	- helpful options
	    
	  ```bash
	  ls -al
	  
	  ll
	  ```
- to change directory
  ```bash
  cd
  ```
	- helpful options
	- is used to go up a level
	  ```bash
	  
	  cd ..
	  ```
	- to go to a specific folder
	  ```bash
	  
	  cd /the/file/path
	  
	  ```
	  is used to go home  
	  ```bash
	  
	  cd ~
	  ```
	    
	    
	  copying file  
	  ```bash
	  
	  cp
	  ```
- moving files
  ```bash
  mv
  ```
	-
	  ```
	  mv -v
	  
	  ```
	  delete files or folders  
	  ```bash
	  
	  rm
	  rm -r
	  mkdir
	  rmdir
	  ```
- create files
  ```bash
  
  touch
  ```
- view manual pages
  ```bash
  man
  ```
- raising privileges
  ```bash
  sudo
  ```
- add on to previous command
  ```bash
  !!
  ```
- show history
  ```bash
  history
  ```
- monitoring processes
  ```bash
  top
  htop
  btop
  ```
  
  ```bash
  ps aux | grep nginx
  ```
- view file in a terminal
-
  ```bash
  cat
  ```
- [[Networking]]
  ```bash
  
  
  ip a
  ip addr show
  ip addr show eth0
  
  ifconfig= ipconfig
  hostname = shows hostname
  hostname -i = show ip address
  hostname -d = shows domain name
  hostname -f = full qualified domain name 
  netstat =network connecttions routing tables
  netstat -t = shows only tcp connections
  netstat -u = shows only udp connetions
  netstat -g = shows all muticasting networks
  netstat -l = shows only listening or open ports
  
  ping
  ifup
  ifdown
  nslookup
  ```
  disk  
  ```bash
  
  df
  df -mh
  df -ah
  
  du -sh
  
  lsblk
  
  free
  
  sudo nano /etc/fstab
  sudo mount -a
  
  
  git
  
  ssh
  
  exit
  reboot
  
  shutdown 00
  
  
  curl
  wget
  
  
  pip install
  
  
  grep
  history
  
  ```
  [[docker]]  
  ```bash
  
  docker -ps
  docker-compose
  docker-compose up -d
  docker exec -it nginx bash
  ```
