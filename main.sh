#!/bin/bash
OPCIONES="Usuarios_Permisos Crear/verificar_respaldos ConexionesSSH/SCP Buscar_archivos/enlaces Monitorear_Servidor GenerarReporte Salir"
select opt in $OPCIONES; do
    case $opt in
        'Usuarios_Permisos')
            ./modules/users.sh
         exit
        ;;
        'Crear/verificar_respaldos')
        
        ;;
        'ConexionesSSH/SCP')

        ;;
        'Buscar_archivos/enlaces')

        ;;
        'Monitorear_Servido')

        ;;
        'GenerarReporte')

        ;;
        'Salir')

        ;;
    esac
done