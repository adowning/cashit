#!/bin/bash

# Performance Log Analysis Script
# Analyzes RTG spin performance logs and calculates averages for each optimization type

echo "🚀 RTG SPIN PERFORMANCE ANALYSIS"
echo "================================="
echo "Analyzing performance logs in ../server/performance-logs/"
echo ""

# Get the script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LOGS_DIR="$PROJECT_ROOT/server/performance-logs"

# Check if performance-logs directory exists
if [ ! -d "$LOGS_DIR" ]; then
    echo "❌ Error: $LOGS_DIR directory not found!"
    echo "Please ensure this script is in the /scripts directory of the project."
    exit 1
fi

# Initialize arrays to store execution times
declare -a original_times=()
declare -a optimized_times=()
declare -a cached_times=()

# Function to extract total execution time from log file
extract_execution_time() {
    local file="$1"
    local time=$(grep "Total Execution Time:" "$file" | head -1 | sed 's/.*Total Execution Time: \([0-9.]*\)ms.*/\1/')
    echo "$time"
}

# Function to calculate average
calculate_average() {
    local -n arr=$1
    local sum=0
    local count=${#arr[@]}
    
    if [ $count -eq 0 ]; then
        echo "0"
        return
    fi
    
    for time in "${arr[@]}"; do
        sum=$(echo "$sum + $time" | bc -l)
    done
    
    local avg=$(echo "scale=2; $sum / $count" | bc -l)
    echo "$avg"
}

# Function to calculate improvement percentage
calculate_improvement() {
    local baseline="$1"
    local optimized="$2"
    
    if [ "$baseline" = "0" ] || [ "$optimized" = "0" ]; then
        echo "0"
        return
    fi
    
    local improvement=$(echo "scale=2; (($baseline - $optimized) / $baseline) * 100" | bc -l)
    echo "$improvement"
}

# Function to find min and max values
find_min_max() {
    local -n arr=$1
    local min=""
    local max=""
    
    for time in "${arr[@]}"; do
        if [ -z "$min" ] || [ "$(echo "$time < $min" | bc -l)" -eq 1 ]; then
            min="$time"
        fi
        if [ -z "$max" ] || [ "$(echo "$time > $max" | bc -l)" -eq 1 ]; then
            max="$time"
        fi
    done
    
    echo "$min $max"
}

echo "📊 Scanning log files..."

# Process original (baseline) logs
original_count=0
for file in "$LOGS_DIR"/rtg-spin-[0-9]*.txt; do
    if [ -f "$file" ] && [[ ! "$file" =~ (cached|optimized) ]]; then
        time=$(extract_execution_time "$file")
        if [ -n "$time" ] && [ "$time" != "0" ]; then
            original_times+=("$time")
            ((original_count++))
        fi
    fi
done

# Process optimized logs
optimized_count=0
for file in "$LOGS_DIR"/rtg-spin-optimized-*.txt; do
    if [ -f "$file" ]; then
        time=$(extract_execution_time "$file")
        if [ -n "$time" ] && [ "$time" != "0" ]; then
            optimized_times+=("$time")
            ((optimized_count++))
        fi
    fi
done

# Process cached logs
cached_count=0
for file in "$LOGS_DIR"/rtg-spin-cached-*.txt; do
    if [ -f "$file" ]; then
        time=$(extract_execution_time "$file")
        if [ -n "$time" ] && [ "$time" != "0" ]; then
            cached_times+=("$time")
            ((cached_count++))
        fi
    fi
done

echo "✅ Analysis complete!"
echo ""

# Calculate averages
original_avg=$(calculate_average original_times)
optimized_avg=$(calculate_average optimized_times)
cached_avg=$(calculate_average cached_times)

# Calculate min/max values
original_min_max=$(find_min_max original_times)
optimized_min_max=$(find_min_max optimized_times)
cached_min_max=$(find_min_max cached_times)

# Extract min/max values
original_min=$(echo $original_min_max | cut -d' ' -f1)
original_max=$(echo $original_min_max | cut -d' ' -f2)
optimized_min=$(echo $optimized_min_max | cut -d' ' -f1)
optimized_max=$(echo $optimized_min_max | cut -d' ' -f2)
cached_min=$(echo $cached_min_max | cut -d' ' -f1)
cached_max=$(echo $cached_min_max | cut -d' ' -f2)

# Calculate improvements
optimized_improvement=$(calculate_improvement "$original_avg" "$optimized_avg")
cached_improvement=$(calculate_improvement "$original_avg" "$cached_avg")
cached_vs_optimized=$(calculate_improvement "$optimized_avg" "$cached_avg")

echo "📈 PERFORMANCE ANALYSIS RESULTS"
echo "==============================="
echo ""

echo "🔴 ORIGINAL (Prisma Baseline):"
echo "   Files Analyzed: $original_count"
if [ $original_count -gt 0 ]; then
    echo "   Average Time: ${original_avg}ms"
    echo "   Min Time: ${original_min}ms"
    echo "   Max Time: ${original_max}ms"
    echo "   Range: $(echo "scale=2; $original_max - $original_min" | bc -l)ms"
else
    echo "   No original log files found"
fi
echo ""

echo "🟡 OPTIMIZED (Bun.sql):"
echo "   Files Analyzed: $optimized_count"
if [ $optimized_count -gt 0 ]; then
    echo "   Average Time: ${optimized_avg}ms"
    echo "   Min Time: ${optimized_min}ms"
    echo "   Max Time: ${optimized_max}ms"
    echo "   Range: $(echo "scale=2; $optimized_max - $optimized_min" | bc -l)ms"
    echo "   Improvement vs Original: ${optimized_improvement}%"
else
    echo "   No optimized log files found"
fi
echo ""

echo "🟢 CACHED (Bun.sql + Redis):"
echo "   Files Analyzed: $cached_count"
if [ $cached_count -gt 0 ]; then
    echo "   Average Time: ${cached_avg}ms"
    echo "   Min Time: ${cached_min}ms"
    echo "   Max Time: ${cached_max}ms"
    echo "   Range: $(echo "scale=2; $cached_max - $cached_min" | bc -l)ms"
    echo "   Improvement vs Original: ${cached_improvement}%"
    echo "   Improvement vs Optimized: ${cached_vs_optimized}%"
else
    echo "   No cached log files found"
fi
echo ""

echo "🏆 PERFORMANCE SUMMARY"
echo "====================="
echo ""

# Performance comparison table
printf "%-15s %-12s %-12s %-12s %-15s\n" "Version" "Avg Time" "Min Time" "Max Time" "vs Original"
printf "%-15s %-12s %-12s %-12s %-15s\n" "---------------" "--------" "--------" "--------" "---------------"

if [ $original_count -gt 0 ]; then
    printf "%-15s %-12s %-12s %-12s %-15s\n" "Original" "${original_avg}ms" "${original_min}ms" "${original_max}ms" "baseline"
fi

if [ $optimized_count -gt 0 ]; then
    printf "%-15s %-12s %-12s %-12s %-15s\n" "Optimized" "${optimized_avg}ms" "${optimized_min}ms" "${optimized_max}ms" "-${optimized_improvement}%"
fi

if [ $cached_count -gt 0 ]; then
    printf "%-15s %-12s %-12s %-12s %-15s\n" "Cached" "${cached_avg}ms" "${cached_min}ms" "${cached_max}ms" "-${cached_improvement}%"
fi

echo ""
echo ""

# Performance targets analysis
echo "🎯 TARGET ANALYSIS"
echo "=================="
echo ""

target_time=300
if [ $cached_count -gt 0 ]; then
    if [ "$(echo "$cached_avg < $target_time" | bc -l)" -eq 1 ]; then
        echo "✅ Target Achievement: EXCELLENT"
        echo "   Cached average (${cached_avg}ms) is below 300ms target"
        margin=$(echo "scale=2; $target_time - $cached_avg" | bc -l)
        echo "   Margin: ${margin}ms under target"
    else
        echo "⚠️  Target Achievement: CLOSE"
        echo "   Cached average (${cached_avg}ms) is above 300ms target"
        margin=$(echo "scale=2; $cached_avg - $target_time" | bc -l)
        echo "   Margin: ${margin}ms over target"
    fi
else
    echo "❌ No cached performance data available"
fi

echo ""

# Recommendations
echo "💡 RECOMMENDATIONS"
echo "=================="
echo ""

if [ $cached_count -gt 0 ]; then
    cache_variance=$(echo "scale=2; $cached_max - $cached_min" | bc -l)
    if [ "$(echo "$cache_variance > 200" | bc -l)" -eq 1 ]; then
        echo "⚠️  High variance in cached performance (${cache_variance}ms range)"
        echo "   Consider investigating cache warming effectiveness"
    else
        echo "✅ Consistent cached performance (${cache_variance}ms range)"
    fi
    
    if [ "$(echo "$cached_avg < 400" | bc -l)" -eq 1 ]; then
        echo "✅ Excellent cached performance - ready for production"
    elif [ "$(echo "$cached_avg < 600" | bc -l)" -eq 1 ]; then
        echo "✅ Good cached performance - minor optimizations possible"
    else
        echo "⚠️  Cached performance needs improvement"
    fi
fi

echo ""

# Save results to file
results_file="performance_analysis_$(date +%Y%m%d_%H%M%S).txt"
{
    echo "RTG SPIN PERFORMANCE ANALYSIS RESULTS"
    echo "Generated: $(date)"
    echo ""
    echo "SUMMARY:"
    echo "Original Average: ${original_avg}ms (${original_count} samples)"
    echo "Optimized Average: ${optimized_avg}ms (${optimized_count} samples)"
    echo "Cached Average: ${cached_avg}ms (${cached_count} samples)"
    echo ""
    echo "IMPROVEMENTS:"
    echo "Optimized vs Original: ${optimized_improvement}%"
    echo "Cached vs Original: ${cached_improvement}%"
    echo "Cached vs Optimized: ${cached_vs_optimized}%"
} > "$results_file"

echo "📄 Results saved to: $results_file"
echo ""
echo "🚀 Analysis Complete!"
