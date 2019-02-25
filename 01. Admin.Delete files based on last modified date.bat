forfiles /p "D:\Medisys\OTRS\Application\OTRSAppService\Log" /s /m *.mlog /c "cmd /c Del @path" /d -30
forfiles /p "D:\Medisys\OTRS\Application\OTRSAppService2\Log" /s /m *.mlog /c "cmd /c Del @path" /d -30
forfiles /p "D:\Medisys\OTRS\Interface\HL7\Engine\Service\Log" /s /m *.mlog /c "cmd /c Del @path" /d -30
forfiles /p "C:\inetpub\logs\LogFiles\W3SVC1" /s /m u_ex*.log /c "cmd /c Del @path" /d -30