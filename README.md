# Capturing remote packet using Wireshark on Windows

> *Read this in other languages: [English](README.md), [한국어](README.ko.md)*

- It is a command to capture packets in the following environment.

### Windows (My PC, Host OS)
  - How to install program
    - Wireshark
		- download from [https://www.wireshark.org/download.html](https://www.wireshark.org/download.html)
		- select your windows type(32bit/64bit), then install wireshark
    - putty
		- download from [https://www.chiark.greenend.org.uk/~sgtatham/putty/](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
		- select your windows type(32bit/64bit), then install putty

### Linux (Remote System, Target OS)
  - How to install program
    - [tcpdump](http://www.tcpdump.org/)
		- sudo yum install tupcump (Fedora, CentOS, Redhat)
		- sudo apt-get install tcpdump (Ubuntu, Debian)
		- Or install using source code [http://www.tcpdump.org/](http://www.tcpdump.org/)	
    - pcap
		- Most of cases are installed together when you install tcpdump.
		- sudo yum install libpcap (Fedora, CentOS, Redhat)
		- sudo apt-get install libpcap (Ubuntu, Debian)
	- ssh
		- Install OpenSSH server
			- sudo apt-get install openssh-server (Ubuntu)
				- sudo service ssh status (check openssh server)
				- sudo service ssh restart (restart openssh server)
			- sudo dnf install openssh-server (Fedora. you can use yum install openssh-server)
				- sudo systemctl start sshd.service (start openssh server)
				- sudo systemctl enable sshd.service (enable openssh server)

### Create command file on Windows
	- Build the command file(*.cmd) as follows:
	
	```
	@REM ---------------------------------------------------- 
	@REM remotecap.cmd
	@REM   Example command for captruing eremote network packet
	@REM  using wireshark and tcpdump. 
	@REM   First written by j2doll. September 10th 2016. 
	@REM   https://github.com/j2doll/wireshark-remote-command-win
	@REM   http://j2doll.tistory.com
	@REM ---------------------------------------------------- 
	@REM install putty and wireshark on your windows pc. 

	@SET PLINK_PATH="C:\Program Files\PuTTY\plink.exe" 
	@SET WIRESHARK_PATH="C:\Program Files\Wireshark\Wireshark.exe" 

	@SET REMOTE_SERVER=192.168.0.10 
	@SET REMOTE_ACCOUNT=root 
	@SET REMOTE_PASSWORD=password1234 
	@SET REMOTE_INTERFACE=eth0 

	@REM execute command 
	%PLINK_PATH% -ssh -pw %REMOTE_PASSWORD% %REMOTE_ACCOUNT%@%REMOTE_SERVER% "tcpdump -s0 -U -w - -i %REMOTE_INTERFACE% not port 22" | %WIRESHARK_PATH% -i - -k
	```
	
	- You can fix variables for your linux environemnt.
		- REMOTE_SERVER : linux ip (such as 192.168.137.18)
		- REMOTE_ACCOUNT : linux account 
		- REMOTE_PASSWORD : password of linux account
		- REMOTE_INTERFACE : linux ethernet interface (such as eth0, wlan0, etc)



