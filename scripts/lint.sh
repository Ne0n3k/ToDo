#!/usr/bin/env bash
set -euo pipefail
swiftformat . || true
swiftlint || true
