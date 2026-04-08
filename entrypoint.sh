#!/bin/bash
set -e

echo "=== Productivity Assistant Starting ==="
echo "PORT=${PORT:-8080}"

# Start toolbox in background
echo "Starting MCP Toolbox..."
/app/toolbox --tools-file=/app/productivity_assistant/tools.yaml --port=5001 &
sleep 3
echo "Toolbox ready"

# Start ADK - /app is the parent dir, productivity_assistant is the agent sub-dir
echo "Starting ADK Web..."
exec adk web /app \
  --host=0.0.0.0 \
  --port=${PORT:-8080} \
  --no-reload
