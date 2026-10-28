#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_media_license info
PYTHONPATH=src python -m gbt_media_license check --payload '{}'
PYTHONPATH=src python -m gbt_media_license run   --payload '{}'
