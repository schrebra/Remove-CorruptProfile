#allowing scripts to be ran in powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

#Checking if there is a broken profile 
#Change $_.localpath -like '*change_me*' to be TEMP of .domain
$brokenProfile = get-ciminstance -ClassName Win32_UserProfile | where {($_.Special -eq $false) -and ($_.localpath -like '*broken*')}



#Checking if the broken profile variable has a value
if ($brokenProfile -ne $null){

    #Found value writing information about what will happen next
    write-host "Removing Broken Profile..." -ForegroundColor Cyan
    start-sleep 1

    #Piping broken profile variable to be removed
    $brokenProfile | Remove-CimInstance

    #Storing broken profile variable with new data after removal
    $brokenProfile = get-ciminstance -ClassName Win32_UserProfile | where {($_.Special -eq $false) -and ($_.localpath -like '*broken*')} 


                #Checking if there is data in broken profile variable
                if ($brokenProfile -eq $null){

                #Found no new data in variable and writing status
                write-host "Removed Broken Profile Sucessfully!" -ForegroundColor Green
                start-sleep 1

                }else{

                #Found new data in variable and writing status unsuccessful
                write-host "Unable to Remove Broken Profile" -ForegroundColor Yellow
                start-sleep 1
                }
}

#Storing variable bak as wildcard search for registry entry for *.bak existence
$bak = Get-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak" -force -Verbose

#Checking if bak varibale contains data
if ($bak -eq $null){

    #No data exists for bak variable and writing information about status
    write-host "No Corrupt Registry Profile" -ForegroundColor Green
    start-sleep 1

        }else{

            #Found bak value and writing status     
            write-host "Found Corrupt Registry Profile" -ForegroundColor Yellow
            Write-host "Removing Corrupt Registry Profile..." -ForegroundColor Cyan
            start-sleep 1

            #removing any *.bak entries in registry for $bak
            Remove-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak" -force -Verbose
            start-sleep 1

            #Storing new variable for bak
            $bak = Get-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak" -force -Verbose
            start-sleep 1


                        if($bak -eq $null){

                        #data stored in bak variable does not exist, writing status 
                        write-host "Remove Registry BAK Sucessfully!" -ForegroundColor green
                        start-sleep 1

                        }else{

                        #data stored in bak variable does exist, writing status 
                        Write-host "Unable to remove BAK Registry" -ForegroundColor yellow
                        start-sleep 1
                        }

}



