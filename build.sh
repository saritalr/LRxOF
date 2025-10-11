#!/bin/bash

echo "Iniciando el Proceso de LR"

sudo apt update; sudo apt install rclone; rclone version

sudo apt install screen

clear

echo "Rclone y screen instalado, Falta configurar espera..."

# Definir rutas
ruta_archivo_config="/workspaces/LRxOF/rclone.conf"
ruta_rclone="/home/codespace/.config/rclone/"

# Verificar que el archivo de origen existe
if [ ! -f "$ruta_archivo_config" ]; then
    echo "ERROR: No existe el archivo $ruta_archivo_config"
    exit 1
fi

# Crear directorio de destino si no existe
mkdir -p "$ruta_rclone"

# Copiar el archivo
if cp "$ruta_archivo_config" "$ruta_rclone"; then
    echo "✓ Archivo copiado exitosamente"
else
    echo "✗ Error al copiar el archivo"
    exit 1
fi

# Mostrar ruta de configuración
ruta_config_rclone=$(rclone config file)
echo "La ruta de rclone esta en -> $ruta_config_rclone"

clear

echo "Rclone configurado... Instalando Server"

java -jar neo209.jar --installServer