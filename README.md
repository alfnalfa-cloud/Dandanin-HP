📱 Dandanin HP
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white)
![UI Design](https://img.shields.io/badge/UI%2FUX-Material%203-1D5CE5?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-0F766E?style=flat-square)
Dandanin HP adalah aplikasi mobile marketplace dan sistem lelang (bidding) jasa perbaikan smartphone berbasis Flutter. Aplikasi ini mempertemukan Pelanggan yang membutuhkan perbaikan perangkat dengan Mitra Service (Konter & Teknisi Terverifikasi) secara transparan, dilengkapi pelacakan progres servis real-time dan sistem pembayaran tunai langsung di toko (Cash on Pickup).
---
✨ Fitur Utama
🔐 Autentikasi & Portal Multi-Peran
Animated Splash Screen (`splash_screen.dart`): Halaman pembuka beranimasi (scale-bounce, gelombang radar, dan latar sirkuit) sebelum masuk ke layar login.
Unified Login Multi-Peran (`login_screen.dart`): Satu pintu masuk terpadu dengan pemilih peran interaktif antara Pelanggan dan Mitra Service.
Registrasi Terpisah (`registrasi_screen.dart` & `mitra/register_mitra_screen.dart`): Pendaftaran cepat untuk pelanggan serta portal registrasi khusus mitra lengkap dengan tiket verifikasi, deteksi lokasi GPS, jam operasional, dan unggah foto meja servis.
👤 Sisi Pelanggan (Customer)
Beranda & Pencarian Mitra (`home_screen.dart` & `search_screen.dart`): Eksplorasi layanan perbaikan serta pencarian konter servis terdekat berdasarkan kategori kerusakan.
Pengajuan Perbaikan & Pilih Penawaran (`request_screen.dart` & `select_mitra_screen.dart`): Mengirimkan detail perangkat, deskripsi kerusakan, dan foto kondisi unit ke bursa untuk dibandingkan penawaran harga serta garansinya.
Pelacakan Servis & Ulasan (`order_screen.dart`, `order_detail_screen.dart`, & `review_screen.dart`): Pemantauan progres pengerjaan 4 tahap secara real-time, pelunasan tunai di konter, serta pemberian rating dan ulasan.
Manajemen Akun (`profile_screen.dart`, `edit_profile_screen.dart`, & `change_password_screen.dart`): Pengaturan data profil pelanggan dan pembaruan kata sandi.
🛠️ Sisi Mitra Service (Teknisi & Konter)
Bursa Permintaan (`mitra/mitra_bursa_screen.dart`): Ringkasan Repair Flow Hari Ini, pengaturan radius penerimaan order, filter kategori kerusakan, dan daftar tiket permintaan terbuka.
Detail Permintaan & Kirim Penawaran (`mitra/mitra_request_detail_screen.dart`): Inspeksi 3 lampiran foto fisik unit (zoom pratinjau) serta formulir penawaran biaya, estimasi waktu pengerjaan, dan jaminan garansi toko.
Antrean Servis Toko (`mitra/mitra_antrean_screen.dart`): Manajemen dua tab (Menunggu Keputusan dan Aktif Diproses) lengkap dengan progress bar meja teknisi.
Detail Pesanan & Pembaruan Tahapan (`mitra/order_detail_screen.dart`): Kontrol pembaruan 4 tahapan servis yang tersinkronisasi ke layar pelanggan beserta catatan perkembangan dengan template cepat.
Konfirmasi Pembayaran & Nota Fisik (`mitra/payment_confirmation_screen.dart`): Panduan serah terima unit di etalase toko, validasi penerimaan uang tunai, rincian nota kerja, dan pratinjau cetak nota thermal.
Riwayat Servis & Garansi (`mitra/history_screen.dart`): Rekap pendapatan tunai bulanan, filter status garansi (Garansi Aktif, Garansi Selesai, Dibatalkan), dan nota digital.
Profil Toko & Pengaturan Lokasi (`mitra/profile_screen.dart` & `mitra/edit_shop_screen.dart`): Statistik performa dan reputasi toko, ulasan pelanggan terverifikasi, katalog spesialisasi layanan, jadwal buka, serta pembaruan titik koordinat GPS.
---
📂 Struktur Direktori
```text
lib/
├── main.dart                                  # Konfigurasi tema, initialRoute, dan seluruh rute aplikasi
└── Screens/
    ├── mitra/                                 # Modul khusus Mitra Service (Konter & Teknisi)
    │   ├── edit_shop_screen.dart              # Edit identitas toko, foto booth & titik koordinat GPS
    │   ├── history_screen.dart                # Riwayat transaksi, rekap pendapatan & status garansi
    │   ├── mitra_antrean_screen.dart          # Daftar penawaran tertunda & antrean servis aktif
    │   ├── mitra_bursa_screen.dart            # Beranda Mitra: Bursa permintaan & statistik harian
    │   ├── mitra_request_detail_screen.dart   # Detail keluhan unit & formulir penawaran harga
    │   ├── order_detail_screen.dart           # Pembaruan 4 tahapan servis & catatan teknisi
    │   ├── payment_confirmation_screen.dart   # Konfirmasi pembayaran tunai & pratinjau nota fisik
    │   ├── profile_screen.dart                # Profil toko, reputasi, ulasan & pengaturan konter
    │   └── register_mitra_screen.dart         # Halaman pendaftaran & verifikasi Mitra baru
    ├── change_password_screen.dart            # Ubah kata sandi akun
    ├── edit_profile_screen.dart               # Edit data profil pelanggan
    ├── home_screen.dart                       # Beranda utama sisi Pelanggan
    ├── login_screen.dart                      # Halaman masuk terpadu (Pelanggan & Mitra Service)
    ├── order_detail_screen.dart               # Detail & pelacakan 4 tahap servis sisi Pelanggan
    ├── order_screen.dart                      # Daftar pesanan aktif & riwayat servis Pelanggan
    ├── profile_screen.dart                    # Halaman profil akun Pelanggan
    ├── registrasi_screen.dart               # Halaman pendaftaran akun baru Pelanggan
    ├── request_screen.dart                    # Form pengajuan keluhan & kerusakan HP
    ├── review_screen.dart                     # Halaman pemberian rating & ulasan servis
    ├── search_screen.dart                     # Pencarian konter servis & layanan
    ├── select_mitra_screen.dart               # Perbandingan & pemilihan penawaran dari Mitra
    └── splash_screen.dart                     # Animasi pembuka aplikasi (Splash Screen)
```
---
🧭 Peta Rute Navigasi
Rute	Halaman	Peran
`/splash`	`SplashScreen`	Umum (Pembuka)
`/login`	`LoginScreen`	Umum (Pelanggan & Mitra)
`/register`	`RegisterScreen`	Pelanggan
`/home`	`HomeScreen`	Pelanggan
`/search`	`SearchScreen`	Pelanggan
`/request`	`RequestScreen`	Pelanggan
`/select-mitra`	`SelectMitraScreen`	Pelanggan
`/orders`	`OrderScreen`	Pelanggan
`/order-detail`	`OrderDetailScreen`	Pelanggan
`/review`	`ReviewScreen`	Pelanggan
`/profile`	`ProfileScreen`	Pelanggan
`/edit-profile`	`EditProfileScreen`	Pelanggan
`/change-password`	`ChangePasswordScreen`	Pelanggan
`/register-mitra`	`RegisterMitraScreen`	Mitra Service
`/mitra-bursa`	`MitraBursaScreen`	Mitra Service
`/mitra-detail-permintaan`	`MitraRequestDetailScreen`	Mitra Service
`/mitra-antrean`	`MitraAntreanScreen`	Mitra Service
`/mitra-detail-pesanan`	`MitraOrderDetailScreen`	Mitra Service
`/mitra-konfirmasi-pembayaran`	`MitraPaymentConfirmationScreen`	Mitra Service
`/mitra-riwayat`	`MitraHistoryScreen`	Mitra Service
`/mitra-profil`	`MitraProfileScreen`	Mitra Service
`/mitra-edit-toko`	`MitraEditShopScreen`	Mitra Service
---
🚀 Cara Menjalankan Proyek
Prasyarat
Flutter SDK versi `3.x` atau lebih baru
Dart SDK versi `3.x` atau lebih baru
Android Studio / Visual Studio Code dengan emulator Android, iOS Simulator, atau perangkat fisik
Langkah Instalasi
Clone repositori ini
```bash
   git clone https://github.com/alfnalfa-cloud/Dandanin-HP.git
   cd Dandanin-HP
   ```
Unduh seluruh dependensi Flutter
```bash
   flutter pub get
   ```
Jalankan aplikasi
```bash
   flutter run
   ```
---
👨‍💻 Pengembang
Alifian Deas Isworo — Program Studi Informatika, Universitas Islam Negeri Profesor Kiai Haji Saifuddin Zuhri Purwokerto (UIN SAIZU)