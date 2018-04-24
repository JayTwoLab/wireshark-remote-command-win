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
	