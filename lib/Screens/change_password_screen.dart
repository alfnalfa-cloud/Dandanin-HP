import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;
  int _passwordStrength = 0;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
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
    if (RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password)) {
      strength++;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password) &&
        password.length >= 10) {
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

  void _submitNewPassword() {
    final current = _currentPasswordController.text;
    final next = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      _showError('Semua kolom kata sandi wajib diisi.');
      return;
    }
    if (next.length < 8) {
      _showError('Kata sandi baru minimal 8 karakter.');
      return;
    }
    if (next != confirm) {
      _showError('Konfirmasi kata sandi baru tidak cocok.');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Kata sandi akun berhasil diperbarui.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          children: [
            _buildSecurityInfoBanner(),
            const SizedBox(height: 18),
            _buildPasswordFormCard(),
            const SizedBox(height: 18),
            _buildTipsCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomSubmitBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xFF0F172A),
          size: 22,
        ),
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Ubah Kata Sandi',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Color(0xFF1D5CE5),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keamanan Akun Pelanggan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Gunakan kombinasi kata sandi yang unik untuk melindungi riwayat servis dan transaksi Anda.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Kata Sandi Saat Ini
          _buildRequiredLabel('Kata Sandi Saat Ini'),
          const SizedBox(height: 8),
          TextField(
            controller: _currentPasswordController,
            obscureText: _hideCurrentPassword,
            decoration: _buildInputDecoration(
              hintText: 'Masukkan kata sandi lama',
              prefixIcon: Icons.lock_outline,
              isHidden: _hideCurrentPassword,
              onToggleVisibility: () {
                setState(() => _hideCurrentPassword = !_hideCurrentPassword);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),

          // 2. Kata Sandi Baru
          _buildRequiredLabel('Kata Sandi Baru'),
          const SizedBox(height: 8),
          TextField(
            controller: _newPasswordController,
            obscureText: _hideNewPassword,
            onChanged: _updatePasswordStrength,
            decoration: _buildInputDecoration(
              hintText: 'Minimal 8 karakter',
              prefixIcon: Icons.lock_reset_rounded,
              isHidden: _hideNewPassword,
              onToggleVisibility: () {
                setState(() => _hideNewPassword = !_hideNewPassword);
              },
            ),
          ),
          const SizedBox(height: 10),

          // Indikator Kekuatan Sandi (4 Bar)
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
                'Kekuatan Sandi Baru',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                _strengthLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      _passwordStrength > 0 ? FontWeight.w600 : FontWeight.normal,
                  color: _passwordStrength > 0
                      ? _strengthColor
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 3. Konfirmasi Kata Sandi Baru
          _buildRequiredLabel('Konfirmasi Kata Sandi Baru'),
          const SizedBox(height: 8),
          TextField(
            controller: _confirmPasswordController,
            obscureText: _hideConfirmPassword,
            decoration: _buildInputDecoration(
              hintText: 'Ulangi kata sandi baru',
              prefixIcon: Icons.history,
              isHidden: _hideConfirmPassword,
              onToggleVisibility: () {
                setState(() => _hideConfirmPassword = !_hideConfirmPassword);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    final hasMinLength = _newPasswordController.text.length >= 8;
    final hasUpperAndNumber =
        RegExp(r'[A-Z]').hasMatch(_newPasswordController.text) &&
            RegExp(r'[0-9]').hasMatch(_newPasswordController.text);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7F4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kriteria Kata Sandi Aman:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F766E),
            ),
          ),
          const SizedBox(height: 10),
          _buildCriteriaItem(
            text: 'Minimal terdiri dari 8 karakter',
            isMet: hasMinLength,
          ),
          const SizedBox(height: 6),
          _buildCriteriaItem(
            text: 'Mengandung huruf kapital (A-Z) dan angka (0-9)',
            isMet: hasUpperAndNumber,
          ),
        ],
      ),
    );
  }

  Widget _buildCriteriaItem({required String text, required bool isMet}) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          size: 16,
          color: isMet ? const Color(0xFF0F766E) : const Color(0xFF64748B),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
              color: isMet ? const Color(0xFF0F172A) : const Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSubmitBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _submitNewPassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D5CE5),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline_rounded, size: 19),
              SizedBox(width: 8),
              Text(
                'Perbarui Kata Sandi',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
    required bool isHidden,
    required VoidCallback onToggleVisibility,
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
      suffixIcon: IconButton(
        icon: Icon(
          isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: const Color(0xFF64748B),
          size: 20,
        ),
        onPressed: onToggleVisibility,
      ),
      filled: true,
      fillColor: const Color(0xFFF1F5FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    );
  }
}