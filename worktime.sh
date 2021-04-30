journalctl --since yesterday  |grep systemd-sleep |cut -d' ' -f 1-3,7- |sed 's/resumed./Inicio\ de\ jornada/g' |sed  's/system.../Fim\ de\ jornada/g'
