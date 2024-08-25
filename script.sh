#!/bin/bash

# Define the output file for Prometheus metrics
METRICS_FILE="/var/lib/node_exporter/textfile_collector/custom_metrics.prom"

# Create or clear the metrics file
: > $METRICS_FILE

# Example: Collect CPU load average
LOAD_AVG=$(cat /proc/loadavg | awk '{print $1}')
echo "# HELP system_load1m Load average over the last 1 minute." >> $METRICS_FILE
echo "# TYPE system_load1m gauge" >> $METRICS_FILE
echo "system_load1m $LOAD_AVG" >> $METRICS_FILE

# Example: Collect free memory
FREE_MEM=$(free -m | awk '/Mem:/ {print $4}')
echo "# HELP system_free_memory_mb Free memory in MB." >> $METRICS_FILE
echo "# TYPE system_free_memory_mb gauge" >> $METRICS_FILE
echo "system_free_memory_mb $FREE_MEM" >> $METRICS_FILE

# Example: Collect disk usage
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
echo "# HELP system_disk_usage_root Disk usage on root filesystem." >> $METRICS_FILE
echo "# TYPE system_disk_usage_root gauge" >> $METRICS_FILE
echo "system_disk_usage_root $DISK_USAGE" >> $METRICS_FILE
