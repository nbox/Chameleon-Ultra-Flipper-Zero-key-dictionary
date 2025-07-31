#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------
# Combined script:
# 1) Downloads all dictionaries into one "raw" file
# 2) Cleans it from comments, commas, empty lines, and duplicates
# 3) Sorts by string length from shortest to longest
# ----------------------------------------

# Output file names
RAW_OUTPUT="all_keys.dic"     # full unfiltered set
CLEAN_OUTPUT="clean_keys.dic" # final cleaned list

# Temporary directory for downloaded fragments
TMPDIR="$(mktemp -d)"

# List of raw URLs to download
URLS=(
  "https://raw.githubusercontent.com/Sil333033/Chameleon-Ultra-javascript-autopwn/main/mfc_default_keys.dic"
  "https://raw.githubusercontent.com/Proxmark/proxmark3/master/client/default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/mfc_default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/mfulc_default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/mfdes_default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/mfp_default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/iclass_default_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/iclass_elite_keys.dic"
  "https://raw.githubusercontent.com/RfidResearchGroup/proxmark3/master/client/dictionaries/t55xx_default_pwds.dic"
  "https://raw.githubusercontent.com/ikarus23/MifareClassicTool/master/Mifare%20Classic%20Tool/app/src/main/assets/key-files/extended-std.keys"
  "https://raw.githubusercontent.com/ikarus23/MifareClassicTool/master/Mifare%20Classic%20Tool/app/src/main/assets/key-files/std.keys"
  "https://raw.githubusercontent.com/will-caruana/RFID-Brute-Force/main/iClass_Other.dic"
  "https://raw.githubusercontent.com/Stepzor11/NFC_keys/main/mf_classic_dict.nfc"
  "https://flipper.pingywon.com/flipper/nfc/assets/mf_classic_dict.nfc"
  "https://flipper.pingywon.com/flipper/nfc/assets/mf_classic_dict_user.nfc"
  "https://flipper.pingywon.com/flipper/nfc/assets/Non-Prox_Keys_Only.nfc"
  "https://flipper.pingywon.com/flipper/nfc/assets/Non-RRG_Keys_Only.nfc"
  "https://git.selfmade.ninja/zer0sec/Flipper/-/raw/main/NFC/mf_classic_dict/Non-RRG_Keys_Only.nfc"
  "https://pastebin.com/raw/KWcu0ch6"
)

echo "=== Step 1: Downloading and merging ${#URLS[@]} files → '$RAW_OUTPUT' ==="
> "$RAW_OUTPUT"
for url in "${URLS[@]}"; do
  file="$TMPDIR/$(basename "${url%%\?*}")"
  echo "  • $(basename "$url")"
  curl -sSL "$url" -o "$file"
  cat "$file" >> "$RAW_OUTPUT"
  printf "\n" >> "$RAW_OUTPUT"
done

echo "=== Step 2: Cleaning and sorting '$RAW_OUTPUT' → '$CLEAN_OUTPUT' ==="

# Sed filter explanations:
#   1) s/#.*//      — remove everything after '#' (shell-style inline comments)
#   2) s/,.*//      — remove everything after ',' (leftovers after keys)
#   3) s#//.*##     — remove everything after '//' (C/C++-style comments)
#   4) s/--.*//     — remove everything after '--' (SQL-style comments)
#   5) /^[[:space:]]*$/d — remove completely empty lines
sed -e 's/#.*//' \
    -e 's/,.*//' \
    -e 's#//.*##' \
    -e 's/--.*//' \
    -e '/^[[:space:]]*$/d' \
    "$RAW_OUTPUT" \
| awk '!seen[$0]++' \
| awk '{print length, $0}' | sort -n | cut -d' ' -f2- \
> "$CLEAN_OUTPUT"

# Remove temporary files
rm -rf "$TMPDIR"

echo "=== Done! ==="
echo "Raw data:       $RAW_OUTPUT"
echo "Cleaned list:   $CLEAN_OUTPUT"
