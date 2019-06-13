@echo off
set targetHost=10.240.68.61

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set fullstamp=%datestamp%_%timestamp%
set resultFileName=sync_%targetHost%_%fullstamp%.txt

@echo Sync Started: %date% %time% > %resultFileName%

robocopy "D:\Application\Common\ApplicationUpdateService\Release" "\\%targetHost%\d$\Application\Common\ApplicationUpdateService\Release" /E /PURGE /NP /NDL /L /XD log /log+:%resultFileName%
robocopy "D:\Application\OTR\Application\Service" "\\%targetHost%\d$\Application\OTR\Application\Service"  /E /PURGE /NP /NDL /L /XD log  /log+:%resultFileName%
robocopy "D:\Application\OTR\Application\WebAdmin" "\\%targetHost%\d$\Application\OTR\Application\WebAdmin"  /E /PURGE /NP /NDL /L /XD log  /log+:%resultFileName%
robocopy "D:\Application\OTR\Application\SCMBatchjob" "\\%targetHost%\d$\Application\OTR\Application\SCMBatchjob"  /E /PURGE /NP /NDL /L /XD log  /log+:%resultFileName%
robocopy "D:\Application\OTS\Application" "\\%targetHost%\d$\Application\OTS\Application"  /E /PURGE /NP /NDL /L /XD log /log+:%resultFileName%
robocopy "D:\Application\OTS\WebClient" "\\%targetHost%\d$\Application\OTS\WebClient"  /E /PURGE /NP /NDL /L /XD log /log+:%resultFileName%

@echo Sync Completed: %date% %time%  >>  %resultFileName%

REM compare with script 20, the only different is script 21 add extra option /L