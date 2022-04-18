#####################################################################################
# This script is using for checking all running service with Startup Type Automatic #
# and start these service if not running after a reboot.			    #
#####################################################################################

# Run this command BEFORE restart server
$Filein = "$Env:userprofile\Desktop\service_running.txt"
$Fileout = "$Env:userprofile\Desktop\services_running_strim1.txt"
Get-Service | where{$_.Status -eq "Running"} | where{$_.StartType -eq "Automatic"} | select Name | Out-File -FilePath "$Filein"
get-content "$Filein" | select-object -skip 3 | Out-File -FilePath "$Fileout"


# Run this script AFTER restart srv:
$Fileout = "$Env:userprofile\Desktop\services_running_strim1.txt"
$newstreamreader = New-Object System.IO.StreamReader("$Fileout")
while ((($readeachline =$newstreamreader.ReadLine()) -ne $null) -and (($readeachline =$newstreamreader.ReadLine()) -ne ""))
#while (($readeachline =$newstreamreader.ReadLine()) -ne $null)
{
    $readeachline = $readeachline.trimend()
    $ServiceStatus = (Get-Service -Name $readeachline).status
    if($ServiceStatus -eq "Running")
    {
        Write-Host "$readeachline is $ServiceStatus"
    }
    else {
        Write-Host "Service $readeachline is $ServiceStatus"
        Write-Host "Starting service"
        $i = 1
        do {
            Start-Service $readeachline
            $ServiceStatus = (Get-Service -Name $readeachline).status
            $i++
            if($i -eq 5){break}
        }
        while ($ServiceStatus -ne "Running")
        Write-Host "$readeachline is $ServiceStatus"

    }
}