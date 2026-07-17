# IncidentGuard

IncidentGuard is an automated validation projet built in Bash.
The project is designed to simulate how an operations or platform support team could reduce aleart fatigue automatically reading, classifying, and routing montoring alerts.

## Current Features
- Readss incident alerts from CSV file
- Processes alerts one at a time
- Classifies incidents by severity
- Routs alerts to the appropriate support team
- Displays the required response action
- Skips the CSV header row

##  Severity Routing 

| Severity | Classificagtion | Assigned Team | Action |
|----------|-----------------|---------------|--------|
| P1 | Critical | Platform Operations | Escalate immediately|
| P2 | High Priority | Support Engineering | Investigate within SLA |
| P3 | Low Priority | Monitoring | Continue monitoring |

## prpject Structure

```text
IncidentGuard/
├── README.md
├── alerts
│   └── alerts.csv
├── config
│   └── config.conf
├── docs
├── logs
├── scripts
│   └── incidentguard.sh
└── tests