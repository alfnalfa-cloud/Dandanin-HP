import 'package:flutter/material.dart';

class MitraBursaScreen extends StatefulWidget {
  const MitraBursaScreen({super.key});

  @override
  State<MitraBursaScreen> createState() => _MitraBursaScreenState();
}

class _MitraBursaScreenState extends State<MitraBursaScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Terdekat (< 3 km)';
  bool _isShopOpen = true;
  int _searchRadiusKm = 5;

  final List<Map<String, dynamic>> _openRequests = [
    {
      'device': 'iPhone 11 128GB',
      'categoryBadge': 'Baterai Drop',
      'badgeBg': const Color(0xFFFEF3C7),
      'badgeText': const Color(0xFFB45309),
      'orderId': 'Order #REQ-7819',
      'issueTitle': 'Baterai Kembung & Cepat Habis\n(Health 68%)',
      'issueDesc': 'Layar agak sedikit terangkat di sisi kiri, butuh pergantian baterai original kapasitas standard dan...',
      'distance': '2.4 km (Margonda)',
      'distanceVal': 2.4,
      'timeAgo': '12 mnt lalu',
      'isNew': true,
      'category': 'Baterai',
      'target': 'Hari ini (Express 1-2 Jam)',
    },
    {
      'device': 'Samsung Galaxy A54 5G',
      'categoryBadge': 'Layar Pecah',
      'badgeBg': const Color(0xFFFEE2E2),
      'badgeText': const Color(0xFFDC2626),
      'orderId': 'Order #REQ-7820',
      'issueTitle': 'Layar Bergaris & Touchscreen Macet',
      'issueDesc': 'Jatuh dari meja, kaca bagian bawah retak dan sentuhan sering tidak merespons. Cari LCD OLED...',
      'distance': '1.9 km (Beji)',
      'distanceVal': 1.9,
      'timeAgo': '25 mnt lalu',
      'isNew': true,
      'category': 'LCD',
      'target': 'Maksimal 2 Hari Kerja',
    },
    {
      'device': 'Xiaomi Redmi Note 11 Pro',
      'categoryBadge': 'Layar / LCD',
      'badgeBg': const Color(0xFFDBEAFE),
      'badgeText': const Color(0xFF1D5CE5),
      'orderId': 'Order #REQ-7815',
      'issueTitle': 'Ganti LCD Fullset + Pasang Tempered Glass',
      'issueDesc': 'Layar blank hitam tapi notifikasi dan getar masih masuk normal. Butuh estimasi part ori & garansi...',
      'distance': '4.1 km (Cinere)',
      'distanceVal': 4.1,
      'timeAgo': '1 jam lalu',
      'isNew': false,
      'category': 'LCD',
      'target': 'Besok Sore',
    },
  ];

  List<Map<String, dynamic>> get _filteredRequests {
    final query = _searchController.text.trim().toLowerCase();

    return _openRequests.where((req) {
      bool matchesChip = true;
      if (_selectedFilter == 'Terdekat (< 3 km)') {
        matchesChip = (req['distanceVal'] as double) < 3.0;
      } else if (_selectedFilter == 'Terbaru') {
        matchesChip = req['isNew'] == true;
      } else if (_selectedFilter == 'Layar / LCD') {
        matchesChip = req['category'] == 'LCD';
      }

      if (!matchesChip) return false;
      if (query.isEmpty) return true;

      final device = (req['device'] as String).toLowerCase();
      final issueTitle = (req['issueTitle'] as String).toLowerCase();
      final distance = (req['distance'] as String).toLowerCase();

      return device.contains(query) ||
          issueTitle.contains(query) ||
          distance.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showRadiusPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Atur Radius Penerimaan Order',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tampilkan permintaan servis pelanggan di sekitar lokasi gerai Anda.',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: [3, 5, 10, 15].map((km) {
                final selected = _searchRadiusKm == km;
                return ChoiceChip(
                  label: Text('Radius $km km'),
                  selected: selected,
                  selectedColor: const Color(0xFF1D5CE5),
                  backgroundColor: const Color(0xFFF1F5FB),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : const Color(0xFF334155),
                  ),
                  onSelected: (_) {
                    setState(() => _searchRadiusKm = km);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final requests = _filteredRequests;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopStatusCard(),
            const SizedBox(height: 16),
            _buildRepairFlowBanner(),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 14),
            _buildFilterChipRow(),
            const SizedBox(height: 22),
            const Text(
              'Antrean Permintaan Terbuka',
              style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 14),
            if (requests.isEmpty)
              _buildEmptyState()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: requests.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _buildRequestTicketCard(requests[index]);
                },
              ),
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
                'Bursa Permintaan',
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

  // Kartu Profil Gerai: Budi Phone Repair
  Widget _buildShopStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.business_center_outlined,
                  color: Color(0xFF1D5CE5),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Budi Phone Repair',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 13.5,
                            color: Color(0xFF1D5CE5),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Mitra Resmi Depok',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isShopOpen = !_isShopOpen),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _isShopOpen ? 'Toko Buka' : 'Toko Tutup',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _isShopOpen
                          ? const Color(0xFF0F766E)
                          : const Color(0xFFDC2626),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _isShopOpen
                        ? const Color(0xFF0F766E)
                        : const Color(0xFF94A3B8),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Menerima Order Baru di Sekitar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _showRadiusPicker,
                  child: Text(
                    'Radius $_searchRadiusKm km',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D5CE5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Banner Biru: REPAIR FLOW HARI INI
  Widget _buildRepairFlowBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1D5CE5), Color(0xFF1E40AF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D5CE5).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          painter: _FlowBannerCircuitPainter(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.insert_chart_outlined_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'REPAIR FLOW HARI INI',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Real-time',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _buildFlowStatBox(
                      value: '2',
                      label: 'Pesanan Aktif',
                      valueColor: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    _buildFlowStatBox(
                      value: '14',
                      label: 'Permintaan\nBaru',
                      valueColor: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    _buildFlowStatBox(
                      value: '700 rb',
                      label: 'Potensi Cuan',
                      valueColor: const Color(0xFF6EE7B7),
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

  Widget _buildFlowStatBox({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Expanded(
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.11),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 13.5, color: Color(0xFF0F172A)),
        decoration: InputDecoration(
          hintText: 'Cari tipe HP, keluhan, atau wilayah...',
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF64748B),
            size: 21,
          ),
          suffixIcon: IconButton(
            onPressed: _showRadiusPicker,
            icon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF475569),
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildFilterChipRow() {
    final chips = [
      {'label': 'Terdekat (< 3 km)', 'icon': Icons.near_me_outlined},
      {'label': 'Terbaru', 'icon': Icons.access_time_rounded},
      {'label': 'Layar / LCD', 'icon': Icons.smartphone_rounded},
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = chips[index]['label'] as String;
          final icon = chips[index]['icon'] as IconData;
          final isSelected = _selectedFilter == label;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = isSelected ? 'Semua' : label;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1D5CE5) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 15,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Kartu Tiket Antrean Permintaan Terbuka
  Widget _buildRequestTicketCard(Map<String, dynamic> req) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Tipe HP + Badge Kerusakan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            req['device'] as String,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            req['orderId'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
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
                        color: req['badgeBg'] as Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        req['categoryBadge'] as String,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: req['badgeText'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Kotak Detail Keluhan Pelanggan
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              req['issueTitle'] as String,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 15,
                                color: Color(0xFFDC2626),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Service\nReq',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFDC2626),
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        req['issueDesc'] as String,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF475569),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Color(0xFF1D5CE5),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              req['distance'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D5CE5),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            req['timeAgo'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pemisah Tiket (Lekukan Kiri-Kanan + Garis Putus-Putus)
          SizedBox(
            height: 18,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: _HorizontalDashedLinePainter(),
                  ),
                ),
                Positioned(
                  left: -9,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -9,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer Target Penyelesaian + Tombol Lihat & Tawar
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Target Penyelesaian',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        req['target'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/mitra-detail-permintaan',
                      arguments: req,
                    );
                    // Akan dihubungkan ke halaman Kirim Penawaran Mitra
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Membuka detail penawaran untuk ${req['device']}...',
                        ),
                        backgroundColor: const Color(0xFF1D5CE5),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.hovered) ||
                          states.contains(WidgetState.pressed)) {
                        return const Color(0xFF1D5CE5);
                      }
                      return const Color(0xFFDBEAFE);
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(WidgetState.hovered) ||
                          states.contains(WidgetState.pressed)) {
                        return Colors.white;
                      }
                      return const Color(0xFF1D5CE5);
                    }),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    elevation: WidgetStateProperty.all(0),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        'Lihat & Tawar',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.gavel_rounded, size: 17),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.inbox_outlined, size: 38, color: Color(0xFF94A3B8)),
          SizedBox(height: 10),
          Text(
            'Belum ada permintaan yang cocok',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba ubah filter jarak atau ketik kata kunci perangkat lain.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar Khusus Mitra (4 Menu)
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
                isSelected: true,
                icon: Icons.storefront_rounded,
                label: 'Bursa',
                onTap: () {},
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

class _FlowBannerCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.65, 0)
      ..lineTo(size.width * 0.78, size.height * 0.35)
      ..lineTo(size.width * 0.94, size.height * 0.35);

    final path2 = Path()
      ..moveTo(size.width * 0.74, size.height)
      ..lineTo(size.width * 0.88, size.height * 0.72)
      ..lineTo(size.width, size.height * 0.72);

    canvas.drawPath(path, linePaint);
    canvas.drawPath(path2, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.35),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.72),
      3.5,
      dotPaint,
    );
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
