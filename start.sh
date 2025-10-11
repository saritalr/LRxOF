#!/bin/bash

cd /workspaces/LRxOF/lrxof

# Verificar si ya está corriendo
if screen -list | grep -q "minecraft"; then
    echo "⚠️  El servidor ya está corriendo"
    echo "Para verlo: screen -r minecraft"
    exit 1
fi

# Iniciar servidor
echo "🎮 Iniciando servidor Minecraft..."
screen -S minecraft -d -m java -jar server.jar nogui

echo "✅ Servidor iniciado en la sesión de 'screen'."
echo "📝 Para ver la consola: screen -r minecraft"
echo "📝 Para salir sin cerrar: Ctrl+A, luego D"
echo "🔁 El respaldo automático está configurado y funcionará cada 10 minutos."