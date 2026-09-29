#!/bin/bash

# Default log file location if not already defined
STEP_LOG_FILE="${STEP_LOG_FILE:-/output/step_build_times.log}"

# Default log file location if not already defined
STEP_LOG_FILE="${STEP_LOG_FILE:-/output/step_build_times.log}"

run_step() {
    local script_path="$1"
    local script_name
    script_name="$(basename "$script_path")"

    local banner
    banner="======================================================================
>>> STEP: ${script_name}
    Path: ${script_path}
======================================================================"

    # Print prominent header to console and log
    echo "$banner"
    echo "$banner" >> "$STEP_LOG_FILE"

    # Capture start epoch (for math) and human-readable time
    local start_epoch start_time
    start_epoch="$(date +%s)"
    start_time="$(date '+%Y-%m-%d %H:%M:%S')"
    local start_msg="[$start_time] [START]   ${script_name}"
    echo "$start_msg"
    echo "$start_msg" >> "$STEP_LOG_FILE"

    # Temporarily allow commands to fail so we can capture the exit code
    set +e
    sh "$script_path"
    local exit_code=$?
    set -e

    # Capture end epoch and human-readable time
    local end_epoch end_time
    end_epoch="$(date +%s)"
    end_time="$(date '+%Y-%m-%d %H:%M:%S')"

    # Calculate duration
    local elapsed_secs=$((end_epoch - start_epoch))
    local duration
    duration="$(printf '%02dh:%02dm:%02ds (%ds)' $((elapsed_secs / 3600)) $(( (elapsed_secs % 3600) / 60 )) $((elapsed_secs % 60)) "$elapsed_secs")"

    if [ "$exit_code" -eq 0 ]; then
        local status_msg="[$end_time] [SUCCESS] ${script_name} (Duration: ${duration}, Exit: 0)"
        echo "$status_msg"
        echo "$status_msg" >> "$STEP_LOG_FILE"
        echo "" >> "$STEP_LOG_FILE"
    else
        local status_msg="[$end_time] [FAILED]  ${script_name} (Duration: ${duration}, Exit: ${exit_code})"
        echo "$status_msg" >&2
        echo "$status_msg" >> "$STEP_LOG_FILE"
        echo "" >> "$STEP_LOG_FILE"
        return "$exit_code"
    fi
}

log_step_debug() {
    local debug_msg_text="$1"
    # get timestamp
    local debug_time
    debug_time="$(date '+%Y-%m-%d %H:%M:%S')"
    local debug_msg="[$debug_time] [DEBUG]   ${script_name}: $debug_msg_text"
    echo "$debug_msg"
    echo "$debug_msg" >> "$STEP_LOG_FILE"
}

print_env_vars() {
    # Print all environment variables to the log file
    printenv >> "$STEP_LOG_FILE"
    echo "" >> "$STEP_LOG_FILE"
}

check_environment() {
  echo "=== Checking Build Environment ==="

  # 1. Attempt to set stack to unlimited and verify
  ulimit -s unlimited 2>/dev/null || true
  CURRENT_STACK=$(ulimit -s)
  echo -n "Checking stack size limit... "
  if [ "$CURRENT_STACK" = "unlimited" ]; then
    echo "[OK] (unlimited)"
  else
    echo "[WARNING] (${CURRENT_STACK} kB). May cause internal compiler error (segfault)."
    echo "          Pass '--ulimit stack=-1:-1' to 'docker run' if this fails."
  fi

  # 2. Check for setarch binary
  echo -n "Checking for setarch utility... "
  if ! command -v setarch >/dev/null 2>&1; then
    echo "[FAIL] 'setarch' command not found."
    exit 1
  else
    echo "[OK]"
  fi

  # 3. Test if setarch -R actually works under Docker seccomp
  echo -n "Checking ASLR personality override (setarch -R)... "
  if setarch "$(uname -m)" -R true >/dev/null 2>&1; then
    echo "[OK]"
  else
    echo "[FAIL] Operation not permitted."
    echo "       Docker blocked ADDR_NO_RANDOMIZE. Start container with:"
    echo "       '--security-opt seccomp=unconfined' or '--cap-add=SYS_PTRACE'"
    exit 1
  fi

  echo "==================================="
}

