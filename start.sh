#!/bin/bash

cd /workspaces/LRxOF/lrxof

SERVER_PROPERTIES_FILE="/workspaces/LRxOF/lrxof/server.properties"

# Obtener la IP de Tailscale
#TAILSCALE_IP=$(tailscale ip -4)

#if [ -n "$TAILSCALE_IP" ]; then
    #echo "🔄 Configurando server-ip con la IP de Tailscale: $TAILSCALE_IP"
    #sed -i 's/^server-ip=.*/#&/' "$SERVER_PROPERTIES_FILE"
    #echo "server-ip=$TAILSCALE_IP" >> "$SERVER_PROPERTIES_FILE"
    #echo "✅ server-ip configurado a $TAILSCALE_IP"
#else
    #echo "❌ No se pudo obtener la IP de Tailscale. Usando configuración por defecto."
#fi  # ⬅️ ESTA LÍNEA FALTABA

# Verificar si ya está corriendo
if screen -list | grep -q "minecraft"; then
    echo "⚠️  El servidor ya está corriendo"
    echo "Para verlo: screen -r minecraft"
    exit 1
fi

# Iniciar servidor
echo "🎮 Iniciando servidor Minecraft..."
screen -S minecraft -d -m java -Xmx16G -Xms16G -XX:+UseG1GC -XX:G1HeapRegionSize=16M -XX:G1MaxNewSizePercent=45 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1NewSizePercent=30 -jar server.jar nogui

echo "✅ Servidor iniciado en la sesión de 'screen'."
echo "📝 Para ver la consola: screen -r minecraft"
echo "📝 Para salir sin cerrar: Ctrl+A, luego D"
echo "📝 IP del servidor: $(tailscale ip)"
echo "🔁 El respaldo automático está configurado y funcionará cada 10 minutos."

echo "🔄 Iniciando el loop de 10 minutos de respaldos automáticos..."

while true; do
    sleep 600  # 600 segundos = 10 minutos (corregido de 540 a 600)
    echo "🕒 Ejecutando respaldo: $(date)"
    cd /workspaces/LRxOF
    ./respaldo_mapa.sh
    echo "⏳ Esperando 10 minutos para el próximo respaldo..."
done