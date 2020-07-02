#!/usr/bin/bash

#rm -rf ~/.wine && rm -rf .local/share/applications/wine/Programs/Microsoft\ Visual\ Studio\ 6.0/
wget https://www.dropbox.com/s/8sddfow118z2ze9/Microsoft%20Visual%20Studio%206.0.iso?dl=1 -O Microsoft\ Visual\ Studio\ 6.0.iso
WINEARCH=win32 WINEDLLOVERRIDES="mscoree,mshtml=" wine wineboot
winetricks win98 native_mdac
wineboot
mkdir -p ~/.wine/drive_c/VS/IE4/3155
7z x -o/home/user/.wine/drive_c/VS Microsoft\ Visual\ Studio\ 6.0.iso
cd ~/.wine/drive_c/VS/
wine IE4/MSJAVX86.EXE /q /c /t:C:\\VS\\IE4\\3155
#wine rundll32.exe setupapi.dll,InstallHinfSection BaseInstallation 128 C:\\VS\\IE4\\3155\\java.inf
cd IE4/3155 && wine javatrig.exe /l /exe_install /nowincheck /q &
while ! ps -C winedbg>/dev/null  ; do sleep 1; echo -n .; done
pkill winedbg
while ! xdotool search java 2>/dev/null 1>/dev/null ; do sleep 1; echo -n .; done
xdotool search java windowactivate && xdotool search java key Return
xdotool keyup Return
xdotool keyup Return
while ! xdotool search microsoft 2>/dev/null 1>/dev/null ; do sleep 1; echo -n .; done
xdotool search microsoft windowactivate && xdotool search microsoft key Return
xdotool keyup Return
xdotool keyup Return
while ps -C wineserver>/dev/null  ; do sleep 1; echo -n .; done
wineboot
ps x
echo ............
sleep 5s
ps x
echo ............
sleep 2s
ps x
wineserver --kill
cd ~/.wine/drive_c/VS
cp ~/VS98ENT.STF SETUP/VS98ENT.STF
wine SMSINST.EXE /k 1112345678
while ! ps -C winedbg>/dev/null  ; do sleep 1; echo -n .; done
pkill winedbg
while ps -C wineserver>/dev/null  ; do sleep 1; echo -n .; done
cd ~
ps x
