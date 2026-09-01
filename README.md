Thoyyiba adalah aplikasi E-Commerce modern berskala penuh yang dibangun menggunakan Flutter dan Firebase. Dirancang dengan UI/UX premium yang estetik, mendukung mode Gelap/Terang (Dark/Light Mode), serta memiliki fitur mutakhir seperti Magic Link Authentication (Login Tanpa Password) dan penyimpanan keranjang belanja secara Real-time.

Aplikasi ini ditujukan untuk memberikan pengalaman berbelanja tingkat tinggi dengan sistem tiering membership (seperti Explorer Tier) dan antarmuka yang sangat responsif baik di platform Mobile (Android/iOS) maupun Web.

Fitur Utama (Key Features)
Premium UI/UX: Desain antarmuka eksklusif bergaya mewah dengan tipografi elegan (Google Fonts: Nura & Inter) serta transisi animasi yang mulus.
Dark & Light Mode: Dukungan tema Gelap dan Terang yang terintegrasi penuh di seluruh halaman aplikasi.
Sistem Otentikasi Canggih (Firebase Auth):
Google Sign-In: Pendaftaran dan login instan dalam satu ketukan menggunakan akun Google.
Magic Link (Passwordless): Kemampuan login hanya menggunakan tautan ajaib yang dikirimkan ke Email, tanpa perlu menghafal password.
Email/Password Login: Otentikasi standar bawaan dengan enkripsi tinggi.
Real-time Cart & Checkout (Firestore):
Setiap data keranjang belanja dan riwayat pesanan (Orders) tersinkronisasi langsung ke Google Cloud Firestore.
Data bersifat privat (dipisah berdasarkan UID akun masing-masing), anti-hilang, dan real-time di seluruh perangkat.
Manajemen Pesanan (Order Management): Melacak riwayat pesanan (Tanggal, Lokasi, Harga, Status Pengiriman).
Sistem Keanggotaan (Membership): Penawaran tingkat berlangganan "Explorer Tier" dengan benefit eksklusif.
Teknologi yang Digunakan (Tech Stack)
Framework: Flutter (Dart)
Backend as a Service (BaaS): Firebase
Authentication: Google OAuth2, Email Link, Email/Password
Database: Cloud Firestore (NoSQL)
State Management: Flutter ValueNotifier & Firestore StreamSubscription
Penyimpanan Lokal: shared_preferences (Caching session & Email untuk Magic Link)
Cara Menjalankan Aplikasi (Getting Started)
Prasyarat
Flutter SDK (Versi terbaru)
Konfigurasi Firebase (Project sudah didaftarkan di Firebase Console).
Instalasi & Menjalankan
Kloning repository ini:
bash
git clone https://github.com/ashimumam4513-stack/Vibe-Coding---Thoyyiba-App.git
Pindah ke direktori aplikasi:
bash
cd thoyyiba_app
Unduh semua dependency:
bash
flutter pub get
Jalankan aplikasi (Pilih platform: Android / Web / iOS):
bash
flutter run
⚠️ Konfigurasi Tambahan untuk Firebase
Agar fitur otentikasi berfungsi sempurna, pastikan Anda telah mengatur hal berikut di Firebase Console:

Mengaktifkan Google Sign-in dan Email link (passwordless) di menu Authentication -> Sign-in method.
Mendaftarkan SHA-1 Fingerprint (jika ingin mengekspor aplikasi menjadi .apk Android).
Mengatur Rules (Aturan Akses) di Cloud Firestore agar data pengguna tidak terekspos.
Dibuat dengan ❤️ untuk pengalaman berbelanja yang lebih baik.
