function cdpro {
  Set-Location D:\Projects
}
function docker-ps {
    docker ps --format "Id\t{{.ID}}\nName\t{{.Names}}\nImage\t{{.Images}}\nPorts\t{{.Ports}}\nCommand\t{{.Command}}\nCreated\t{{.CreatedAt}}\nStatus\t{{.Status}}\n"
}
function docker-psa {
    docker ps -a --format "Id\t{{.ID}}\nName\t{{.Names}}\nImage\t{{.Images}}\nPorts\t{{.Ports}}\nCommand\t{{.Command}}\nCreated\t{{.CreatedAt}}\nStatus\t{{.Status}}\n"
}
function docker-resize {
    Start-Process powershell -ArgumentList {
      wsl --shutdown
      Optimize-VHD -Path $Env:LOCALAPPDATA\Docker\wsl\data\ext4.vhdx -Mode Full
    } -verb RunAs
}
