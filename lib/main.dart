import 'package:dandani_hp/Screens/order_detail_screen.dart';
import 'package:dandani_hp/Screens/review_screen.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/registrasi_screen.dart';
import 'screens/home_screen.dart';
import 'screens/request_screen.dart';
import 'screens/select_mitra_screen.dart';
import 'screens/order_screen.dart';
import 'screens/profile_screen.dart';
import 'Screens/edit_profile_screen.dart';
import 'Screens/change_password_screen.dart';
import 'Screens/search_screen.dart';
import 'Screens/splash_screen.dart';

// Mitra
import 'Screens/mitra/register_mitra_screen.dart';
import 'Screens/mitra/mitra_bursa_screen.dart';
import 'Screens/mitra/mitra_request_detail_screen.dart';
import 'Screens/mitra/mitra_antrean_screen.dart';
import 'Screens/mitra/order_detail_screen.dart';
import 'Screens/mitra/payment_confirmation_screen.dart';
import 'Screens/mitra/profile_screen.dart';
import 'Screens/mitra/edit_shop_screen.dart';
import 'Screens/mitra/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dandanin HP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D5CE5)),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      initialRoute: '/splash', // Halaman pertama yang dibuka
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/request': (context) => const RequestRepairScreen(),
        '/select': (context) => const SelectPartnerScreen(),
        '/order': (context) => const OrdersScreen(),
        '/order-detail': (context) => const OrderDetailScreen(),
        '/review': (context) => const ReviewScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/ubah-profil': (context) => const EditProfileScreen(),
        '/ubah-sandi': (context) => const ChangePasswordScreen(),
        '/cari': (context) => const SearchScreen(),

        // Mitra
        '/register-mitra': (context) => const RegisterMitraScreen(),
        '/mitra-bursa': (context) => const MitraBursaScreen(),
        '/mitra-detail-permintaan': (context) =>
            const MitraRequestDetailScreen(),
        '/mitra-antrean': (context) => const MitraAntreanScreen(),
        '/mitra-detail-pesanan': (context) => const MitraOrderDetailScreen(),
        '/mitra-konfirmasi-pembayaran': (context) =>
            const MitraPaymentConfirmationScreen(),
        '/mitra-profil': (context) => const MitraProfileScreen(),
        '/mitra-edit-toko': (context) => const MitraEditShopScreen(),
        '/mitra-riwayat': (context) => const MitraHistoryScreen(),
        // Halaman berikutnya (misal '/home', '/tracking') cukup ditambahkan di sini
      },
    );
  }
}
