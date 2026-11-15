import 'package:flutter/material.dart';

class MitraProfileScreen extends StatefulWidget {
  const MitraProfileScreen({super.key});

  @override
  State<MitraProfileScreen> createState() => _MitraProfileScreenState();
}

class _MitraProfileScreenState extends State<MitraProfileScreen> {
  String _shopName = 'Budi Phone Repair';
  String _ownerName = 'Budi Santoso';
  String _ownerRole = 'Kepala Teknisi';
  String _address = 'Jl. Margonda Raya No. 124, Depok';
  String _sinceYear = '2022';
  String _phone = '+62 812-3456-7890';
  String _email = 'budi.service@gmail.com';
  String _gpsCoordinate = '-6.3728, 106.8324';
  String _operatingHours = 'Senin - Sabtu: 09:00 - 21:00 WIB';
  String _defaultWarranty = '7 - 30 Hari Garansi Toko';

  List<String> _specializations = [
    'LCD & Touchscreen',
    'IC Power & CPU',
    'Mesin & Short',
    'Port Charger',
    'Baterai Original',
  ];

  final List<Map<String, String>> _verifiedReviews = [
    {
      'initials': 'HS',
      'name': 'Hendra Saputra',
      'device': 'Samsung Galaxy A54 • 2 hari lalu',
      'comment': '“Ganti LCD Samsung A54 cepat banget, cuma 1 jam bisa ditunggu. Warna layar jernih seperti bawaan pabrik. Teknisi ramah dan transparan harganya.”',
      'badge': 'Garansi 30 Hari Aktif',
    },
    {
      'initials': 'SR',
      'name': 'Siti Rahma',
      'device': 'iPhone 12 Pro • 5 hari lalu',
      'comment': '“Baterai iPhone saya langsung sehat 100%, pengerjaan rapi dan segel aman. Bayar cash di toko tanpa ribet.”',
      'badge': 'Kesehatan Baterai 100%',
    },
    {
      'initials': 'DA',
      'name': 'Dimas Anggoro',
      'device': 'Redmi Note 11 • 1 minggu lalu',
      'comment': '“Servis port charger Redmi Note berfungsi normal kembali. Mantap Dandanin HP!”',
      'badge': 'Penggantian Konektor Type-C',
    },
    {
      'initials': 'RF',
      'name': 'Rizky Fadillah',
      'device': 'POCO X3 Pro • 2 minggu lalu',
      'comment': '“Reball IC CPU lancar jaya, HP mati total sekarang hidup normal dan data aman semua. Teknisi komunikatif.”',
      'badge': 'Garansi Mesin 30 Hari',
    },
  ];

  Future<void> _openEditShopScreen() async {
    final result = await Navigator.pushNamed(
      context,
      '/mitra-edit-toko',
      arguments: {
        'shopName': _shopName,
        'ownerName': _ownerName,
        'address': _address,
        'sinceYear': _sinceYear,
        'phone': _phone,
        'email': _email,
        'gpsCoordinate': _gpsCoordinate,
      },
    );

    if (result is Map<String, String>) {
      setState(() {
        _shopName = result['shopName'] ?? _shopName;
        _ownerName = result['ownerName'] ?? _ownerName;
        _address = result['address'] ?? _address;
        _sinceYear = result['sinceYear'] ?? _sinceYear;
        _phone = result['phone'] ?? _phone;
        _email = result['email'] ?? _email;
        _gpsCoordinate = result['gpsCoordinate'] ?? _gpsCoordinate;
      });
    }
  }

  void _showAllReviewsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.78,
        minChildSize: 0.5,
        maxChildSize: 0.92,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Semua Ulasan Pelanggan (120)',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFF59E0B),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '4.8 / 5.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: _verifiedReviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildReviewCard(
                      _verifiedReviews[index],
                      index,
                      useLightBorder: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSpecializationsSheet() {
    final allSkills = [
      'LCD & Touchscreen',
      'IC Power & CPU',
      'Mesin & Short',
      'Port Charger',
      'Baterai Original',
      'Kamera & Speaker',
      'Software & Flashing',
      'Kaca Belakang / Housing',
    ];
    final tempSelected = List<String>.from(_specializations);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Katalog Layanan & Spesialisasi',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Pilih keahlian utama konter Anda agar muncul di filter pencarian pelanggan.',
                style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allSkills.map((skill) {
                  final active = tempSelected.contains(skill);
                  return FilterChip(
                    label: Text(skill),
                    selected: active,
                    selectedColor: const Color(0xFF1D5CE5),
                    backgroundColor: const Color(0xFFF1F5FB),
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.white : const Color(0xFF334155),
                    ),
                    onSelected: (val) {
                      setModalState(() {
                        if (val) {
                          tempSelected.add(skill);
                        } else if (tempSelected.length > 1) {
                          tempSelected.remove(skill);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() => _specializations = tempSelected);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Spesialisasi layanan toko berhasil diperbarui.',
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
                  minimumSize: const Size(double.infinity, 48),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan Spesialisasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOperationalHoursSheet() {
    String selectedHours = _operatingHours;
    String selectedWarranty = _defaultWarranty;

    final hourChoices = [
      'Senin - Sabtu: 09:00 - 21:00 WIB',
      'Setiap Hari: 09:00 - 21:00 WIB',
      'Senin - Sabtu: 08:00 - 20:00 WIB',
      'Setiap Hari: 10:00 - 22:00 WIB',
    ];

    final warrantyChoices = [
      '7 Hari Garansi Toko',
      '7 - 30 Hari Garansi Toko',
      '30 Hari Garansi Resmi Toko',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ketentuan Garansi & Jam Buka',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Jadwal Operasional Konter',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              ...hourChoices.map((h) {
                final selected = selectedHours == h;
                return GestureDetector(
                  onTap: () => setModalState(() => selectedHours = h),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEBF1FF)
                          : const Color(0xFFF1F5FB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF1D5CE5)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_unchecked_rounded,
                          size: 18,
                          color: selected
                              ? const Color(0xFF1D5CE5)
                              : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            h,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? const Color(0xFF1D5CE5)
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              const Text(
                'Standar Garansi Nota Fisik',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: warrantyChoices.map((w) {
                  final selected = selectedWarranty == w;
                  return ChoiceChip(
                    label: Text(w),
                    selected: selected,
                    selectedColor: const Color(0xFF0F766E),
                    backgroundColor: const Color(0xFFF1F5FB),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : const Color(0xFF334155),
                    ),
                    onSelected: (_) =>
                        setModalState(() => selectedWarranty = w),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _operatingHours = selectedHours;
                    _defaultWarranty = selectedWarranty;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Jam operasional & ketentuan garansi disimpan.',
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
                  minimumSize: const Size(double.infinity, 48),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan Pengaturan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPartnershipTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Row(
          children: [
            Icon(
              Icons.description_outlined,
              color: Color(0xFF1D5CE5),
              size: 22,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'SOP & Ketentuan Kemitraan',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Transparansi Penawaran: Biaya yang dikirim pada bursa bersifat final sesuai kesepakatan awal kecuali ditemukan kerusakan tambahan dengan persetujuan pelanggan.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF475569),
                height: 1.45,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2. Pembayaran Tunai di Toko: Pelunasan dilakukan langsung secara tunai (Cash) setelah pengecekan fungsi unit bersama di meja servis.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF475569),
                height: 1.45,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3. Jaminan Garansi: Mitra wajib memberikan nota fisik & garansi perbaikan sesuai durasi yang dijanjikan pada penawaran.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF475569),
                height: 1.45,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D5CE5),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Mengerti',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogoutMitra() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Keluar dari Akun Mitra?',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        content: const Text(
          'Anda akan keluar dari portal Mitra Service Resmi dan kembali ke halaman masuk.',
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
              style: TextStyle(color: Color(0xFF64748B)),
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
                borderRadius: BorderRadius.circular(12),
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

  @override
  Widget build(BuildContext context) {
    final previewReviews = _verifiedReviews.take(3).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopIdentityCard(),
            const SizedBox(height: 18),
            _buildPerformanceCard(),
            const SizedBox(height: 22),

            // Header Ulasan Pelanggan Terverifikasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ulasan Pelanggan Terverifikasi',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: _showAllReviewsSheet,
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D5CE5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 3 Kartu Ulasan Terverifikasi
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: previewReviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return _buildReviewCard(previewReviews[index], index);
              },
            ),
            const SizedBox(height: 22),

            // Kartu Pengaturan & Operasional
            _buildSettingsCard(),
            const SizedBox(height: 18),

            // Tombol Keluar dari Akun Mitra
            _buildLogoutButton(),
          ],
        ),
      ),
      bottomNavigationBar: _buildMitraBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Profil Toko',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.5,
                    height: 6.5,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F766E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Mitra Service Resmi',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
            ),
            child: const Icon(
              Icons.engineering_rounded,
              color: Color(0xFF1D5CE5),
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // Kartu 1: Identitas Budi Phone Repair
  Widget _buildShopIdentityCard() {
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
          painter: _ProfileHeaderWatermarkPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Foto Profil Teknisi dengan Badge Centang Biru
                    SizedBox(
                      width: 74,
                      height: 74,
                      child: Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF1E3A8A), Color(0xFF1D5CE5)],
                              ),
                            ),
                            child: const Icon(
                              Icons.engineering_rounded,
                              color: Colors.white,
                              size: 38,
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
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _shopName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$_ownerName ($_ownerRole)',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF475569),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 14,
                                  color: Color(0xFF1D5CE5),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Mitra Resmi Terverifikasi',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1D5CE5),
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
                const SizedBox(height: 14),

                // Bar Alamat Toko & Tahun Berdiri
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF1D5CE5),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF334155),
                            ),
                            children: [
                              TextSpan(text: '$_address • '),
                              TextSpan(
                                text: 'Sejak $_sinceYear',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
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

  // Kartu 2: Performa & Reputasi
  Widget _buildPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PERFORMA & REPUTASI',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                '4.8',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                          size: 18,
                          color: const Color(0xFFF59E0B),
                        );
                      }),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'dari 120 Ulasan Pelanggan',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF99F6E4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Color(0xFF0B6E64),
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3 Kotak Statistik
          Row(
            children: [
              _buildStatTile(
                icon: Icons.build_circle_outlined,
                iconColor: const Color(0xFF1D5CE5),
                value: '184',
                valueColor: const Color(0xFF0F172A),
                label: 'Servis Selesai',
              ),
              const SizedBox(width: 10),
              _buildStatTile(
                icon: Icons.verified_user_outlined,
                iconColor: const Color(0xFF0F766E),
                value: '98%',
                valueColor: const Color(0xFF0F766E),
                label: 'Sukses\nGaransi',
              ),
              const SizedBox(width: 10),
              _buildStatTile(
                icon: Icons.timer_outlined,
                iconColor: const Color(0xFF78350F),
                value: '45m',
                valueColor: const Color(0xFF0F172A),
                label: 'Respons\nLelang',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color iconColor,
    required String value,
    required Color valueColor,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: 104,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5FB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF475569),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kartu Ulasan Pelanggan Terverifikasi
  Widget _buildReviewCard(
    Map<String, String> review,
    int index, {
    bool useLightBorder = false,
  }) {
    final avatarColors = [
      {'bg': const Color(0xFFDBEAFE), 'text': const Color(0xFF1D5CE5)},
      {'bg': const Color(0xFFCCFBF1), 'text': const Color(0xFF0F766E)},
      {'bg': const Color(0xFFE0E7FF), 'text': const Color(0xFF3730A3)},
    ];
    final palette = avatarColors[index % avatarColors.length];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: useLightBorder
            ? Border.all(color: const Color(0xFFE2E8F0))
            : null,
        boxShadow: useLightBorder
            ? []
            : [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: palette['bg'],
                  shape: BoxShape.circle,
                ),
                child: Text(
                  review['initials']!,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: palette['text'],
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            review['name']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: Color(0xFF0F766E),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review['device']!,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (_) {
                  return const Icon(
                    Icons.star_rounded,
                    size: 14.5,
                    color: Color(0xFFF59E0B),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            review['comment']!,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1E293B),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDDF5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              review['badge']!,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0B6E64),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Kartu Pengaturan & Operasional
  Widget _buildSettingsCard() {
    final specSummary = _specializations.take(4).join(', ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PENGATURAN & OPERASIONAL',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingRow(
            icon: Icons.storefront_outlined,
            title: 'Edit Informasi Toko & Lokasi',
            subtitle: 'Alamat, foto booth, dan titik GPS',
            onTap: _openEditShopScreen,
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildSettingRow(
            icon: Icons.handyman_outlined,
            title: 'Katalog Layanan & Spesialisasi',
            subtitle: specSummary,
            onTap: _showSpecializationsSheet,
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildSettingRow(
            icon: Icons.access_time_rounded,
            title: 'Ketentuan Garansi & Jam Buka',
            subtitle: _operatingHours,
            onTap: _showOperationalHoursSheet,
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          _buildSettingRow(
            icon: Icons.description_outlined,
            title: 'Syarat & Ketentuan Kemitraan',
            subtitle: 'SOP Layanan & Kebijakan Platform',
            onTap: _showPartnershipTermsDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF1D5CE5), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: _confirmLogoutMitra,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 19, color: Color(0xFFDC2626)),
            SizedBox(width: 8),
            Text(
              'Keluar dari Akun Mitra',
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

  // Bottom Navigation Bar Khusus Mitra (Tab Profil Aktif)
  Widget _buildMitraBottomNav() {
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
          height: 66,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMitraNavItem(
                isSelected: false,
                icon: Icons.storefront_outlined,
                label: 'Bursa',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/mitra-bursa'),
              ),
              _buildMitraNavItem(
                isSelected: false,
                icon: Icons.checklist_rtl_rounded,
                label: 'Antrean',
                badgeCount: '2',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/mitra-antrean'),
              ),
              _buildMitraNavItem(
                isSelected: false,
                icon: Icons.history_rounded,
                label: 'Riwayat',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/mitra-riwayat'),
              ),
              _buildMitraNavItem(
                isSelected: true,
                icon: Icons.store_mall_directory_rounded,
                label: 'Profil',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMitraNavItem({
    required bool isSelected,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? badgeCount,
  }) {
    final color = isSelected
        ? const Color(0xFF1D5CE5)
        : const Color(0xFF64748B);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badgeCount != null)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D5CE5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badgeCount,
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

class _ProfileHeaderWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.05)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.88, size.height * 0.72);
    canvas.drawCircle(center, 46, strokePaint);
    canvas.drawLine(
      Offset(center.dx - 46, center.dy),
      Offset(center.dx + 46, center.dy),
      strokePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 46),
      Offset(center.dx, center.dy + 46),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
