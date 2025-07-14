#!/bin/bash

# ================================================
# 🛡️ PTERODACTYL ALL-IN-ONE PROTECT INSTALLER
# ✅ Dengan Anti-Intip Khusus Admin ID 1
# ================================================

DB_USER="root"
PANEL_DIR="/var/www/pterodactyl"
ENV_FILE="$PANEL_DIR/.env"
TARGET_FILE="$PANEL_DIR/app/Repositories/Eloquent/ServerRepository.php"
BACKUP_FILE="$TARGET_FILE.bak"

# Ambil nama DB dari .env
if [[ ! -f "$ENV_FILE" ]]; then
  echo "❌ File .env tidak ditemukan di $PANEL_DIR"
  exit 1
fi

DB=$(grep DB_DATABASE "$ENV_FILE" | cut -d '=' -f2)

if [[ -z "$DB" ]]; then
  echo "❌ Gagal membaca nama database dari .env"
  exit 1
fi

echo "📦 Menggunakan database: $DB"

# ===============================
# 1. ANTI DELETE USER & SERVER
# ===============================
echo "🔐 Memasang Anti-Delete User & Server..."
mysql -u $DB_USER <<EOF
USE $DB;
DROP TRIGGER IF EXISTS prevent_user_delete;
DROP TRIGGER IF EXISTS prevent_server_delete;
DELIMITER $$
CREATE TRIGGER prevent_user_delete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '❌ Penghapusan user diblokir!';
END$$
CREATE TRIGGER prevent_server_delete
BEFORE DELETE ON servers
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '❌ Penghapusan server diblokir!';
END$$
DELIMITER ;
EOF

# ===============================
# 2. ANTI DELETE NODE
# ===============================
echo "🛑 Memasang Anti-Delete Node..."
mysql -u $DB_USER <<EOF
USE $DB;
DROP TRIGGER IF EXISTS prevent_node_delete;
DELIMITER $$
CREATE TRIGGER prevent_node_delete
BEFORE DELETE ON nodes
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '❌ Penghapusan node diblokir!';
END$$
DELIMITER ;
EOF

# ===============================
# 3. ANTI DELETE EGG
# ===============================
echo "🥚 Memasang Anti-Delete Egg..."
mysql -u $DB_USER <<EOF
USE $DB;
DROP TRIGGER IF EXISTS prevent_egg_delete;
DELIMITER $$
CREATE TRIGGER prevent_egg_delete
BEFORE DELETE ON eggs
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '❌ Penghapusan egg diblokir!';
END$$
DELIMITER ;
EOF

# ===============================
# 4. ANTI EDIT SETTINGS
# ===============================
echo "⚙️ Memasang Anti-Edit Settings..."
mysql -u $DB_USER <<EOF
USE $DB;
DROP TRIGGER IF EXISTS prevent_setting_edit;
DELIMITER $$
CREATE TRIGGER prevent_setting_edit
BEFORE UPDATE ON settings
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '❌ Perubahan setting diblokir!';
END$$
DELIMITER ;
EOF

# ===============================
# 5. ANTI INTIP UNTUK ADMIN ID ≠ 1
# ===============================
echo "🕶️ Memasang Anti-Intip Panel (khusus ID 1)..."

if [[ ! -d "$PANEL_DIR" ]]; then
  echo "❌ Panel tidak ditemukan di $PANEL_DIR"
  exit 1
fi

# Backup jika belum ada
if [[ ! -f "$BACKUP_FILE" ]]; then
  cp "$TARGET_FILE" "$BACKUP_FILE"
  echo "📦 Backup dibuat: $BACKUP_FILE"
fi

# Hindari injeksi ganda
if grep -q "Anti-intip ID 1" "$TARGET_FILE"; then
  echo "⚠️ Anti-intip ID 1 sudah terpasang. Lewati."
else
  sed -i '/public function getUserServers/,/^}/c\
    public function getUserServers(User $user) {\n\
        // 🕶️ Anti-intip ID 1: hanya admin utama bisa lihat semua\n\
        if ($user->id !== 1) {\n\
            return $this->model->where("owner_id", $user->id)->get();\n\
        }\n\
        return $this->model->get();\n\
    }' "$TARGET_FILE"
  echo "✅ Anti-intip ID 1 berhasil diterapkan."
fi

# Refresh Laravel cache
cd "$PANEL_DIR"
php artisan config:clear
php artisan cache:clear
echo "♻️ Laravel cache disegarkan."

# ===============================
# ✅ SELESAI
# ===============================
echo ""
echo "✅ SEMUA PROTEKSI BERHASIL DIPASANG!"
echo "📌 Jangan lupa cek panel Anda."