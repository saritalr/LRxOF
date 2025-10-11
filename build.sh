#!/bin/bash

echo "Iniciando el Proceso de LR"

sudo apt update; sudo apt install rclone -y; rclone version

sudo apt install screen -y

sudo apt install cron -y

clear

echo "Rclone, screen y cron instalado, Falta configurar espera..."

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
cd ./lrxof

java -jar neo209.jar --installServer


ruta_archivo_memoria="/workspaces/LRxOF/user_jvm_args.txt"
ruta_archivo_eula="/workspaces/LRxOF/eula.txt"
ruta_server="/workspaces/LRxOF/lrxof/"

# Copiar el archivo
if cp "$ruta_archivo_memoria" "$ruta_server"; then
    echo "✓ Archivo copiado de memoria exitosamente"
else
    echo "✗ Error al copiar el archivo de memoria"
    exit 1
fi


java -jar neo209.jar nogui

java -jar server.jar nogui

# Copiar el archivo
if cp "$ruta_archivo_eula" "$ruta_server"; then
    echo "✓ Archivo copiado de memoria exitosamente"
else
    echo "✗ Error al copiar el archivo de memoria"
    exit 1
fi