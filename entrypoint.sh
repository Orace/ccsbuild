#!/bin/bash
set -e

WORKSPACE="/tmp/workspace"
PROJECT_PATH="$GITHUB_WORKSPACE/$INPUT_PROJECT_PATH"
CONFIGURATIONS="$INPUT_CONFIGURATIONS"
CCS_CLI="/root/ti/ccs2020/ccs/eclipse/ccs-server-cli.sh"

echo "🔧 Initializing CCS workspace at $WORKSPACE"
"$CCS_CLI" -workspace "$WORKSPACE" \
    -application com.ti.ccs.apps.initialize \
    -ccs.productDiscoveryPath "/opt/ti/"

IFS=';' read -ra CONFIGS <<< "$CONFIGURATIONS"
for CONFIG in "${CONFIGS[@]}"; do
    echo "🔨 Building configuration: $CONFIG"
    "$CCS_CLI" \
        -workspace "$WORKSPACE" \
        -application com.ti.ccs.apps.projectBuild \
        -ccs.autoImport \
        -ccs.buildType full \
        -ccs.configuration "$CONFIG" \
        -ccs.locations "$PROJECT_PATH"
done

echo "✅ CCS build complete"
