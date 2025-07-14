# Find all JetBrains process IDs
pids=$(pgrep -f jetbrains)

# Check if any processes were found
if [ -z "$pids" ]; then
    echo "No JetBrains processes found."
    exit 0
fi

# Print found processes
echo "Found JetBrains processes with PIDs:"
echo "$pids"

# Loop through each PID and kill it
for pid in $pids; do
    echo "Killing process $pid..."
    kill -9 "$pid"
    if [ $? -eq 0 ]; then
        echo "Successfully killed process $pid"
    else
        echo "Failed to kill process $pid"
    fi
done

echo "Done."
