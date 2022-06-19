Add-Type -AssemblyName System.IO.Compression.FileSystem
Set-PSDebug -strict # catch a few extra bugs

$backuppath = "D:\Bruce\iSHaRe\iSHaRe Deployment\Local Auto Deployment"
$deploymentpath = "D:\Bruce\iSHaRe\Local Test Release\Services"
$sourcepath = $backuppath

$backupfolder = "Service_"+(Get-Date -format yyyyMMdd_hhmmss)

########################### Helper functions begin ##########################
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}
function Output($msg)
{
    $curTime = Get-Date
    Echo "$curTime : $msg"
}
########################### Helper functions end ##########################

Output "Deployment started!"
########################### Backup files ##########################
Copy-Item $deploymentpath $backuppath"\"$backupfolder -Recurse -Force -Exclude "*.log"
Output "Back up completed"

########################### Unzip source files ##########################
if(Test-Path "$sourcepath\Services") {Remove-Item "$sourcepath\Services" -Force -Recurse}
Unzip "$sourcepath\Services.zip" $sourcepath
Output "Unzip source files completed"

########################### Delete all files in deployment folder ##########################
Remove-Item "$deploymentpath\*" -Force -Recurse -Exclude "*.log"
Output "Delete all files in folder $deploymentpath completed"

########################### Copy files from source folder to destination folder ##########################
Copy-Item  "$sourcepath\Services\*" $deploymentpath -Force -Recurse -Exclude "*.log"
Output "Copy files from folder $sourcepath\Services to folder $deploymentpath completed"

########################### Restore configure files from backup folder ##########################
Copy-Item  "$backuppath\$backupfolder\Web.config" $deploymentpath
Copy-Item  "$backuppath\$backupfolder\ConnectionString.config" $deploymentpath
Copy-Item  "$backuppath\$backupfolder\Logs\log4net.config" "$deploymentpath\Logs"
Output "Restore configuration files completed"

Output "Deployment completed!"
Pause