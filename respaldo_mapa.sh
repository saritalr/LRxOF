#!/bin/bash

# Configuración
DIRECTORIO_SERVIDOR="/workspaces/LRxOF/lrxof/"
CARPETA_MUNDO="$DIRECTORIO_SERVIDOR/world"
REMOTO_RCLONE="lrdrive:"
RUTA_EN_NUBE="$REMOTO_RCLONE/mapa_mc"

echo "=== 🗂️ INICIANDO RESPALDO ==="
echo "📅 $(date)"

# Verificar si la sesión screen existe
if ! screen -list | grep -q "minecraft"; then
    echo "❌ ERROR: No hay sesión 'minecraft' activa"
    echo "   Ejecuta primero: screen -S minecraft -d -m java -jar server.jar nogui"
    exit 1
fi

echo "✅ Sesión screen 'minecraft' encontrada"

# Enviar comando de guardado
echo "💾 Enviando save-all al servidor..."
screen -S minecraft -X stuff "save-all^M"
echo "⏳ Esperando 30 segundos para guardado completo..."
sleep 30

# Sincronizar la carpeta del mundo con la nube
echo "☁️ Sincronizando con la nube..."
rclone copy -P "$CARPETA_MUNDO" "$RUTA_EN_NUBE" --create-empty-src-dirs

if [ $? -eq 0 ]; then
    echo "✅ Sincronización completada"
    # Notificar en el servidor
    screen -S minecraft -X stuff "say Mapa respaldado exitosamente.^M"
else
    echo "❌ Error en la sincronización"
    screen -S minecraft -X stuff "say Error en el respaldo del mapa.^M"
    exit 1
fi

echo "=== ✅ RESPALDO COMPLETADO: $(date) ==="