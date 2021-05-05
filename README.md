# Capturing remote packet using Wireshark on Windows

> *Read this in other languages: [English](README.md), [한국어](README.ko.md)*

### Concept
- It is a command to capture packets in the following environment.
![](markdown.data/concept.jpg)
- If your Linux has no GUI, analyzing packets is difficult.
- You can use this commnad file, then you can perform analysis in Windows.

### Windows (My PC, Host OS)
- How to install program
- [Wireshark](https://www.wireshark.org)
	- Download from [https://www.wireshark.org/download.html](https://www.wireshark.org/download.html)
	- Check your windows type(32bit/64bit), then install wireshark. (NOTICE: You should not confuse the type!)
	- **NOTICE : wireshark 2.4.6 **
	   - https://www.wireshark.org/download/win64/all-versions/
- [putty](https://www.putty.org/)
	- Download from [https://www.chiark.greenend.org.uk/~sgtatham/putty/](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
	- Check your windows type(32bit/64bit), then install putty (NOTICE: You should not confuse the type!)
	- **NOTICE : Use old putty!**
	   - https://the.earth.li/~sgtatham/putty/0.68/w32/putty-0.68-installer.msi
	   - https://the.earth.li/~sgtatham/putty/0.68/w64/putty-64bit-0.68-installer.msi

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

```cmd
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

- You can fix variables for your environemnt.
	- Your Linux
		- REMOTE_SERVER : linux ip (such as 192.168.137.18)
		- REMOTE_ACCOUNT : linux account (**Use root account. (or superuser)**)
		- REMOTE_PASSWORD : password of linux account
		- REMOTE_INTERFACE : linux ethernet interface (such as eth0, wlan0, etc)
			- If you don't know this, type command '<b>ifconfig</b>' on your linux.
	- Your Windows
		- WIRESHARK_PATH : This is where you installed wireshark execute file (wireshark.exe).
		- PLINK_PATH : This is where you installed putty plink execute file (plink.exe).

### How to capture packet
- Just run 'remotecap.cmd' on Windows. Windows may ask to you about firewall policy of Windows.

### Contact
* Leave me a issue. [https://github.com/j2doll/wireshark-remote-command-win/issues](https://github.com/j2doll/wireshark-remote-command-win/issues)
* Hi! I'm j2doll (aka Jay Two). My native language is not English and my English is not fluent. Please, use EASY English. :-)
