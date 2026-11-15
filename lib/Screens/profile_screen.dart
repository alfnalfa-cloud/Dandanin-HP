import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _fullName = 'Budi Santoso';
  String _phoneNumber = '0812-3456-7890';
  String _email = 'budi.santoso@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildTopAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageHeader(),
            const SizedBox(height: 18),
            _buildProfileSummaryCard(),
            const SizedBox(height: 24),
            _buildSectionLabel('PENGATURAN AKUN'),
            const SizedBox(height: 10),
            _buildAccountSettingsCard(),
            const SizedBox(height: 24),
            _buildSectionLabel('BANTUAN & REGULASI'),
            const SizedBox(height: 10),
            _buildSupportAndRegulationCard(),
            const SizedBox(height: 22),
            _buildLogoutButton(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildTopAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Dandanin HP',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 14),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xFF1E293B),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Positioned(
                right: 1,
                top: 1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFCBD5E1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(Icons.person, color: Color(0xFF475569), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profil Pelanggan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Kelola data akun dan riwayat servis Anda',
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xFFEEF2FA),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.manage_accounts_outlined,
            color: Color(0xFF1D5CE5),
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          painter: _ProfileCardDecorationPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // Foto Profil & Info Kontak
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFDbeafe),
                              width: 2.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF475569),
                            size: 40,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D5CE5),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.verified_rounded,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.sms_outlined,
                                size: 15,
                                color: Color(0xFF0F766E),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  _phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475569),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_outline_rounded,
                                size: 15,
                                color: Color(0xFF1D5CE5),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  _email,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF475569),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Statistik Servis (Total, Selesai, Berjalan)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // Total Servis
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              '3',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'TOTAL SERVIS',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF64748B),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Selesai
                      const Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 16,
                                  color: Color(0xFF0F766E),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F766E),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'SELESAI',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF64748B),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Berjalan
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1D5CE5),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1D5CE5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'BERJALAN',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF64748B),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _buildAccountSettingsCard() {
    return Container(
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
        children: [
          _buildMenuTile(
            icon: Icons.person_outline_rounded,
            iconBgColor: const Color(0xFFEBF1FF),
            iconColor: const Color(0xFF1D5CE5),
            title: 'Ubah Profil',
            subtitle: 'Perbarui nama, kontak WhatsApp & email',
            onTap: () async {
              final updated = await Navigator.pushNamed(
                context,
                '/ubah-profil',
                arguments: {
                  'name': _fullName,
                  'phone': _phoneNumber,
                  'email': _email,
                },
              ) as Map<String, String>?;

              if (updated != null) {
                setState(() {
                  _fullName = updated['name'] ?? _fullName;
                  _phoneNumber = updated['phone'] ?? _phoneNumber;
                  _email = updated['email'] ?? _email;
                });
              }
            },
          ),
          const Divider(
            height: 1,
            indent: 70,
            endIndent: 18,
            color: Color(0xFFF1F5F9),
          ),
          _buildMenuTile(
            icon: Icons.lock_reset_rounded,
            iconBgColor: const Color(0xFFEBF1FF),
            iconColor: const Color(0xFF1D5CE5),
            title: 'Ubah Kata Sandi',
            subtitle: 'Keamanan dan autentikasi login akun',
            onTap: () => Navigator.pushNamed(context, '/ubah-sandi'),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportAndRegulationCard() {
    return Container(
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
        children: [
          _buildMenuTile(
            icon: Icons.help_outline_rounded,
            iconBgColor: const Color(0xFFCCFBF1),
            iconColor: const Color(0xFF0F766E),
            title: 'Pusat Bantuan & Tanya Jawab',
            subtitle: 'FAQ estimasi biaya & garansi servis',
            onTap: () {},
          ),
          const Divider(
            height: 1,
            indent: 70,
            endIndent: 18,
            color: Color(0xFFF1F5F9),
          ),
          _buildMenuTile(
            icon: Icons.description_outlined,
            iconBgColor: const Color(0xFFEEF2FA),
            iconColor: const Color(0xFF475569),
            title: 'Syarat & Ketentuan Servis',
            subtitle: 'Perlindungan konsumen & garansi part',
            onTap: () {},
          ),
          const Divider(
            height: 1,
            indent: 70,
            endIndent: 18,
            color: Color(0xFFF1F5F9),
          ),
          _buildMenuTile(
            icon: Icons.info_outline_rounded,
            iconBgColor: const Color(0xFFEBF1FF),
            iconColor: const Color(0xFF1D5CE5),
            title: 'Tentang Dandanin HP',
            badgeText: 'Versi 1.0',
            subtitle: 'Platform lelang servis HP terpercaya',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String? badgeText,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (badgeText != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D5CE5),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: _confirmLogout,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFEE2E2)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 20),
            SizedBox(width: 8),
            Text(
              'Keluar dari Akun',
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDC2626),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Keluar dari Akun?',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        content: const Text(
          'Anda perlu masuk kembali menggunakan email dan kata sandi untuk memantau status servis.',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFF475569),
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Ya, Keluar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
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
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                isSelected: false,
                icon: Icons.home_outlined,
                label: 'Beranda',
                onTap: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
              _buildNavItem(
                isSelected: false,
                icon: Icons.explore_outlined,
                label: 'Cari',
                onTap: () => Navigator.pushReplacementNamed(context, '/cari'),
              ),
              // Tombol Tengah Ajukan
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/request'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -14),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D5CE5),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1D5CE5)
                                  .withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: const Text(
                        'Ajukan',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildNavItem(
                isSelected: false,
                icon: Icons.receipt_long_outlined,
                label: 'Pesanan',
                hasBadge: true,
                onTap: () => Navigator.pushReplacementNamed(context, '/order'),
              ),
              _buildNavItem(
                isSelected: true,
                icon: Icons.person_rounded,
                label: 'Profil',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required bool isSelected,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    final color = isSelected
        ? const Color(0xFF1D5CE5)
        : const Color(0xFF64748B);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (hasBadge)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1D5CE5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCardDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgCirclePaint = Paint()
      ..color = const Color(0xFFF1F5FB)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.12),
      56,
      bgCirclePaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.1)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.78, size.height * 0.14)
      ..lineTo(size.width * 0.86, size.height * 0.14)
      ..lineTo(size.width * 0.91, size.height * 0.24)
      ..lineTo(size.width * 0.98, size.height * 0.24);

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.98, size.height * 0.24),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
