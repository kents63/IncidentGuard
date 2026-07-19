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
    echo "Total Alerts: $(wc -l < alerts/alerts.csv)"
    echo "Critical Alerts (P1): $(grep -c 'P1' alerts/alerts.csv)"
    echo "High Priority Alerts (P2): $(grep -c 'P2' alerts/alerts.csv)"
    echo "Low Priority Alerts (P3): $(grep -c 'P3' alerts/alerts.csv)"
    echo "==================================="
}
display_banner

total_alerts=0
p1_alerts=0
p2_alerts=0
p3_alerts=0


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
    echo "TicketID: $ticket"
    echo "Service: $service"
    echo "Host: $host"
    echo "Severity: $severity"
    if [ "$severity" = "P1" ]; then 
        echo "🚨 Critical Alert"
        echo "Team: Platform Operations"
        echo "Action: Escalte immediatley"
    elif [ "$severity" = "P2" ]; then
        echo "⚠️ High Priority"
        echo "Team: Support Enngineering"
        echo "Action: Investigate within SLA"
    else 
        echo "✅ Low Priority"
        echo "Team: Monitoring"
        echo "Action: Continue monitoring"
    fi   
    echo "-----------------------------------------"
done < alerts/alerts.csv
display_summary
