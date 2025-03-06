$LockscreenImageURL = 'https://raw.githubusercontent.com/kekkutya/bricabrac/main/lockscreen.jpg'
$ImageDestinationFolder = "C:\temp\imagetemp"
$LockScreenImage = "$ImageDestinationFolder\lockscreen.jpg"

#Create Temp Image Directory
md $ImageDestinationFolder -erroraction silentlycontinue

#download images
Invoke-WebRequest $LockscreenImageURL -outfile "$LockScreenimage"

#Create MD5 hash from downloaded image
$blobfilehash = Get-FileHash "$LockScreenImage" | Select-Object -ExpandProperty Hash

#Create MD5 hash from local image
$localfilehash = Get-FileHash "C:\temp\lockscreen.jpg" | Select-Object -ExpandProperty Hash

#Check Registry settings
$reg1 = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath"
$reg2 = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus"
$reg3 = Get-ItemPropertyValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl"

#Cleanup Temp Image Directory
Remove-Item -Path $ImageDestinationFolder -Recurse -Force

#Compare downloaded image with local image

If (($localfilehash -eq $blobfilehash) -and ($reg2 -eq $true) -and ($reg1 -and $reg3 -eq "C:\temp\lockscreen.jpg"))
{
    Write-Output "Detected"
    exit 0
}
else {
    Write-Output "Image files outdated or missing Registry Values"
    exit 1
}
