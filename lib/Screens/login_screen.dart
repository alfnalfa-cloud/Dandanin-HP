import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isMitraLogin = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_isMitraLogin) {
      Navigator.pushReplacementNamed(context, '/mitra-bursa');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _showForgotPasswordDialog() {
    final resetEmailCtrl = TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Atur Ulang Kata Sandi',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Masukkan email terdaftar untuk menerima tautan pemulihan kata sandi akun Anda.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF475569),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: resetEmailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'nama@email.com',
                filled: true,
                fillColor: const Color(0xFFF1F5FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Tautan pemulihan kata sandi telah dikirim ke email Anda.',
                  ),
                  backgroundColor: const Color(0xFF0F766E),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D5CE5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Kirim Tautan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                children: [
                  _buildLoginCard(),
                  const SizedBox(height: 22),
                  _buildRegisterLinks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFEFF4FF),
            Color(0xFFDBEAFE),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: CustomPaint(
        painter: _LoginHeaderCircuitPainter(),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Aplikasi
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D5CE5),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1D5CE5).withValues(alpha: 0.28),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.phonelink_setup_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dandanin HP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Marketplace Servis & Teknisi Terpercaya',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Selamat Datang Kembali',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isMitraLogin
                      ? 'Masuk ke portal Mitra Service untuk kelola lelang & antrean servis.'
                      : 'Masuk untuk mengajukan perbaikan HP dan pantau progres secara real-time.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Pemilih Peran (Pelanggan / Mitra Service)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isMitraLogin = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !_isMitraLogin ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: !_isMitraLogin
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0F172A)
                                      .withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 16,
                            color: !_isMitraLogin
                                ? const Color(0xFF1D5CE5)
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Pelanggan',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: !_isMitraLogin
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: !_isMitraLogin
                                  ? const Color(0xFF1D5CE5)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isMitraLogin = true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isMitraLogin ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: _isMitraLogin
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0F172A)
                                      .withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.storefront_outlined,
                            size: 16,
                            color: _isMitraLogin
                                ? const Color(0xFF1D5CE5)
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Mitra Service',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: _isMitraLogin
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: _isMitraLogin
                                  ? const Color(0xFF1D5CE5)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Input Email
          Text(
            _isMitraLogin ? 'Email Operasional Mitra' : 'Alamat Email',
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: _isMitraLogin
                  ? 'budi.service@gmail.com'
                  : 'budi.santoso@gmail.com',
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13.5,
              ),
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: Color(0xFF64748B),
                size: 20,
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Input Kata Sandi
          const Text(
            'Kata Sandi',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: 'Masukkan kata sandi',
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13.5,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Color(0xFF64748B),
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF64748B),
                  size: 20,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Lupa Kata Sandi
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _showForgotPasswordDialog,
              child: const Text(
                'Lupa Kata Sandi?',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D5CE5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 4. Tombol Masuk Sesuai Peran
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D5CE5),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isMitraLogin
                      ? 'Masuk sebagai Mitra'
                      : 'Masuk sebagai Pelanggan',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 19),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLinks() {
    return Column(
      children: [
        // Registrasi Pelanggan
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Belum punya akun? ',
              style: TextStyle(
                fontSize: 13.5,
                color: Color(0xFF475569),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register'),
              child: const Text(
                'Daftar Sekarang',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D5CE5),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          child: Divider(height: 1, color: Color(0xFFE2E8F0)),
        ),
        // Registrasi Khusus Mitra Service
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Punya konter servis? ',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register-mitra'),
              child: const Text(
                'Daftar sebagai Mitra',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F766E),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LoginHeaderCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.28),
      68,
      circlePaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.14)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.64, size.height * 0.26)
      ..lineTo(size.width * 0.78, size.height * 0.26)
      ..lineTo(size.width * 0.86, size.height * 0.44)
      ..lineTo(size.width * 0.98, size.height * 0.44);

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.26),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.86, size.height * 0.44),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}