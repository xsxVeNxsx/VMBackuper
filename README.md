# VMBackuper
Simple .bat script for auto Oracle VirtualBox backuping and uploading of backup file at Google Disk
## Usage
* Chage inner variables:
  * _vmManager - path to your VBoxManage.exe in Oracle VirtualBox directory  
  * _7zip - path to your 7z.exe in 7-zip directory
  * _gdrive - path to [gdrive.exe](https://github.com/prasmussen/gdrive#installation)
* Rub VMBackuper.bat <vm_image_name>