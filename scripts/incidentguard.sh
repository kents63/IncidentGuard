#!/bin/bash

echo "========================================="
echo "Incident Guard Script v1.0"
echo " Automated Incident Validator"
echo "========================================="

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
