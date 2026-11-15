import 'package:flutter/material.dart';

class MitraAntreanScreen extends StatefulWidget {
  const MitraAntreanScreen({super.key});

  @override
  State<MitraAntreanScreen> createState() => _MitraAntreanScreenState();
}

class _MitraAntreanScreenState extends State<MitraAntreanScreen> {
  // 0 = Menunggu Keputusan, 1 = Aktif Diproses
  int _selectedTab = 1;

  // Data Tab 0: Menunggu Keputusan Pelanggan
  final List<Map<String, dynamic>> _pendingDecisions = [
    {
      'offerId': '#OFF-2024-0412',
      'time': 'Dikirim 15 mnt lalu',
      'status': 'Menunggu Pelanggan',
      'device': 'Samsung Galaxy A54 5G',
      'service': 'Ganti Modul LCD + Touchscreen (OEM Ori)',
      'initials': 'RP',
      'avatarBg': const Color(0xFFDBEAFE),
      'avatarText': const Color(0xFF1D5CE5),
      'customerName': 'Rian P.',
      'distance': '1.8 km dari workshop',
      'duration': '1 Hari (Besok Siang)',
      'warranty': 'Garansi 7 Hari',
      'price': 'Rp450.000',
      'note': 'Sparepart LCD OEM ready di toko, pemasangan sekitar 2 jam setelah HP diantar.',
    },
    {
      'offerId': '#OFF-2024-0409',
      'time': 'Dikirim 1 jam lalu',
      'status': 'Ditinjau Pelanggan',
      'device': 'OPPO Reno 8 5G',
      'service': 'Ganti Konektor Charger & IC Fast Charging',
      'initials': 'SR',
      'avatarBg': const Color(0xFFCCFBF1),
      'avatarText': const Color(0xFF0F766E),
      'customerName': 'Siti Rahma',
      'distance': '2.1 km dari workshop',
      'duration': 'Express (2 - 3 Jam)',
      'warranty': 'Garansi 30 Hari',
      'price': 'Rp175.000',
      'note': 'Pengecekan jalur pengisian daya gratis, pengerjaan bisa ditunggu di ruang tunggu.',
    },
  ];

  // Data Tab 1: Aktif Diproses (Sesuai Desain Antrean)
  final List<Map<String, dynamic>> _activeQueues = [
    {
      'orderId': '#SRV-2024-0891',
      'time': 'Hari ini, 10:15',
      'status': 'Masuk Antrean',
      'device': 'Samsung Galaxy A54 5G',
      'service': 'Ganti LCD Fullset (Super AMOLED Grade A)',
      'serviceIcon': Icons.phonelink_setup_rounded,
      'initials': 'AF',
      'avatarBg': const Color(0xFFDBEAFE),
      'avatarText': const Color(0xFF1D5CE5),
      'customerName': 'Ahmad Fauzi',
      'phone': '0812-9844-••••',
      'fullPhone': '0812-9844-7721',
      'priceLabel': 'BIAYA DISEPAKATI',
      'price': 'Rp350.000',
      'paymentNote': null,
      'hasProgress': false,
      'stageText': 'Menunggu Meja Teknisi',
      'estimateText': 'Estimasi: 17:30 WIB',
      'progress': 0.25,
    },
    {
      'orderId': '#SRV-2024-0888',
      'time': 'Hari ini, 09:30',
      'status': 'Sedang Diproses',
      'device': 'iPhone 11 128GB',
      'service': 'Ganti Baterai Health 100% (High Capacity)',
      'serviceIcon': Icons.battery_charging_full_rounded,
      'initials': 'DL',
      'avatarBg': const Color(0xFFCCFBF1),
      'avatarText': const Color(0xFF0F766E),
      'customerName': 'Dewi Lestari',
      'phone': '0877-2210-••••',
      'fullPhone': '0877-2210-5590',
      'priceLabel': 'TOTAL BIAYA',
      'price': 'Rp280.000',
      'paymentNote': '(Tunai di\nToko)',
      'hasProgress': true,
      'stageText': 'Tahap: Pemasangan Sparepart',
      'estimateText': 'Estimasi: 16:00 WIB',
      'progress': 0.65,
    },
  ];

  void _callCustomer(String name, String fullPhone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menghubungi $name ($fullPhone) via WhatsApp/Telepon...'),
        backgroundColor: const Color(0xFF0F766E),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showPendingOfferDetailSheet(Map<String, dynamic> offer) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  offer['offerId'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D5CE5),
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
                  child: Text(
                    offer['status'] as String,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB45309),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              offer['device'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pelanggan: ${offer['customerName']} (${offer['distance']})',
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5FB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nominal Penawaran',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF475569),
                        ),
                      ),
                      Text(
                        offer['price'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estimasi & Garansi',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF475569),
                        ),
                      ),
                      Text(
                        '${offer['duration']} • ${offer['warranty']}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                  ),
                  Text(
                    '"${offer['note']}"',
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF334155),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _pendingDecisions.remove(offer));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Penawaran ${offer['offerId']} dibatalkan.',
                          ),
                          backgroundColor: const Color(0xFFDC2626),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFDC2626),
                      side: const BorderSide(color: Color(0xFFFECACA)),
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Batalkan Tawaran',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D5CE5),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Tutup',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageHeader(),
            const SizedBox(height: 18),
            _buildSegmentedTabs(),
            const SizedBox(height: 18),
            if (_selectedTab == 0)
              _buildPendingDecisionList()
            else
              _buildActiveQueueList(),
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
                'Antrean',
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
                    'Mitra Service',
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

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF1D5CE5),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.build_circle_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Antrean Servis Toko',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Monitor alur meja teknisi secara real-time dan kelola status garansi aktif.',
          style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.4),
        ),
      ],
    );
  }

  // Segmented Control: Menunggu Keputusan (2) | Aktif Diproses (2)
  Widget _buildSegmentedTabs() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTabButton(
            index: 0,
            label: 'Menunggu\nKeputusan',
            count: _pendingDecisions.length,
          ),
          const SizedBox(width: 4),
          _buildTabButton(
            index: 1,
            label: 'Aktif Diproses',
            count: _activeQueues.length,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    required int count,
  }) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1D5CE5) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF1D5CE5).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFDFE6F5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isSelected
                        ? const Color(0xFF1D5CE5)
                        : const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Daftar Kartu Tab 0: Menunggu Keputusan
  Widget _buildPendingDecisionList() {
    if (_pendingDecisions.isEmpty) {
      return _buildEmptyTabState(
        title: 'Tidak ada penawaran menunggu keputusan',
        subtitle: 'Penawaran harga yang baru Anda kirim dari Bursa akan muncul di sini.',
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pendingDecisions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final offer = _pendingDecisions[index];
        return _buildPendingOfferCard(offer);
      },
    );
  }

  Widget _buildPendingOfferCard(Map<String, dynamic> offer) {
    return Container(
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
          painter: _QueueCardWatermarkPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris 1: ID Penawaran + Waktu + Badge Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        runSpacing: 2,
                        children: [
                          Text(
                            offer['offerId'] as String,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D5CE5),
                            ),
                          ),
                          const Text(
                            '•',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                          Text(
                            offer['time'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 7,
                            color: Color(0xFFB45309),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            offer['status'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF78350F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Nama Perangkat & Layanan Ditawarkan
                Text(
                  offer['device'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.handyman_outlined,
                        size: 15,
                        color: Color(0xFF1D5CE5),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        offer['service'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Kotak Info Pelanggan & Jarak
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: offer['avatarBg'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          offer['initials'] as String,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: offer['avatarText'] as Color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer['customerName'] as String,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${offer['distance']} • ${offer['warranty']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          offer['duration'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: _HorizontalDashedLinePainter(),
                  ),
                ),

                // Footer Nominal Penawaran + Tombol Lihat Tawaran
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PENAWARAN ANDA',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          offer['price'] as String,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _showPendingOfferDetailSheet(offer),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.hovered) ||
                                states.contains(WidgetState.pressed)) {
                              return const Color(0xFF1D5CE5);
                            }
                            return const Color(0xFFDBEAFE);
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.hovered) ||
                                states.contains(WidgetState.pressed)) {
                              return Colors.white;
                            }
                            return const Color(0xFF1D5CE5);
                          },
                        ),
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        elevation: WidgetStateProperty.all(0),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 11,
                          ),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Lihat\nTawaran',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
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

  // Daftar Kartu Tab 1: Aktif Diproses
  Widget _buildActiveQueueList() {
    if (_activeQueues.isEmpty) {
      return _buildEmptyTabState(
        title: 'Belum ada antrean servis aktif',
        subtitle: 'Pesanan yang disetujui pelanggan akan otomatis masuk ke daftar ini.',
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _activeQueues.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildActiveQueueCard(_activeQueues[index]);
      },
    );
  }

  Widget _buildActiveQueueCard(Map<String, dynamic> item) {
    final String status = item['status'] as String;
    final bool hasProgress = item['hasProgress'] as bool;
    final String? paymentNote = item['paymentNote'] as String?;

    Color statusBg;
    Color statusDot;
    Color statusText;

    if (status == 'Masuk Antrean') {
      statusBg = const Color(0xFFFEF3C7);
      statusDot = const Color(0xFFB45309);
      statusText = const Color(0xFF78350F);
    } else if (status == 'Sedang Diproses') {
      statusBg = const Color(0xFFDBEAFE);
      statusDot = const Color(0xFF1D5CE5);
      statusText = const Color(0xFF1D5CE5);
    } else {
      statusBg = const Color(0xFFCCFBF1);
      statusDot = const Color(0xFF0F766E);
      statusText = const Color(0xFF0F766E);
    }

    return Container(
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
          painter: _QueueCardWatermarkPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris 1: Order ID + Waktu + Status Pill
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        runSpacing: 2,
                        children: [
                          Text(
                            item['orderId'] as String,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D5CE5),
                            ),
                          ),
                          const Text(
                            '•',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                          Text(
                            item['time'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 7, color: statusDot),
                          const SizedBox(width: 5),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: statusText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Nama Perangkat & Jenis Servis
                Text(
                  item['device'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        item['serviceIcon'] as IconData,
                        size: 16,
                        color: status == 'Masuk Antrean'
                            ? const Color(0xFFB45309)
                            : const Color(0xFF1D5CE5),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        item['service'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF475569),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Kotak Info Pelanggan + Tombol Telepon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: item['avatarBg'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          item['initials'] as String,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: item['avatarText'] as Color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['customerName'] as String,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['phone'] as String,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF64748B),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _callCustomer(
                          item['customerName'] as String,
                          item['fullPhone'] as String,
                        ),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F172A)
                                    .withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.call_outlined,
                            size: 18,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Kotak Progres Teknisi (Muncul saat Sedang Diproses / Selesai)
                if (hasProgress) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 1),
                                    child: Icon(
                                      Icons.memory_rounded,
                                      size: 15,
                                      color: Color(0xFF0F766E),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      item['stageText'] as String,
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 1),
                                    child: Icon(
                                      Icons.access_time_rounded,
                                      size: 15,
                                      color: Color(0xFF78350F),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      item['estimateText'] as String,
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: item['progress'] as double,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFE2E8F0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              status == 'Selesai (Siap Ambil)'
                                  ? const Color(0xFF0F766E)
                                  : const Color(0xFF1D5CE5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Garis Putus-Putus Pemisah
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: _HorizontalDashedLinePainter(),
                  ),
                ),

                // Footer Biaya & Tombol Kelola Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['priceLabel'] as String,
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item['price'] as String,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0F766E),
                                ),
                              ),
                              if (paymentNote != null) ...[
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    paymentNote,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      color: Color(0xFF475569),
                                      height: 1.15,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/mitra-detail-pesanan',
                          arguments: item,
                        );
                        if (result is Map<String, dynamic>) {
                          setState(() {
                            item['status'] = result['status'];
                            item['stageText'] = result['stageText'];
                            item['progress'] = result['progress'];
                            item['hasProgress'] = result['hasProgress'];
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D5CE5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 11,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Kelola\nStatus',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
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

  Widget _buildEmptyTabState({
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.assignment_outlined,
            size: 38,
            color: Color(0xFF94A3B8),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar Khusus Mitra (Tab Antrean Aktif)
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
                isSelected: true,
                icon: Icons.checklist_rtl_rounded,
                label: 'Antrean',
                badgeCount: '${_activeQueues.length}',
                onTap: () {},
              ),
              _buildMitraNavItem(
                isSelected: false,
                icon: Icons.history_rounded,
                label: 'Riwayat',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/mitra-riwayat'),
              ),
              _buildMitraNavItem(
                isSelected: false,
                icon: Icons.store_mall_directory_outlined,
                label: 'Profil',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/mitra-profil'),
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

class _QueueCardWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.05)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width * 0.86, size.height * 0.86);
    canvas.drawCircle(center, 42, strokePaint);
    canvas.drawLine(center, Offset(center.dx, center.dy - 22), strokePaint);
    canvas.drawLine(center, Offset(center.dx + 16, center.dy), strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HorizontalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1.2;

    const double dashWidth = 5;
    const double dashSpace = 4;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
