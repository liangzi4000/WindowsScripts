Rem Windows Update
sc config wuauserv start=disabled
sc stop wuauserv

Rem Windows Search
sc config WSearch start=disabled
sc stop WSearch
pause