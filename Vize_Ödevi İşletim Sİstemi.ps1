$Processes = @{}
Get-Process -IncludeUserName | ForEach-Object {
    $Processes[$_.Id] = $_
}


echo "TCP Daemons"
Get-NetTCPConnection | 
    Where-Object { $_.LocalAddress } |
    Select-Object LocalAddress,
        LocalPort,

        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }} |
    Sort-Object -Property LocalPort, UserName |
    Format-Table -AutoSize |  Out-File -FilePath C:\Users\FURKAN\Desktop\TCP.txt

    Get-Content -Path C:\Users\FURKAN\Desktop\TCP.txt



echo "UDP Daemons"
Get-NetUDPEndpoint | 
    Where-Object { $_.LocalAddress} |
    Select-Object LocalAddress,
        LocalPort,
       
        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }} |
    Sort-Object -Property LocalPort, UserName |
    Format-Table -AutoSize |  Out-File -FilePath C:\Users\FURKAN\Desktop\UDP.txt 


Get-Content  -Path  C:\Users\FURKAN\Desktop\UDP.txt 

