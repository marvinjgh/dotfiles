# dotfiles

Estos son los archivos de configuración base que uso para mi ambiente de desarrollo en windows.


## Agregando los dotfiles

Abrir un PowerShell que tenga permisos de administrador.

```sh
set-executionpolicy remotesigned

# Clonar el repositorio en la carpeta de home
git clone https://github.com/marvinjgh/dotfiles ~/dotfiles
cd ~/dotfiles/windows

# Agregar symlinks a los perfiles de PowerShell
./setProfile.ps1

# Quitar apps de windows
./Clean_Win10Apps.ps1

# Git config
New-Item -ItemType SymbolicLink -Path "~/.gitconfig" -Target "${pwd}/.gitconfig"

# Windows Terminal
New-Item -ItemType SymbolicLink -Path "~/AppData/Local/PackagesM/icrosoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" -Target "${pwd}/settings.json"

# WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
New-Item -ItemType SymbolicLink -Path "~/.wslconfig" -Target "${pwd}/.wslconfig"
```