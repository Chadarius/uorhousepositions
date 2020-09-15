# uorhousepositions
Designed for UO Renaissance - http://www.uorenaissance.com/
Forked from https://github.com/markdwags/uorhousepositions 

Simple Powershell Script to download UOR housing positions and create a ClassicUO World Map CSV map file.  This script will offset the positions provided by http://www.uorenaissance.com/map/house.txt so they display properly in UOAM.

## Instructions:

1. Download the Powershell script
2. (Optional) The script will create a file in C:\UORenaissance\ClassicUO\Data\Client\UORHouses.csv by default.  If you have ClassicUO installed elsewhere, modify the value at the top of the script to reflect the proper location.  You can also modify the name of the file that is generated. 

```powershell
$UOAMHousesFile = "C:\UORenaissance\ClassicUO\Data\Client\UORHouses.csv"
```

3. Run Powershell script (You may need to run script as an administrator)
4. After a few moments, a file will be generated as C:\UORenaissance\ClassicUO\Data\Client\UORHouses.csv
5. Copy the PNG files in the MapIcons folder to "C:\UORenaissance\ClassicUO\Data\Client\MapIcons" folder, or to whereever your ClassicUO is installed to. 
6. In ClassicUO open the World Map. By default it should load all the CSV files. If not right click on the map and mouse over the Map Marker Options menu and check to see if UORHouses.csv is listed and enabled. See more about the World Map here https://github.com/andreakarasho/ClassicUO/wiki/World-Map

## Scheduling:

To make this completely automated, you can setup a job manually in Windows Task Scheduler or you can run the following Powershell commands to create a scheduled task.  Here's an example of setting this script to run every day at 9AM.

```powershell
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden C:\Path\To\Script\UORHousePositions.ps1' 
$trigger =  New-ScheduledTaskTrigger -Daily -At 9am 
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "UOR House Map Update" -Description "Daily update of the UOR house locations for UOAM" -RunLevel Highest
```

If you set it up via the Task Scheduler, set it to run the following command:

```
Powershell.exe -NoProfile -WindowStyle Hidden C:\Path\To\Script\UORHousePositions.ps1
```
