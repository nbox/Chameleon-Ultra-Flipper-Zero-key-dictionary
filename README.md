# Chameleon-Ultra-Flipper-Zero-key-dictionary


**Collects and prepares a unified key dictionary for Chameleon Ultra and Flipper Zero**

---

## 📌 Purpose

Chameleon Ultra and Flipper Zero can emulate, read, write, and brute-force a wide range of RFID/NFC cards: MIFARE Classic 1K/2K/4K, MIFARE Ultralight, NTAG210–218, MIFARE DESFire EV1/EV2 (partial), MIFARE Plus (limited), EM410x, T5577, HID Prox, Indala, PAC/Stanley, Keri, ioProx, Gallagher, Paradox, Presco, Viking, Noralsy, NexWatch, Jablotron, and others.

For brute-forcing protected sectors, lists of "default" and known keys — dictionaries — are often used. This script:

1. Downloads dozens of public key list files
    
2. Removes comments, empty lines, and duplicates
    
3. Sorts by key length (shorter keys first) — speeds up brute-force
    

The result is a ready-to-use `clean_keys.dic` file for your devices.

---

## 🚀 How to run

1. **Clone the repository**
    
    ```bash
    git clone https://github.com/nbox/Chameleon-Ultra-Flipper-Zero-key-dictionary.git
    cd Chameleon-Ultra-Flipper-Zero-key-dictionary
    chmod +x merge_keys.sh
    ```
    
2. **Run the build**
    
    ```bash
    ./merge_keys.sh
    ```
    
    - `all_keys.dic` — raw unprocessed set
        
    - `clean_keys.dic` — final cleaned and sorted dictionary
        
3. **Install to your device**
    
    - **Chameleon Ultra**  
        Copy `clean_keys.dic` into the `dictionaries/` folder on the device’s storage or via the GUI tool, or select manually
        
    - **Flipper Zero**  
        Copy `clean_keys.dic` into `SDCARD/flipper/nfc/assets/`, then select "User Keys" in the NFC brute-force menu.
        

---

## 📄 License

MIT — free to use and modify.
