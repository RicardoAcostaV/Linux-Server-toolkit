#!/bin/bash
function info {
    echo "----------"
    echo "Usuario: $(whoami)"
    echo "ID: $(id -u)"
    echo "Grupo: $(id -nG)"
    echo "Home: $HOME"
    echo "----------"
}


function modificar_permisos {
    echo "Ingresa los nuevos permisos"
    read NUEVOS
    chmod "$NUEVOS" "$1"
    ls -l "$1"
}


function cambiar_permisos {
    echo "Ingresa el nuevo user:"
    read USER
    echo "Ingresa el nuevo grupo:"
    read GRUPO
    sudo chown "$USUARIO":"$GRUPO" "$1"
    
}
function mostrar_permisos {
    if [ ! -e "$1" ]; then
        echo "No existe el archivo"
    else
        ls -l "$1"
        modificar_permisos "$1"
        cambiar_permisos "$1"
    fi
    
}
info
echo "Ingresa un archivo o directorio para ver permisos y propietario"
read ARCH
mostrar_permisos "$ARCH"
