import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textOpacity;
  late final Animation<double> _bottomOpacity;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // Controller utama untuk animasi masuk bertahap (1.4 detik)
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Controller untuk gelombang radar halus di belakang logo
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _logoScale = Tween<double>(begin: 0.45, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.40, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.30, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.30, 0.70, curve: Curves.easeIn),
      ),
    );

    _bottomOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
      ),
    );

    _entryController.forward();

    // Pindah otomatis ke LoginScreen dengan transisi halus setelah 2.8 detik
    _navigationTimer = Timer(const Duration(milliseconds: 2800), _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _entryController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        ),
        child: CustomPaint(
          painter: _SplashCircuitBackgroundPainter(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // Bagian Tengah: Logo Beranimasi + Radar Pulse
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: SizedBox(
                        width: 148,
                        height: 148,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Gelombang Radar Halus
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                final value = _pulseController.value;
                                return Container(
                                  width: 92 + (54 * value),
                                  height: 92 + (54 * value),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF1D5CE5)
                                          .withValues(alpha: (1 - value) * 0.35),
                                      width: 2,
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Lingkaran Cahaya Lembut
                            Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D5CE5)
                                    .withValues(alpha: 0.10),
                                shape: BoxShape.circle,
                              ),
                            ),

                            // Kotak Ikon Utama Dandanin HP
                            Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1D5CE5),
                                    Color(0xFF1E40AF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1D5CE5)
                                        .withValues(alpha: 0.32),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.phonelink_setup_rounded,
                                color: Colors.white,
                                size: 44,
                              ),
                            ),

                            // Badge Centang Terpercaya di Pojok Kanan Bawah Logo
                            Positioned(
                              right: 24,
                              bottom: 24,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F766E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0F172A)
                                          .withValues(alpha: 0.12),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.build_rounded,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Judul & Tagline Aplikasi
                  FadeTransition(
                    opacity: _textOpacity,
                    child: SlideTransition(
                      position: _textSlide,
                      child: Column(
                        children: [
                          const Text(
                            'Dandanin HP',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Marketplace Servis & Teknisi Terpercaya',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E3A8A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Bagian Bawah: Indikator Pemuatan Halus
                  FadeTransition(
                    opacity: _bottomOpacity,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              minHeight: 4.5,
                              backgroundColor: const Color(0xFFCBD5E1)
                                  .withValues(alpha: 0.6),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF1D5CE5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Menyiapkan portal servis...',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SplashCircuitBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final softCirclePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.14),
      95,
      softCirclePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.84),
      110,
      softCirclePaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.12)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    // Jalur sirkuit kanan atas
    final topRightPath = Path()
      ..moveTo(size.width * 0.62, size.height * 0.12)
      ..lineTo(size.width * 0.78, size.height * 0.12)
      ..lineTo(size.width * 0.86, size.height * 0.20)
      ..lineTo(size.width, size.height * 0.20);

    // Jalur sirkuit kiri bawah
    final bottomLeftPath = Path()
      ..moveTo(0, size.height * 0.80)
      ..lineTo(size.width * 0.16, size.height * 0.80)
      ..lineTo(size.width * 0.24, size.height * 0.88)
      ..lineTo(size.width * 0.38, size.height * 0.88);

    canvas.drawPath(topRightPath, linePaint);
    canvas.drawPath(bottomLeftPath, linePaint);

    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.12),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.86, size.height * 0.20),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.16, size.height * 0.80),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.24, size.height * 0.88),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}