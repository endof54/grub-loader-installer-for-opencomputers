# GRUB Loader Installer for OpenComputers

![GNU GRUB OpenComputers](photo.png)

---

## 🇺🇦 Українська

Всім привіт! Написав простий і красивий завантажувач (Bootloader) для ПК в OpenComputers. Дуже хотілося зробити щось схоже на класичний Linux GRUB, щоб при старті комп'ютера можна було зручно обирати, звідки запускати систему, просто клацаючи стрілочками на клавіатурі.

### Що він вміє:
* 💾 **Boot from HDD (init.lua)** — запускає вашу основну систему з жорсткого диска.
* 💿 **Boot from Floppy** — завантажується з дискети (якщо треба запустити щось інше).
* 🔄 **Reboot Computer** — звичайне швидке перезавантаження комп'ютера.
* 🔌 **Power OFF** — повністю вимикає живлення ПК.
* ⌨️ **Керування** — гортаємо стрілочками `[↑ / ↓]`, запускаємо через `[ENTER]`.

### Як цим користуватися:
1. Закидаєте файл `init.lua` з цього репозиторію на свою **дискету (Floppy Disk)**.
2. Вставляєте її у комп'ютер (краще брати монітор і залізо Tier 3, щоб текст рендерився красиво).
3. Запускаєте інсталятор. Як тільки він закінчить копіювати файли, **комп'ютер сам автоматично перезавантажиться** і перед вами з'явиться готове меню GRUB.

---

## 🇬🇧 English

Hey everyone! I made a simple and clean bootloader for personal computers in OpenComputers. I wanted to replicate the classic Linux GRUB vibe, allowing you to easily choose your boot source using the keyboard arrow keys right at startup.

### Features:
* 💾 **Boot from HDD (init.lua)** — boots your main OS from the Hard Disk Drive.
* 💿 **Boot from Floppy** — boots from a floppy disk if you need to run something else.
* 🔄 **Reboot Computer** — quick and standard PC reboot.
* 🔌 **Power OFF** — completely shuts down the computer.
* ⌨️ **Controls** — navigate with `[↑ / ↓]` arrows, select with `[ENTER]`.

### How to use it:
1. Copy the `init.lua` file from this repository to your **Floppy Disk**.
2. Insert the floppy into your OpenComputers PC (Tier 3 hardware is highly recommended for clean text rendering).
3. Run the installer. Once it's done copying files, **the PC will automatically reboot** itself and bring up the GRUB menu.

---
*Створено просто для душі та красивого старту комп'ютера. Надіюсь, комусь стане в пригоді!*
