# 윈도우즈에서 와이어샤크를 이용한 원격 패킷 캡춰

> *Read this in other languages: [English](README.md), [한국어](README.ko.md)*

## 개념

- 다음과 같은 환경에서 패킷을 캡춰하는 명령입니다.
![](markdown.data/concept.jpg)
- 리눅스에 GUI가 없다면, 패킷 분석은 어렵습니다.
- 이 명령 파일을 사용하면 Windows에서 분석을 수행 할 수 있습니다.

## 윈도우즈 (내 PC, 호스트 운영체제)

- 프로그램 설치하는 방법
- [Wireshark](https://www.wireshark.org)
  - [https://www.wireshark.org/download.html](https://www.wireshark.org/download.html) 에서 프로그램 다운로드
  - 윈도우즈 종류(32bit/64bit)를 선택한 후, 와이어샤크를 설치한다. (주의: 종류를 혼동하시면 안됩니다!)
  - **NOTICE : wireshark 2.4.6를 사용하세요.**
    - <https://www.wireshark.org/download/win64/all-versions/>
- [putty](https://www.putty.org/)
  - [https://www.chiark.greenend.org.uk/~sgtatham/putty/](https://www.chiark.greenend.org.uk/~sgtatham/putty/) 에서 프로그램 다운로드
  - 윈도우즈 종류(32bit/64bit)를 선택한 후, 푸티를 설치한다. (주의: 종류를 혼동하시면 안됩니다!)
  - **NOTICE : 구형 putty 를 사용하세요!**
    - <https://the.earth.li/~sgtatham/putty/0.68/w32/putty-0.68-installer.msi>
    - <https://the.earth.li/~sgtatham/putty/0.68/w64/putty-64bit-0.68-installer.msi> 

## 리눅스 (원격 시스템, 대상 운용체제)

### Installation

- [tcpdump](http://www.tcpdump.org/)
  - `sudo yum install tcpdump` (Fedora, CentOS, Redhat)
  - `sudo apt-get install tcpdump` (Ubuntu, Debian)
  - 또는 소스코드를 이용하여 설치도 가능합니다. [http://www.tcpdump.org/](http://www.tcpdump.org/)
- pcap
  - 대부분의 경우 tcpdump를 설치하면 함께 설치 됩니다.
  - `sudo yum install libpcap` (Fedora, CentOS, Redhat)
  - `sudo apt-get install libpcap` (Ubuntu, Debian)
- ssh
  - OpenSSH 서버 설치하기
    - `sudo apt-get install openssh-server` (Ubuntu)
    - `sudo dnf install openssh-server` (Fedora. `yum install openssh-server` 로 설치할 수도 있음)
  - Start OpenSSH daemon
    - `sudo systemctl start sshd.service` (start openssh server)
    - `sudo systemctl enable sshd.service` (enable openssh server)

## 윈도우즈에서 명령 제작

- 다음과 같은 명령 파일(*.cmd)을 작성합니다:

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

- 환경 변수를 환경에 맞추어 변경할 수 있습니다.
  - 리눅스
    - REMOTE_SERVER : 리눅스 ip (192.168.137.18 등)
    - REMOTE_ACCOUNT : 리눅스 계정 (**root 계정을 사용하세요. (또는 슈퍼유저)**)
    - REMOTE_PASSWORD : 리눅스 계정의 암호
    - REMOTE_INTERFACE : 리눅스 이더넷 인터페이스 (eth0, wlan0 등)
      - 만약 이것이 무엇인지 모르시면 **`ifconfig`** / **`ip a`** 명령을 리눅스에서 입력해 보세요.
  - 윈도우즈
    - WIRESHARK_PATH : 설치된 와이어샤크 실행 파일이 있는 경로 (wireshark.exe).
    - PLINK_PATH : 설치된 와이어샤크 plink 파일이 있는 경로 (plink.exe).

## 패킷 캡춰하는 방법

- 윈도우즈에서 'remotecap.cmd'를 실행 하세요. 윈도우즈가 방화벽 정책을 물어볼 수도 있습니다.

## 문의

- 이슈를 남겨 주세요. [https://github.com/j2doll/wireshark-remote-command-win/issues](https://github.com/j2doll/wireshark-remote-command-win/issues)
