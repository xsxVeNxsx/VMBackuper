@echo off
setlocal EnableDelayedExpansion

set /A _days=-5
set /A _counter=0
set _vmCloneName=vm_clone_%date%
set _vmSourceName=%~1

set _gdrive="gdrive.exe"
set _vmManager="F:\Installed Programs\oracle wm\VBoxManage.exe"
set _7zip="C:\Program Files\7-Zip\7z.exe"

::Create tmp snapshot
%_vmManager% snapshot %_vmSourceName% take "tmp_snapshot"

::Create clone
%_vmManager% clonevm %_vmSourceName% --name %_vmCloneName% --basefolder "%cd%" --snapshot "tmp_snapshot" --register

::Delete tmp snapshot
%_vmManager% snapshot %_vmSourceName% delete "tmp_snapshot"

::Create arhive
%_7zip% a %_vmCloneName%.zip %_vmCloneName%\* -mx=4

::Unregister and delete VM clone
%_vmManager% unregistervm %_vmCloneName% --delete

::Upload archive
%_gdrive% upload --delete --timeout 1000 %_vmCloneName%.zip

::Delete old archives
for /f "usebackq" %%i in (`PowerShell $date ^= Get-Date^; $date ^= $date.AddDays^(!_days!^)^; $date.ToString^('yyyy-MM-dd'^)`) do set _offsetDate=%%i

for /F "usebackq" %%a in (`%_gdrive% list --query "modifiedTime < '!_offsetDate!'"`) do (
    if !_counter! gtr 0 (
        %_gdrive% delete %%a
    )
    set /a _counter+=1
)