#!/bin/bash

echo "📦 Auto-start NPM mulai..."

while true; do
    echo "🚀 Menjalankan: npm start"
    npm start

    echo "❌ npm berhenti. Restart ulang dalam 2 detik..."
    sleep 2
done
