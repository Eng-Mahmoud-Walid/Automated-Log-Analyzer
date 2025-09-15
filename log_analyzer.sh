#!/bin/bash

# ========================================================
# Automated Log Analyzer
# Created manually to monitor system logs and failed logins
# ========================================================

# Log directory
LOG_DIR="/var/log"

# Report file with current date
REPORT_FILE="$HOME/log_report_$(date +%Y-%m-%d).txt"

# Separator line
SEP="==================================="

# Start writing the report
echo "Log Analysis Report - $(date)" > "$REPORT_FILE"
echo "$SEP" >> "$REPORT_FILE"

# -------- Last 10 errors --------
echo -e "\nLast 10 errors:" >> "$REPORT_FILE"
echo "Extracting last 10 errors..." >> "$REPORT_FILE"
grep -i "error" "$LOG_DIR/syslog" | tail -n 10 >> "$REPORT_FILE"

# -------- Failed login attempts --------
echo -e "\nFailed login attempts:" >> "$REPORT_FILE"
echo "Checking failed login attempts..." >> "$REPORT_FILE"
grep -i "failed password" "$LOG_DIR/auth.log" | tail -n 10 >> "$REPORT_FILE"

# -------- Top 5 recurring errors --------
echo -e "\nTop 5 recurring errors:" >> "$REPORT_FILE"
echo "Analyzing most recurring errors..." >> "$REPORT_FILE"
grep -i "error" "$LOG_DIR/syslog" | awk '{print $5}' | sort | uniq -c | sort -nr | head -n 5 >> "$REPORT_FILE"

# Notify completion
echo "Log analysis completed! Report saved at $REPORT_FILE" >> "$REPORT_FILE"
notify-send "Log Analysis Completed" "Report saved to $REPORT_FILE"
