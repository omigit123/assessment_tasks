!/bin/bash

top_applications() {
    echo "Top 10 Applications by CPU and Memory Usage:"
    ps aux --sort=-%cpu | head -n 11 | awk '{print $1, $2, $3, $4, $11}'
}

network_monitoring() {
    echo "Network Monitoring:"
    echo "Number of Concurrent Connections: $(netstat -an | grep ESTABLISHED | wc -l)"
    echo "Packet Drops:"
    netstat -i | awk '{print $1, "RX packets:", $4, "TX packets:", $8}'
    echo "Network Traffic (MB):"
    ifconfig | awk '/RX packets/ {print $1, $5 / (1024*1024) " MB"}' | sed 's/:RX//'
}

disk_usage() {
    echo "Disk Usage :"
    df -h | awk '{if ($5 > 80) print $0}' | sed 's/^/High Usage: /'
}

system_load() {
    echo "System Load Average:"
    uptime
    echo "CPU Usage Breakdown:"
    mpstat | awk '$3 ~ /[0-9.]+/ {print $1,$3,$4,$5,$6,$13,$14}'
}

memory_usage() {
    echo "Memory Usage:"    free -h | awk 'NR==1{print $1, $2, $3, $4} NR==2{print $1, $2, $3, $4}'
    echo "Swap Memory Usage:"
    swapon --show | awk '{print $1, $2, $3, $4, $5}'
}

process_monitoring() {
    echo "Process Monitoring:"
    echo "Number of Active Processes: $(ps aux | wc -l)"
    echo "Top 5 Processes by CPU and Memory Usage:"
    ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $2, $3, $4, $11}'
}


service_monitoring() {
    echo "Service Monitoring:"
    services=("sshd" "nginx" "apache2" "iptables")
    for service in "${services[@]}"; do
        if systemctl is-active --quiet $service; then
            echo "$service is running"
        else
            echo "$service is NOT running"
        fi
        done
}

dashboard() {
    top_apps
    echo "--------------------------"
    network_monitoring
    echo "--------------------------"
    disk_usage
    echo "--------------------------"
    system_load
    echo "----------------------        disk_usage
        ;;
    -load)
        system_load
        ;;
    -memory)
        memory_usage
        ;;
    -process)
        process_monitoring
        ;;
    -services)
        service_monitoring
        ;;
    *)
        dashboard
        ;;
esac----"
    memory_usage
    echo "--------------------------"
    process_monitoring
    echo "--------------------------"
    service_monitoring
}

# Handling command-line switches for custom dashboard views
case "$1" in
    -cpu)
        top_apps
        ;;
    -network)
        network_monitoring
        ;;
    -disk)
        
