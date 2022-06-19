Add-Type -AssemblyName System.IO.Compression.FileSystem
Set-PSDebug -strict # catch a few extra bugs

$backuppath = "D:\Bruce\iSHaRe\iSHaRe Deployment\Local Auto Deployment"
$deploymentpath = "D:\Bruce\iSHaRe\Local Test Release\WebPortal"
$sourcepath = $backuppath

$backupfolder = "WebPortal_"+(Get-Date -format yyyyMMdd_hhmmss)

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
if(Test-Path "$sourcepath\WebPortal") {Remove-Item "$sourcepath\WebPortal" -Force -Recurse}
Unzip "$sourcepath\WebPortal.zip" $sourcepath
Output "Unzip source files completed"

########################### Delete all files in deployment folder ##########################
Remove-Item "$deploymentpath\*" -Force -Recurse -Exclude "*.log"
Output "Delete all files in folder $deploymentpath completed"

########################### Copy files from source folder to destination folder ##########################
Copy-Item  "$sourcepath\WebPortal\*" $deploymentpath -Force -Recurse -Exclude "*.log"
Output "Copy files from folder $sourcepath\WebPortal to folder $deploymentpath completed"

########################### Restore configure files from backup folder ##########################
Copy-Item  "$backuppath\$backupfolder\Web.config" $deploymentpath
Copy-Item  "$backuppath\$backupfolder\Logs\log4net.config" "$deploymentpath\Logs"
Output "Restore configuration files completed"

########################### Upgrade jsVersion in web.config file ##########################
$WebConfig = "$deploymentpath\web.config"
# Extract jsVersion number
$jsVersion = [Convert]::ToInt32(((Get-Content $WebConfig) -match "jsVersion").split('v`"')[5])
Output "Existing jsVersion:$jsVersion"
# Upgrade jsVersion number
$jsVersionUpgraded = $jsVersion + 1
Output "New jsVersion:$jsVersionUpgraded"
$oldString = "v"+[string]$jsVersion
$newString = "v"+[string]$jsVersionUpgraded
(Get-Content $WebConfig) | Foreach-Object {$_ -replace $oldString ,$newString} | Set-Content $WebConfig
Output "Update web.config successfully"

Output "Deployment completed!"
Pause