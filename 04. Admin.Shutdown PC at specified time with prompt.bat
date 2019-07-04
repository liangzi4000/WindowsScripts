rem shutdown local PC at specified time
at 5:30 shutdown -s -t 60 -c "System will be shutdown in 60 seconds"

rem shutdown remote PC
shutdown /s /m \\PC-Name

rem force reboot in 30 seconds, /s cannot use together with /f.
shutdown /f /r /t 30