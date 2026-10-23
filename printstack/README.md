# printstack fork of Kalico

`xoxd-ai/kalico` is the printstack-owned fork of [KalicoCrew/kalico](https://github.com/KalicoCrew/kalico) for the Sovol SV06 printers (operator ruling R-FW-SPEC-20261023-a; spec in xoxd-ai/printstack PR #164, section 3.1).

| Ref | Content |
|---|---|
| `upstream` | Mirror of KalicoCrew/kalico `main`; fast-forward only, never committed to |
| `printstack` (default) | Reviewed upstream base plus printstack commits |
| `ps/<upstream-describe>/<n>` tags | printstack releases; `/0` is the image that was already flashed |

Base: `a6796621ef8abb905935a5b5c194a523a1d45a48` (`v2026.10.00-98-ga6796621`), the commit sv06-a runs (host and MCU).

Rollback image: release [`ps/v2026.10.00-98-ga679662/0`](https://github.com/xoxd-ai/kalico/releases/tag/ps/v2026.10.00-98-ga679662/0), sha256 `6f1e436e45b3edeb0b60868cc693d44ca0a24d9473282f65faa94d9ffbdc5762`.

## CI

`.github/workflows/printstack-firmware.yml` builds the SV06 MCU image with Arm GNU Toolchain 15.2.Rel1 (the toolchain recorded in the flashed image's dict):

1. the base pin, asserting its sha256 equals the archived rollback image;
2. the checked-out commit, twice, asserting both builds are identical;
3. a klippy batch config check of `config/printer-sovol-sv06-2022.cfg` against the built dict.

Images are uploaded as workflow artifacts. The workflow never flashes anything; flashing is by SD card, operator present, under its own ruling (printstack `printers/sv06-a/README.md`).

## Rebase log

| Date | Base | Note |
|---|---|---|
| 2026-10-23 | `a6796621` | Fork created at the running pin, no printstack changes to Kalico code |
