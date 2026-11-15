import 'package:flutter/material.dart';

class MitraOrderDetailScreen extends StatefulWidget {
  const MitraOrderDetailScreen({super.key});

  @override
  State<MitraOrderDetailScreen> createState() => _MitraOrderDetailScreenState();
}

class _MitraOrderDetailScreenState extends State<MitraOrderDetailScreen> {
  final TextEditingController _progressNoteController = TextEditingController(
    text: 'LCD lama sudah dilepas. Modul baru sudah dipasang dan lolos tes sentuh 10 titik. Sedang proses pengelemang bezel dan pengeringan.',
  );

  // 0 = Masuk Antrean, 1 = Sedang Diproses, 2 = Selesai (Siap Diambil), 3 = Selesai & Lunas
  int _selectedStageIndex = 1;
  bool _isInitialized = false;

  String _orderId = '#SRV-2024-0891';
  String _customerName = 'Ahmad Fauzi';
  String _initials = 'AF';
  String _customerType = 'Pelanggan Konter\nLangsung';
  String _phoneNumber = '+62 812-9844-xxxx';
  String _deviceName = 'Samsung Galaxy A54 5G';
  String _serviceAction =
      'Ganti Modul LCD Super AMOLED + Pasang Tempered Glass';
  String _agreedPrice = 'Rp350.000';
  String _intakeInfo =
      'Diserahkan di konter 10:10 WIB (Segel intake terpasang)';

  // 4 Tahapan diselaraskan dengan pelacakan status pada halaman Pelanggan
  final List<Map<String, dynamic>> _serviceStages = [
    {
      'title': '1. Masuk Antrean',
      'subtitle':
          'Unit telah diterima di toko, menunggu giliran bongkar teknisi.',
      'upcomingBadge': 'Menunggu',
      'badgeBg': const Color(0xFFFEF3C7),
      'badgeText': const Color(0xFF78350F),
      'icon': Icons.hourglass_bottom_rounded,
      'iconBg': const Color(0xFFFDE68A),
      'iconColor': const Color(0xFF78350F),
      'headerPill': 'Menunggu Bongkar',
      'queueStatus': 'Masuk Antrean',
      'queueStageText': 'Menunggu Meja Teknisi',
      'progress': 0.25,
    },
    {
      'title': '2. Sedang Diproses',
      'subtitle':
          'Teknisi sedang melakukan penggantian sparepart & pengetesan mesin.',
      'upcomingBadge': 'Proses',
      'badgeBg': const Color(0xFFDBEAFE),
      'badgeText': const Color(0xFF1D5CE5),
      'icon': Icons.build_rounded,
      'iconBg': const Color(0xFF1D5CE5),
      'iconColor': Colors.white,
      'headerPill': 'Proses Meja Teknisi',
      'queueStatus': 'Sedang Diproses',
      'queueStageText': 'Tahap: Pemasangan Sparepart',
      'progress': 0.65,
    },
    {
      'title': '3. Selesai (Siap Diambil)',
      'subtitle':
          'Perbaikan tuntas, QC lolos, unit siap diambil di konter toko.',
      'upcomingBadge': 'QC Pass',
      'badgeBg': const Color(0xFF99F6E4),
      'badgeText': const Color(0xFF0F766E),
      'icon': Icons.verified_user_outlined,
      'iconBg': const Color(0xFFCCFBF1),
      'iconColor': const Color(0xFF0F766E),
      'headerPill': 'Siap Diambil',
      'queueStatus': 'Selesai (Siap Ambil)',
      'queueStageText': 'Tahap: Lolos QC & Siap Ambil',
      'progress': 0.90,
    },
    {
      'title': '4. Selesai & Lunas',
      'subtitle':
          'Pembayaran tunai diterima, unit diserahkan & garansi toko aktif.',
      'upcomingBadge': 'Garansi Aktif',
      'badgeBg': const Color(0xFFE0E7FF),
      'badgeText': const Color(0xFF3730A3),
      'icon': Icons.check_circle_outline_rounded,
      'iconBg': const Color(0xFFE0E7FF),
      'iconColor': const Color(0xFF3730A3),
      'headerPill': 'Transaksi Selesai',
      'queueStatus': 'Selesai & Lunas',
      'queueStageText': 'Tahap: Unit Diserahkan (Garansi Aktif)',
      'progress': 1.0,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _orderId = (args['orderId'] as String?) ?? _orderId;
        _customerName = (args['customerName'] as String?) ?? _customerName;
        _initials = (args['initials'] as String?) ?? _initials;
        _deviceName = (args['device'] as String?) ?? _deviceName;
        _serviceAction = (args['service'] as String?) ?? _serviceAction;
        _agreedPrice = (args['price'] as String?) ?? _agreedPrice;
        if (args['fullPhone'] != null) {
          _phoneNumber = '+62 ${(args['fullPhone'] as String).substring(1)}';
        }
        final status = args['status'] as String?;
        if (status == 'Masuk Antrean') {
          _selectedStageIndex = 0;
        } else if (status == 'Sedang Diproses') {
          _selectedStageIndex = 1;
        } else if (status == 'Selesai (Siap Ambil)') {
          _selectedStageIndex = 2;
        } else if (status == 'Selesai & Lunas') {
          _selectedStageIndex = 3;
        }
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _progressNoteController.dispose();
    super.dispose();
  }

  void _appendQuickTemplate(String snippet) {
    final current = _progressNoteController.text.trim();
    setState(() {
      if (current.isEmpty) {
        _progressNoteController.text = '$snippet.';
      } else if (current.endsWith('.')) {
        _progressNoteController.text = '$current $snippet.';
      } else {
        _progressNoteController.text = '$current. $snippet.';
      }
    });
  }

  void _callCustomer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menghubungi $_customerName ($_phoneNumber)...'),
        backgroundColor: const Color(0xFF0F766E),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _saveStatusUpdate() {
    final currentStage = _serviceStages[_selectedStageIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Status diperbarui ke "${currentStage['title']}" & tersinkron ke aplikasi $_customerName.',
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context, {
      'status': currentStage['queueStatus'],
      'stageText': currentStage['queueStageText'],
      'progress': currentStage['progress'],
      'hasProgress': _selectedStageIndex > 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentHeaderPill =
        _serviceStages[_selectedStageIndex]['headerPill'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris Pill Order ID & Status Meja Teknisi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 7,
                        color: Color(0xFF1D5CE5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _orderId,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D5CE5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.build_rounded,
                        size: 13.5,
                        color: Color(0xFF1D5CE5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        currentHeaderPill,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D5CE5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Kartu 1: Ringkasan Pelanggan, Perangkat & Biaya Disepakati
            _buildCustomerAndDeviceCard(),
            const SizedBox(height: 18),

            // Kartu 2: Pembaruan Tahapan Servis (Sinkron 4 Tahap Pelanggan)
            _buildStageUpdateCard(),
            const SizedBox(height: 18),

            // Kartu 3: Catatan Perkembangan Pengerjaan + Template Cepat
            _buildProgressNoteCard(),
            const SizedBox(height: 16),

            // Banner Info Sinkronisasi Notifikasi Pelanggan
            _buildSyncInfoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 22),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Detail Pesanan',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
            ),
            child: const Icon(
              Icons.engineering_rounded,
              color: Color(0xFF1D5CE5),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Kartu 1: Info Pelanggan, Unit Servis, Tindakan & Biaya Disepakati
  Widget _buildCustomerAndDeviceCard() {
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
          painter: _OrderCardCircuitPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Profil Pelanggan + Tombol Hubungi
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDBEAFE),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _initials,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1D5CE5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _customerName,
                            style: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 1),
                                child: Icon(
                                  Icons.storefront_outlined,
                                  size: 14,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  _customerType,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF64748B),
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _callCustomer,
                      icon: const Icon(Icons.call_outlined, size: 15),
                      label: const Text(
                        'Hubungi',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEEF2FA),
                        foregroundColor: const Color(0xFF1D5CE5),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Bar Nomor WhatsApp / Telp
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nomor WhatsApp / Telp',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        _phoneNumber,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Unit Servis
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.smartphone_rounded,
                        size: 18,
                        color: Color(0xFF1D5CE5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Unit Servis',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          Text(
                            _deviceName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Kotak Tindakan Servis
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.business_center_outlined,
                          size: 16,
                          color: Color(0xFF78350F),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tindakan Servis:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              _serviceAction,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF334155),
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Kotak Biaya Disepakati
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Biaya Disepakati',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF334155),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Tunai saat ambil di toko',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _agreedPrice,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Info Segel Intake
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      size: 16,
                      color: Color(0xFF0F766E),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        _intakeInfo,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kartu 2: Pembaruan Tahapan Servis (4 Tahap Selaras dengan Pelanggan)
  Widget _buildStageUpdateCard() {
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
          const Row(
            children: [
              Icon(
                Icons.linear_scale_rounded,
                color: Color(0xFF1D5CE5),
                size: 21,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pembaruan Tahapan Servis',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Perbarui status secara bertahap agar pelanggan terinformasi.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),

          // Daftar 4 Kartu Tahapan
          ...List.generate(_serviceStages.length, (index) {
            final stage = _serviceStages[index];
            final bool isCompleted = index < _selectedStageIndex;
            final bool isActive = index == _selectedStageIndex;

            return GestureDetector(
              onTap: () => setState(() => _selectedStageIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.only(
                  bottom: index < _serviceStages.length - 1 ? 12 : 0,
                ),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFDBEAFE).withValues(alpha: 0.72)
                      : const Color(0xFFF1F5FB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFF93C5FD)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ikon Kiri Tahapan
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF1D5CE5)
                            : (stage['iconBg'] as Color),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        stage['icon'] as IconData,
                        size: 19,
                        color: isActive
                            ? Colors.white
                            : (stage['iconColor'] as Color),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Judul, Badge Status & Deskripsi
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  stage['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              if (isCompleted)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFDE68A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Selesai',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF78350F),
                                    ),
                                  ),
                                )
                              else if (isActive)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1D5CE5),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Aktif\nSekarang',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          height: 1.15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: stage['badgeBg'] as Color,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    stage['upcomingBadge'] as String,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: stage['badgeText'] as Color,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            stage['subtitle'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF475569),
                              height: 1.38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Indikator Check / Radio di Kanan
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: isActive
                          ? Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1D5CE5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                            )
                          : isCompleted
                          ? const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 22,
                              color: Color(0xFF93C5FD),
                            )
                          : Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFCBD5E1),
                                  width: 1.6,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Kartu 3: Catatan Perkembangan Pengerjaan + Template Cepat
  Widget _buildProgressNoteCard() {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.edit_note_rounded,
                        color: Color(0xFF1D5CE5),
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Catatan Perkembangan Pengerjaan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  'Opsional',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _progressNoteController,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1E293B),
              height: 1.45,
            ),
            decoration: InputDecoration(
              hintText: 'Tulis pembaruan kondisi perangkat untuk pelanggan...',
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 12),

          // Baris Template Cepat
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 7,
            runSpacing: 7,
            children: [
              const Text(
                'Template cepat:',
                style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
              ),
              _buildQuickChip(
                label: '+ Tes Display OK',
                bg: const Color(0xFFEEF2FA),
                textColor: const Color(0xFF1D5CE5),
                onTap: () => _appendQuickTemplate(
                  'Tes kecerahan dan sensitivitas display berjalan normal',
                ),
              ),
              _buildQuickChip(
                label: '+ Frame Presisi',
                bg: const Color(0xFFFEF3C7),
                textColor: const Color(0xFFB45309),
                onTap: () => _appendQuickTemplate(
                  'Pemasangan frame & lem bezel sudah presisi dan rapat',
                ),
              ),
              _buildQuickChip(
                label: '+ Kamera OK',
                bg: const Color(0xFFCCFBF1),
                textColor: const Color(0xFF0F766E),
                onTap: () => _appendQuickTemplate(
                  'Fungsi kamera depan, belakang, dan sensor sudah diuji normal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip({
    required String label,
    required Color bg,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Banner Sinkronisasi Notifikasi Pelanggan
  Widget _buildSyncInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDDF5F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(
              Icons.notifications_active_outlined,
              size: 19,
              color: Color(0xFF0F766E),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sinkronisasi Notifikasi Pelanggan',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Setiap pembaruan status akan langsung memicu pembaruan pada tracking status $_customerName secara realtime.',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF334155),
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

  // Sticky Bottom Action Buttons
  Widget _buildBottomActionBar() {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: _saveStatusUpdate,
              icon: const Icon(Icons.save_outlined, size: 19),
              label: const Text(
                'Simpan Pembaruan Status',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D5CE5),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/mitra-konfirmasi-pembayaran',
                  arguments: {
                    'orderId': _orderId,
                    'device': _deviceName,
                    'customerName': _customerName,
                    'initials': _initials,
                    'phone': '+62 812-8902-1142',
                    'price': _agreedPrice,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6ECF8),
                foregroundColor: const Color(0xFF0F766E),
                minimumSize: const Size(double.infinity, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tandai Selesai & Lanjut Pembayaran',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCardCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.08)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.72, size.height * 0.72)
      ..lineTo(size.width * 0.85, size.height * 0.72)
      ..lineTo(size.width * 0.92, size.height * 0.88)
      ..lineTo(size.width, size.height * 0.88);

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.72),
      3,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.88),
      3,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
