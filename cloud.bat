@echo off
setlocal enabledelayedexpansion

REM Set the drive letter to mount
set DRIVE=X:

REM Set the mount options
set OPTIONS=--vfs-cache-mode writes --allow-other

REM List the rclone config cloud storages with number order
echo Listing rclone config cloud storages:
rclone listremotes > remotes.txt
set /a count=0
for /f "delims=" %%a in (remotes.txt) do (
  set /a count+=1
  set remote[!count!]=%%a
  echo !count!. %%a
)
del remotes.txt

REM Choose a cloud storage to mount
set /p choice=Enter the number of the cloud storage to mount: 
if not defined remote[%choice%] (
  echo Invalid choice. Please enter a valid number.
  exit /b 1
)
set REMOTE=!remote[%choice%]!
cls
REM Mount the remote using rclone
echo NOTE : To unmount press "CTRL + C"
echo -------------------------------------------------------------
echo Mounting %REMOTE% to %DRIVE% ( To unmount press ctrl + c)
rclone mount %REMOTE% %DRIVE% %OPTIONS%
exit /b 0
