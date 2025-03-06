New-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP -Force

#Variable Creation
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$LockscreenImageURL = 'https://raw.githubusercontent.com/kekkutya/bricabrac/main/lockscreen.jpg'
$ImageDestinationFolder = "c:\temp"
$LockScreenImage = "$ImageDestinationFolder\lockscreen.jpg"

#Create image directory
md $ImageDestinationFolder -erroraction silentlycontinue

#Download image file
Invoke-WebRequest $LockscreenImageURL -outfile "$LockScreenimage"

#Lockscreen Registry Keys
New-ItemProperty -Path $RegPath -Name LockScreenImagePath -Value $LockScreenImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name LockScreenImageUrl -Value $LockScreenImage -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name LockScreenImageStatus -Value 1 -PropertyType DWORD -Force | Out-Null
