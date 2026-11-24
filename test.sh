#!/bin/bash

echo "========================================"
echo "Automated Infrastructure Validation"
echo "========================================"

EXPECTED="Infrastructure Validation Successful"

echo "[TEST 1] Checking container communication..."

if RESPONSE=$(docker exec test-client wget -qO- -T 5 http://web); then
    echo "[PASS] Nginx is reachable from Alpine."
else
    echo "[FAIL] Unable to reach Nginx."
    exit 1
fi

echo "[TEST 2] Validating webpage content..."

if echo "$RESPONSE" | grep -Fq "$EXPECTED"; then
    echo "[PASS] Custom webpage content verified."
else
    echo "[FAIL] Expected content not found."
    exit 1
fi

echo "========================================"
echo "ALL TESTS PASSED"
echo "Infrastructure is functioning correctly."
echo "========================================"

exit 0