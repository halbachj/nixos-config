#!/usr/bin/env bash
set -euo pipefail

state_dir="${XDG_CACHE_HOME:-$HOME/.cache}/i3status-rust"
state_file="$state_dir/disk-cycle"

mkdir -p "$state_dir"

if [[ "${1:-}" == "--next" ]]; then
  current=0
  if [[ -f "$state_file" ]]; then
    current=$(cat "$state_file" 2>/dev/null || echo 0)
  fi
  echo $((current + 1)) > "$state_file"
  exit 0
fi

entries=()
while read -r line; do
  NAME=""
  TYPE=""
  MOUNTPOINT=""
  FSTYPE=""
  LABEL=""
  eval "$line"

  if [[ -z "$MOUNTPOINT" ]]; then
    continue
  fi

  if [[ "$FSTYPE" == "btrfs" ]]; then
    label="$LABEL"
    if [[ -z "$label" ]]; then
      label=$(btrfs filesystem label "$MOUNTPOINT" 2>/dev/null || true)
    fi
    if [[ -z "$label" ]]; then
      label="$NAME"
    fi
  elif [[ "$TYPE" == "lvm" ]]; then
    label="$NAME"
  elif [[ "$TYPE" == "disk" ]]; then
    label="$NAME"
  else
    continue
  fi

  entries+=("$label|$MOUNTPOINT")
done < <(lsblk -P -o NAME,TYPE,MOUNTPOINT,FSTYPE,LABEL)

if [[ ${#entries[@]} -eq 0 ]]; then
  echo '{"icon":"disk_drive","state":"Warning","text":"no disks"}'
  exit 0
fi

index=0
if [[ -f "$state_file" ]]; then
  index=$(cat "$state_file" 2>/dev/null || echo 0)
fi

index=$((index % ${#entries[@]}))
entry="${entries[$index]}"
label="${entry%%|*}"
mount="${entry#*|}"

read -r target avail size < <(
  df -h --output=target,avail,size "$mount" | awk 'NR==2 {print $1, $2, $3}'
)

text="${label}: ${avail}/${size}"
json_escape() {
  local input="$1"
  input=${input//\\/\\\\}
  input=${input//\"/\\\"}
  input=${input//$'\n'/\\n}
  input=${input//$'\r'/\\r}
  input=${input//$'\t'/\\t}
  printf '%s' "$input"
}

echo "{\"icon\":\"disk_drive\",\"text\":\"$(json_escape "$text")\"}"
