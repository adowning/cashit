#!/bin/bash

# Delete existing directory
rm -rf /tmp/ai

# Create fresh directory
mkdir -p /tmp/ai
mkdir -p /tmp/ai/ai

# Copy project folders with exclusions
rsync -av \
  --exclude=node_modules/ \
  --exclude=docker/ \
  --exclude=dist/ \
  --exclude=scripts/ \
  --exclude=tasks/ \
  --exclude=client/public/ \
  --exclude=client/src/assets/ \
  --exclude=.*/ \
  --exclude=server/prisma/generated/ \
  --exclude=admin/ \
  --exclude=server/prisma/schema/ \
  . /tmp/ai/ai/

# Create target schema directory
mkdir -p /tmp/ai/ai/server/prisma/schema

# Copy and rename prisma files
for file in server/prisma/schema/*.prisma; do
  if [ -f "$file" ]; then
    base=$(basename "$file" .prisma)
    cp "$file" "/tmp/ai/ai/server/prisma/schema/${base}.txt"
  fi
done

# Copy and rename vue files
find /tmp/ai/ai -type f -name "*.vue" | while read -r file; do
  base=$(basename "$file" .vue)
  dir=$(dirname "$file")
  cp "$file" "${dir}/${base}.vue.txt"
  rm "$file"
done

echo "Directory sync completed successfully"