rem list all share folder
net share

rem add share folder
net share name_of_share=D:\Movies

rem remove share folder
net share name_of_share /delete

rem delete existing connections
net use /delete \\ServerName\\ShareName