#!/usr/bin/env bash
# Build the Kalico MCU image for the stock Sovol SV06 (GD32F103RET6, STM32F103
# target). Mirrors printstack scripts/build-sv06-firmware.sh. Never flashes.
#
# usage: printstack/sv06/build.sh <kalico-src> <out-dir> <name>
# Writes <out-dir>/<name>.{bin,dict,config,build.log}.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$(cd "$1" && pwd)"
mkdir -p "$2"
out="$(cd "$2" && pwd)"
name="$3"

cp "$here/kalico-sv06.config" "$src/.config"
make -C "$src" olddefconfig >/dev/null
for key in CONFIG_MACH_STM32F103=y CONFIG_STM32_FLASH_START_7000=y CONFIG_STM32_SERIAL_USART1=y \
    CONFIG_STM32F103GD_DISABLE_SWD=y CONFIG_SERIAL_BAUD=250000; do
    grep -qx "$key" "$src/.config" || { echo "ERROR: expanded config lost $key" >&2; exit 1; }
done
make -C "$src" -j"$(nproc)" >"$out/$name.build.log" 2>&1 || { tail -40 "$out/$name.build.log" >&2; exit 1; }
cp "$src/out/klipper.bin" "$out/$name.bin"
cp "$src/out/klipper.dict" "$out/$name.dict"
cp "$src/.config" "$out/$name.config"
python3 -c 'import json,sys; d=json.load(open(sys.argv[1])); print("version:", d["version"]); print("build_versions:", d["build_versions"])' "$out/$name.dict"
sha256sum "$out/$name.bin"
