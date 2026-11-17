# printstack fork of Kalico

`xoxd-ai/kalico` is the printstack-owned fork of [KalicoCrew/kalico](https://github.com/KalicoCrew/kalico) for the Sovol SV06 printers (operator ruling R-FW-SPEC-20261023-a; spec in xoxd-ai/printstack PR #164, section 3.1).

| Ref | Content |
|---|---|
| `upstream` | Mirror of KalicoCrew/kalico `main`; fast-forward only, never committed to |
| `printstack` (default) | Reviewed upstream base plus printstack commits |
| `ps/<upstream-describe>/<n>` tags | printstack releases; `/0` is the image that was already flashed |

Base on this branch: `488b45d5511ef76826d0b0ba64da3793d2f2dc45`, the commit KalicoCrew tag `v2026.11.00` points at (87 commits past `a6796621`, all upstream, no merges; it carries `84b3e373`, the trapq head-sentinel fix). Proposed, not running: sv06-a still runs `a6796621ef8abb905935a5b5c194a523a1d45a48` (`v2026.10.00-98-ga6796621`), host and MCU, until the attended move in printstack `docs/runbook/sv06-kalico-v2026.11.00.md` is done under operator ruling R-PLAN-20261117-ak.

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
| 2026-11-17 | `488b45d5` (`v2026.11.00`) | Branch `ps-rebase/v2026.11.00`: the printstack CI commit replayed onto the tag, no printstack changes to Kalico code; R-PLAN-20261117-ak. Not merged into `printstack` and not tagged: both are the operator's, and a push to `printstack` starts the hosted-runner workflow (see printstack PR) |
