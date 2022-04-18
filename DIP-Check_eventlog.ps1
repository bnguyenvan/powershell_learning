# Show event log for rebooted time.
Get-EventLog -LogName System | Where-Object {($_.EventID -eq 6009) -or ($_.EventID -eq 1074)} | Select-Object -Property Source, EventID, InstanceId, TimeGenerated, Message | Out-GridView

# Show event log for error alert in specific time
$Begin = Get-Date -Date '03/29/2022 08:00:00'
$End = Get-Date -Date '03/30/2022 17:00:00'
Get-EventLog -LogName System -EntryType Error -After $Begin -Before $End | Select-Object -Property Source, EventID, InstanceId, TimeGenerated, Message | Out-GridView

# Show event log for critical, error alert
$Begin = Get-Date -Date '03/29/2022 08:00:00'
$End = Get-Date -Date '03/30/2022 17:00:00'
get-winevent system | where {($_.LevelDisplayName -eq "Critical") -or ($_.LevelDisplayName -eq "Error")} | Select-Object -Property * | Out-GridView
get-winevent system | where {($_.LevelDisplayName -eq "Critical") -or ($_.LevelDisplayName -eq "Error")} | Select-Object -Property MachineName, ID, LevelDisplayName, TimeCreated, Message | Out-GridView