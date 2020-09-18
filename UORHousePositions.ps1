<#
.SYNOPSIS
  A small script to pull down the latest UOR house positions
  and generate an UOAM house file
.NOTES
  Version:        1.1
  Author:         Quick - updated by Chadarius (AKA Solomon)
  Creation Date:  4/2/2018  
  Updated:        09/14/2020
#>

# Modify this value to point 
$HousesFile = "C:\UORenaissance\ClassicUO\Data\Client\UORHouses.csv"

# Set the offsets for each out
$HouseOffsets = @{
    "castle"          = "0,-5";
    "fortress"        = "0,-5";
    "keep"            = "0,-5";
    "large house"     = "0,-5";
    "log cabin"       = "0,-5";
    "marble patio"    = "0,-5";
    "marble shop"     = "0,-5";
    "patio house"     = "0,-5";
    "sandstone patio" = "0,-6";
    "small house"     = "0,-5";
    "small tower"     = "0,-5";
    "stone shop"      = "0,-5";
    "tower"           = "0,-5";
    "two story house" = "0,-5";
    "villa"           = "0,-5";
}

try {
    # Get the current housing positions from the UOR master list
    Write-Host "Getting latest house list from UOR"
    $CurrentHousePositions = Invoke-WebRequest -Uri "http://www.uorenaissance.com/map/house.txt" -UseBasicParsing

    # Create a blank file or clear out the existing and set it in the UOAM format
    # UOAM does not like it if you don't use ANSI format on file
    Write-Host "Generating an empty $($HousesFile).."
    "3" | Out-File -FilePath $HousesFile -Encoding ASCII

    # Keep count, why not?
    $HouseCount = 0

    Write-Host "Offsetting each X and Y position to display correctly on the World Map. This may take a moment."
    # Loop through each house position, use the key above to adjust the position value
    foreach ($CurrentHouse in $CurrentHousePositions.Content.Split("`n`r")) {  

        if ($CurrentHouse.Length -gt 0 -And $CurrentHouse.Contains(":")) {
            # Grab the type of house and current position on map            
            $HouseType = $CurrentHouse.Substring(1, $CurrentHouse.IndexOf(":") - 1)
            $HousePosition = $CurrentHouse.Substring($CurrentHouse.IndexOf(":") + 2).Split(" ")

            # Find the reference above to get offset position modifiers
            $HouseOffsetPosition = $HouseOffsets."$($HouseType)".Split(",")

            # Update the position of the house based on the table above
            $NewXPosition = [int]$HousePosition[0] + [int]$HouseOffsetPosition[0]
            $NewYPosition = [int]$HousePosition[1] + [int]$HouseOffsetPosition[1]

            # Output the data to the file we created above
            "$NewXPosition,$NewYPosition,0,$HouseType,$HouseType,yellow,7" | Out-File -FilePath $HousesFile -Encoding ASCII -Append

            # You figure it out
            $HouseCount++
        }
    }

    Write-Host "$HousesFile was created with $HouseCount houses"
}
catch {
    Write-Host $_.Exception.Message
}


