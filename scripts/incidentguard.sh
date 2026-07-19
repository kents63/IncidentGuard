#!/bin/bash

display_banner() {
    echo "========================================="
    echo "Incident Guard Script v1.0"
    echo " Automated Incident Validator"
    echo "========================================="
}

display_summary() {
    echo " "
    echo "============= Summary ============="
    echo "Total Alerts Processed: $total_alerts"
    echo "Critical Alerts (P1): $p1_alerts"
    echo "High Priority Alerts (P2): $p2_alerts"
    echo "Low Priority Alerts (P3): $p3_alerts"
    echo "==================================="
}

write_log() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') INFO $message" >> logs/incidentguard.log
}

total_alerts=0
p1_alerts=0
p2_alerts=0
p3_alerts=0

display_banner

:> logs/incidentguard.log
write_log "incidentGuard Started"

echo " "
echo " System Started..."
echo " "

echo "Current User: $(whoami)"
echo "Current Dicrectory: $(pwd)"
echo "Current Date: $(date)"
echo "Operating System: $(uname)"

echo " "
echo "============= Current Alerts ============="
cat alerts/alerts.csv
while IFS=, read -r ticket service host severity; do
    if [ "$ticket" == "TicketID" ]; then
        continue
    fi
    write_log "Processing Ticket $ticket"
    ((total_alerts++))
    echo "TicketID: $ticket"
    echo "Service: $service"
    echo "Host: $host"
    echo "Severity: $severity"
    if [ "$severity" = "P1" ]; then
         ((p1_alerts++))
        echo "🚨 Critical Alert"
        echo "Team: Platform Operations"
        echo "Action: Escalte immediatley"
    elif [ "$severity" = "P2" ]; then
         ((p2_alerts++))    
        echo "⚠️ High Priority"
        echo "Team: Support Enngineering"
        echo "Action: Investigate within SLA"
    else 
        ((p3_alerts++))
        echo "✅ Low Priority"
        echo "Team: Monitoring"
        echo "Action: Continue monitoring"
    fi   
    echo "-----------------------------------------"
    write_log "Ticket $ticket classified as $severity"
done < alerts/alerts.csv
display_summary
write_log "incidentGuard Completed"
