# dotfiles

Estos son los archivos de configuración base que uso para mi ambiente de desarrollo.

### Indice

- [Instalación de las dependencias básicas](#instalación-de-las-dependencias-básicas)
- [Agregando los archivos de configuración](#agregando-los-archivos-de-configuración)
- [WSL 1 y WSL 2](#wsl-1-y-wsl-2)

## Instalación de las dependencias básicas

La instalación está pensada para Debian o sus derivados.

```sh
sudo apt-get update && sudo apt-get install -y \
  curl \
  git \
  build-essential \
  python3-pip \
  python3-venv
```

## Agregando los archivos de configuración

Los archivos son agregados usando el comando de symlink con la opción `-f` (force).

```sh
# Clonar el repositorio en la carpeta de home
git clone https://github.com/marvinjgh/dotfiles ~/dotfiles

# Crea los symlinks para varios dotfiles.
mkdir -p ~/.local/bin \
  && ln -fs ~/dotfiles/.bash_aliases ~/.bash_aliases \
  && ln -fs ~/dotfiles/.bashrc ~/.bashrc \
  && ln -fs ~/dotfiles/.gitconfig ~/.gitconfig \
  && ln -fs ~/dotfiles/.profile ~/.profile
```

## WSL 1 y WSL 2

Para la instalación y actualización de WSL revisar la [documentación](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

Para cambiar la carpeta donde se montan los discos `/mnt/c` o `/mnt/d`, a `/c` o `/d` se debe agregar  el archivo `/etc/wsl.conf` y reiniciar para activar los cambios.

```sh
sudo ln -fs ~/dotfiles/etc/wsl.conf /etc/wsl.conf
```