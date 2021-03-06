

function corruptProfile {

write-host ""
Write-host "Checking for Corrupt Profiles..." -ForegroundColor cyan
write-host ""
Start-Sleep 2

$BakPath = Get-ItemProperty -path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak"

if($BakPath -eq $null){
    write-host ""
    Write-host "No Corrupt Profiles Found" -ForegroundColor Magenta
    write-host ""

    }else{

        write-host "Corrupt Profile Found" -ForegroundColor Yellow
        write-host ""
        Start-Sleep 1
        Write-host "Removing Corrupt Profile..." -ForegroundColor cyan
        write-host ""
        Start-Sleep 1
        Remove-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak" -force -Verbose
        Get-WMIObject -class Win32_UserProfile -verbose  | Where {((!$_.Special)) -and (($_.LocalPath -ne "C:\users\user"))} | Remove-WMIObject -verbose
        write-host ""
        Start-Sleep 1
        Write-host "Removed Corrupt Profile" -ForegroundColor green

        }

}
cls
corruptProfile
