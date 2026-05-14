#!/bin/bash

set -euo pipefail

OUTPUT_DIR="output/summary_report.txt"

mkdir -p output
echo "Generating summary report..."
echo ""

{
    echo "RISC-V Log Analyze- Summary Report"
    echo "generated $(date '+%Y-%m-%dT%H:%M:%S%')"
    echo ""
} > "$OUTPUT_DIR"

for logfile in test_data/*.log; do
    echo "Processing $logfile..."
    {
        echo "log file: $logfile"

    }>> "$OUTPUT_DIR"

    bash scripts/analyze_log.sh "$logfile" >> "$OUTPUT_DIR"
    echo "" >> "$OUTPUT_DIR"    
done

echo""
echo "Summary report generated at $OUTPUT_DIR"






























