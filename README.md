# 🛒 POS System Test Automation


## 🚀 การติดตั้ง

### 1. ติดตั้ง Python และ Robot Framework
```bash
pip install -r requirements.txt
```

### 2. ติดตั้ง ChromeDriver
- ดาวน์โหลด ChromeDriver จาก [chromedriver.chromium.org](https://chromedriver.chromium.org/)
- วางไฟล์ใน PATH หรือในโฟลเดอร์โปรเจค

## 🧪 การรันเทสต์

### รันเทสต์ทั้งหมด
```bash
robot -d results Testing/
```

### รันเทสต์เฉพาะหมวดหมู่
```bash
# ทดสอบการขาย (Orders)
robot -d results Testing/order_tests/

# ทดสอบสินค้า (Products)
robot -d results Testing/products_tests/

# ทดสอบหมวดหมู่ (Categories)
robot -d results Testing/category_tests/

# ทดสอบการเข้าสู่ระบบ (Login)
robot -d results Testing/login_tests/

# ทดสอบซัพพลายเออร์ (Suppliers)
robot -d results Testing/suppliers_tests/

# ทดสอบสถานะ (Status)
robot -d results Testing/status_tests/

# ทดสอบโปรไฟล์ (Profile)
robot -d results Testing/profile_tests/
```

## ⚡ คำสั่งที่ใช้บ่อย

### ทดสอบการขาย (Orders)
```bash
# ทดสอบการขายด้วยเงินสด
robot -d results -t "TC001*" Testing/order_tests/orders.robot

# ทดสอบการขายด้วย QR Code
robot -d results -t "TC003*" Testing/order_tests/orders.robot

# ทดสอบการขายด้วยการโอนเงิน
robot -d results -t "TC002*" Testing/order_tests/orders.robot
```

### ทดสอบสินค้า (Products)
```bash
# ทดสอบการเพิ่มสินค้า
robot -d results -t "*เพิ่ม*" Testing/products_tests/products.robot

# ทดสอบการแก้ไขสินค้า
robot -d results -t "*แก้ไข*" Testing/products_tests/products.robot

# ทดสอบการลบสินค้า
robot -d results -t "*ลบ*" Testing/products_tests/products.robot
```

### ทดสอบหมวดหมู่ (Categories)
```bash
# ทดสอบการเพิ่มหมวดหมู่
robot -d results -t "*เพิ่ม*" Testing/category_tests/categories.robot

# ทดสอบการแก้ไขหมวดหมู่
robot -d results -t "*แก้ไข*" Testing/category_tests/categories.robot

# ทดสอบการลบหมวดหมู่
robot -d results -t "*ลบ*" Testing/category_tests/categories.robot
```

### ทดสอบซัพพลายเออร์ (Suppliers)
```bash
# ทดสอบการเพิ่มซัพพลายเออร์
robot -d results -t "*เพิ่ม*" Testing/suppliers_tests/suppliers.robot

# ทดสอบการแก้ไขซัพพลายเออร์
robot -d results -t "*แก้ไข*" Testing/suppliers_tests/suppliers.robot

# ทดสอบการลบซัพพลายเออร์
robot -d results -t "*ลบ*" Testing/suppliers_tests/suppliers.robot
```

### ทดสอบการเข้าสู่ระบบ (Login)
```bash
# ทดสอบการเข้าสู่ระบบสำเร็จ
robot -d results -t "*สำเร็จ*" Testing/login_tests/login.robot

# ทดสอบการเข้าสู่ระบบล้มเหลว
robot -d results -t "*ล้มเหลว*" Testing/login_tests/login.robot
```

### ทดสอบโปรไฟล์ (Profile)
```bash
# ทดสอบการแก้ไขโปรไฟล์
robot -d results -t "*แก้ไข*" Testing/profile_tests/profile.robot

# ทดสอบการเปลี่ยนรหัสผ่าน
robot -d results -t "*รหัสผ่าน*" Testing/profile_tests/profile.robot
```

### ทดสอบสถานะ (Status)
```bash
# ทดสอบการจัดการสถานะ
robot -d results Testing/status_tests/status.robot
```

## 📁 โครงสร้างโปรเจค

```
POS_/
├── Testing/                    # ไฟล์เทสต์หลัก
│   ├── order_tests/           # ทดสอบการขาย
│   ├── products_tests/        # ทดสอบสินค้า
│   ├── category_tests/        # ทดสอบหมวดหมู่
│   ├── suppliers_tests/       # ทดสอบซัพพลายเออร์
│   ├── login_tests/           # ทดสอบการเข้าสู่ระบบ
│   ├── profile_tests/         # ทดสอบโปรไฟล์
│   └── status_tests/          # ทดสอบสถานะ
├── keywords/                   # คีย์เวิร์ดสำหรับทดสอบ
│   ├── common_keywords.robot  # คีย์เวิร์ดทั่วไป
│   ├── order_sell_keywords.robot
│   ├── products_keywords.robot
│   └── ...
├── variables/                  # ตัวแปรสำหรับทดสอบ
│   ├── common_variables.robot
│   ├── order_variables.robot
│   └── ...
├── results/                    # ผลลัพธ์การทดสอบ
├── screenshots/               # ภาพหน้าจอระหว่างทดสอบ
└── requirements.txt           # ไลบรารีที่จำเป็น
```

## 🔧 การแก้ไขปัญหา

### ปัญหาที่พบบ่อย

#### 1. ChromeDriver ไม่พบ
```bash
# ตรวจสอบ ChromeDriver
chromedriver --version

# ดาวน์โหลด ChromeDriver ใหม่
# https://chromedriver.chromium.org/
```

#### 2. Element ไม่พบ
- ตรวจสอบ selector ในไฟล์ `keywords/`
- ใช้ `Capture Page Screenshot` เพื่อดูหน้าจอ
- ตรวจสอบ timing และ wait conditions

#### 3. การเข้าถึงเว็บไซต์ล้มเหลว
- ตรวจสอบ URL ใน `variables/common_variables.robot`
- ตรวจสอบการเชื่อมต่ออินเทอร์เน็ต
- ตรวจสอบว่าเว็บไซต์ทำงานอยู่

### การ Debug
```bash
# รันเทสต์พร้อม log ละเอียด
robot -d results -v LOG_LEVEL:DEBUG Testing/

# รันเทสต์เฉพาะที่ล้มเหลว
robot -d results --rerunfailed results/output.xml

# ดูผลลัพธ์ในรูปแบบ HTML
start results/report.html
```

## 📊 ดูผลลัพธ์

### เปิดรายงานผลลัพธ์
```bash
# Windows
start results/report.html

# macOS
open results/report.html

# Linux
xdg-open results/report.html
```

### ดู Log ละเอียด
```bash
# เปิด log file
start results/log.html
```

## 🏷️ Tags ที่ใช้

- `regression` - เทสต์ regression
- `ui` - เทสต์ UI
- `orders` - เทสต์การขาย
- `products` - เทสต์สินค้า
- `categories` - เทสต์หมวดหมู่
- `suppliers` - เทสต์ซัพพลายเออร์
- `login` - เทสต์การเข้าสู่ระบบ
- `profile` - เทสต์โปรไฟล์
- `status` - เทสต์สถานะ

### รันเทสต์ตาม Tags
```bash
# รันเทสต์ regression ทั้งหมด
robot -d results -i regression Testing/

# รันเทสต์ UI ทั้งหมด
robot -d results -i ui Testing/

# รันเทสต์การขายทั้งหมด
robot -d results -i orders Testing/
```



