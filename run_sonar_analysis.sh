#!/bin/bash

# SonarQube Local Analysis Script
# This script runs SonarQube analysis on your local code before pushing to GitHub

echo "Starting SonarQube analysis..."

# Check if sonar-scanner is installed
if ! command -v sonar-scanner &> /dev/null
then
    echo "sonar-scanner is not installed."
    echo "Please install it first by following the instructions in SONARQUBE_SETUP.md"
    exit 1
fi

# Check if token is set
if [ -z "$SONAR_TOKEN" ]; then
    echo "Error: SONAR_TOKEN environment variable is not set"
    echo ""
    echo "To set your token:"
    echo "1. Go to SonarCloud > Account > Security > Generate Token"
    echo "2. Run: export SONAR_TOKEN=your_token_here"
    echo "3. Or run: ./run_sonar_analysis.sh YOUR_TOKEN_HERE"
    echo ""
    
    if [ ! -z "$1" ]; then
        echo "Using token from command line argument..."
        SONAR_TOKEN=$1
    else
        exit 1
    fi
fi

# Run the analysis
echo "Running SonarQube Scanner..."
sonar-scanner \
  -Dsonar.projectKey=Fusion_System_Admin \
  -Dsonar.organization=anupamsingh2004 \
  -Dsonar.sources=Backend/backend/api/views.py \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.login=$SONAR_TOKEN

echo "Analysis complete! Check results at: https://sonarcloud.io/dashboard?id=Fusion_System_Admin"
