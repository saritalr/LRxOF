#!/bin/bash
# install_systemd_timer.sh

SERVICE_FILE="/etc/systemd/system/minecraft-backup.service"
TIMER_FILE="/etc/systemd/system/minecraft-backup.timer"

echo "🔧 Instalando Systemd Timer para Minecraft Backup..."

# Crear archivo de servicio
sudo tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=Backup automático del mundo Minecraft
After=network.target

[Service]
Type=oneshot
User=$(whoami)
WorkingDirectory=/workspaces/LRxOF/lrxof
ExecStart=/workspaces/LRxOF/respaldo_mapa.sh
EOF

# Crear archivo timer
sudo tee $TIMER_FILE > /dev/null <<EOF
[Unit]
Description=Ejecuta backup cada 10 minutos
Requires=minecraft-backup.service

[Timer]
OnCalendar=*:0/1
AccuracySec=1min
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Recargar y activar
sudo systemctl daemon-reload
sudo systemctl enable minecraft-backup.timer
sudo systemctl start minecraft-backup.timer

echo "✅ Systemd Timer instalado"
echo "📊 Ver estado: systemctl status minecraft-backup.timer"
echo "📜 Ver logs: journalctl -u minecraft-backup.service"