import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _teleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool _isAgreed = false;
  int _passwordStrength = 0; // 0: Belum diisi, 1: Lemah, 2: Sedang, 3: Kuat, 4: Sangat Kuat

  @override
  void dispose() {
    _namaController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() => _passwordStrength = 0);
      return;
    }

    int strength = 1;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[0-9]').hasMatch(password)) {
      strength++;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password) && password.length >= 10) {
      strength++;
    }

    setState(() => _passwordStrength = strength);
  }

  String get _strengthLabel {
    switch (_passwordStrength) {
      case 1:
        return 'Lemah';
      case 2:
        return 'Sedang';
      case 3:
        return 'Kuat';
      case 4:
        return 'Sangat Kuat';
      default:
        return 'Belum diisi';
    }
  }

  Color get _strengthColor {
    switch (_passwordStrength) {
      case 1:
        return const Color(0xFFEF4444);
      case 2:
        return const Color(0xFFF59E0B);
      case 3:
        return const Color(0xFF2563EB);
      case 4:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFFE2E8F0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Tombol Kembali & Pill Brand "Dandanin HP"
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF2FA),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF1E293B),
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5FB),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Dandanin HP',
                          style: TextStyle(
                            color: Color(0xFF1D5CE5),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44), // Penyeimbang posisi tengah
                ],
              ),
              const SizedBox(height: 24),

              // Badge "KHUSUS PEMILIK HP"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFA7F3D0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      size: 14,
                      color: Color(0xFF065F46),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'KHUSUS PEMILIK HP',
                      style: TextStyle(
                        color: Color(0xFF065F46),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Judul & Deskripsi
              const Text(
                'Buat Akun Baru',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Daftar sebagai pelanggan untuk mendapatkan penawaran perbaikan HP terbaik dari teknisi sekitar.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF475569),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Card Form Registrasi
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Nama Lengkap
                    _buildRequiredLabel('Nama Lengkap'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _namaController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _buildInputDecoration(
                        hintText: 'Nama sesuai identitas, misal: Budi Santoso',
                        prefixIcon: Icons.badge_outlined,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2. Nomor Telepon (WhatsApp)
                    _buildRequiredLabel('Nomor Telepon (WhatsApp)'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _teleponController,
                      keyboardType: TextInputType.phone,
                      decoration: _buildInputDecoration(
                        hintText: '0812-xxxx-xxxx',
                        prefixIcon: Icons.sms_outlined,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Kotak Info WhatsApp
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCFBF1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info,
                            color: Color(0xFF0F766E),
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF115E59),
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Penting: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        'Untuk notifikasi penawaran harga & update status servis langsung dari mitra teknisi.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3. Alamat Email
                    _buildRequiredLabel('Alamat Email'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _buildInputDecoration(
                        hintText: 'emailaktif@gmail.com',
                        prefixIcon: Icons.alternate_email,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 4. Kata Sandi
                    _buildRequiredLabel('Kata Sandi'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isPasswordHidden,
                      onChanged: _updatePasswordStrength,
                      decoration: _buildInputDecoration(
                        hintText: 'Minimal 8 karakter',
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() => _isPasswordHidden = !_isPasswordHidden);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Indikator Kekuatan Sandi (4 Segmen)
                    Row(
                      children: List.generate(4, (index) {
                        final isActive = index < _passwordStrength;
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                            decoration: BoxDecoration(
                              color: isActive ? _strengthColor : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Kekuatan Sandi',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          _strengthLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: _passwordStrength > 0 ? FontWeight.w600 : FontWeight.normal,
                            color: _passwordStrength > 0
                                ? _strengthColor
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // 5. Konfirmasi Kata Sandi
                    _buildRequiredLabel('Konfirmasi Kata Sandi'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _isConfirmPasswordHidden,
                      decoration: _buildInputDecoration(
                        hintText: 'Ulangi kata sandi Anda',
                        prefixIcon: Icons.history,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordHidden
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(
                              () => _isConfirmPasswordHidden = !_isConfirmPasswordHidden,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Checkbox Syarat & Ketentuan
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _isAgreed,
                            activeColor: const Color(0xFF1D5CE5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: const BorderSide(color: Color(0xFF94A3B8), width: 1.5),
                            onChanged: (value) {
                              setState(() => _isAgreed = value ?? false);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isAgreed = !_isAgreed),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF475569),
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(text: 'Saya setuju dengan '),
                                  TextSpan(
                                    text: 'Syarat dan Ketentuan',
                                    style: TextStyle(
                                      color: Color(0xFF1D5CE5),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' serta '),
                                  TextSpan(
                                    text: 'Kebijakan Privasi',
                                    style: TextStyle(
                                      color: Color(0xFF1D5CE5),
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' Dandanin HP.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Tombol Daftar Akun Pelanggan
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D5CE5),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Daftar Akun Pelanggan',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Link "Sudah punya akun? Masuk >"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF475569),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: Color(0xFF1D5CE5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Banner Keamanan Data Pelanggan
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF99F6E4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user,
                        color: Color(0xFF0F766E),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data Pelanggan Dilindungi',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Privasi nomor handphone aman, hanya teknisi terpilih yang menerima kontak.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF475569),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredLabel(String text) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
        ),
        children: [
          TextSpan(text: text),
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Color(0xFFEF4444)),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 13.5,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFF64748B),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    );
  }
}