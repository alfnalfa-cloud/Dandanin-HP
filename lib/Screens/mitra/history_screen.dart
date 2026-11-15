import 'package:flutter/material.dart';


class MitraHistoryScreen extends StatefulWidget {
  const MitraHistoryScreen({super.key});

  @override
  State<MitraHistoryScreen> createState() => _MitraHistoryScreenState();
}

class _MitraHistoryScreenState extends State<MitraHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';

  final List<String> _filterOptions = [
    'Semua',
    'Garansi Aktif',
    'Garansi Selesai',
    'Dibatalkan',
  ];

  final List<Map<String, dynamic>> _historyList = [
    {
      'orderId': '#SRV-2024-0891',
      'completedDate': 'Hari ini, 14:30 WIB',
      'warrantyStatus': 'Garansi Aktif',
      'warrantyDetail': 'Garansi Aktif • Sisa 7 Hari',
      'badgeBg': const Color(0xFFCCFBF1),
      'badgeDot': const Color(0xFF0F766E),
      'badgeText': const Color(0xFF0F766E),
      'device': 'Samsung Galaxy A54 5G',
      'service': 'Ganti Modul LCD Super AMOLED + Tempered Glass',
      'customerName': 'Ahmad Fauzi',
      'initials': 'AF',
      'avatarBg': const Color(0xFFDBEAFE),
      'avatarText': const Color(0xFF1D5CE5),
      'serviceFee': 'Rp150.000',
      'partFee': 'Rp200.000',
      'totalPrice': 'Rp350.000',
      'paymentStatus': 'LUNAS TUNAI',
      'rating': '5.0',
      'review':
          'Layar kembali jernih dan responsif, pengerjaan rapi tepat waktu.',
    },
    {
      'orderId': '#SRV-2024-0884',
      'completedDate': '12 Nov 2026 • 16:15 WIB',
      'warrantyStatus': 'Garansi Aktif',
      'warrantyDetail': 'Garansi Aktif • Sisa 27 Hari',
      'badgeBg': const Color(0xFFCCFBF1),
      'badgeDot': const Color(0xFF0F766E),
      'badgeText': const Color(0xFF0F766E),
      'device': 'iPhone 12 Pro 256GB',
      'service': 'Ganti Baterai Original Health 100% + Seal Anti Air',
      'customerName': 'Siti Rahma',
      'initials': 'SR',
      'avatarBg': const Color(0xFFCCFBF1),
      'avatarText': const Color(0xFF0F766E),
      'serviceFee': 'Rp150.000',
      'partFee': 'Rp400.000',
      'totalPrice': 'Rp550.000',
      'paymentStatus': 'LUNAS TUNAI',
      'rating': '5.0',
      'review':
          'Baterai iPhone langsung sehat 100%, pengerjaan rapi dan segel aman.',
    },
    {
      'orderId': '#SRV-2024-0871',
      'completedDate': '04 Nov 2026 • 13:40 WIB',
      'warrantyStatus': 'Garansi Selesai',
      'warrantyDetail': 'Garansi Selesai (7 Hari)',
      'badgeBg': const Color(0xFFEEF2FA),
      'badgeDot': const Color(0xFF64748B),
      'badgeText': const Color(0xFF475569),
      'device': 'Xiaomi Redmi Note 11',
      'service': 'Ganti Konektor Charger Type-C & Bersih Jalur Mesin',
      'customerName': 'Dimas Anggoro',
      'initials': 'DA',
      'avatarBg': const Color(0xFFE0E7FF),
      'avatarText': const Color(0xFF3730A3),
      'serviceFee': 'Rp85.000',
      'partFee': 'Rp80.000',
      'totalPrice': 'Rp165.000',
      'paymentStatus': 'LUNAS TUNAI',
      'rating': '4.8',
      'review': 'Servis port charger berfungsi normal kembali. Mantap!',
    },
    {
      'orderId': '#SRV-2024-0865',
      'completedDate': '01 Nov 2026 • 11:20 WIB',
      'warrantyStatus': 'Dibatalkan',
      'warrantyDetail': 'Dibatalkan Pelanggan',
      'badgeBg': const Color(0xFFFEE2E2),
      'badgeDot': const Color(0xFFDC2626),
      'badgeText': const Color(0xFFDC2626),
      'device': 'vivo V25 5G',
      'service': 'Diagnosa Awal Jalur IC Power (Batal Sebelum Bongkar)',
      'customerName': 'Bagas Pratama',
      'initials': 'BP',
      'avatarBg': const Color(0xFFF1F5F9),
      'avatarText': const Color(0xFF475569),
      'serviceFee': 'Rp0',
      'partFee': 'Rp0',
      'totalPrice': 'Rp0',
      'paymentStatus': 'DIBATALKAN',
      'rating': null,
      'review': null,
    },
  ];

  List<Map<String, dynamic>> get _filteredHistory {
    final query = _searchController.text.trim().toLowerCase();

    return _historyList.where((item) {
      if (_selectedFilter != 'Semua' &&
          item['warrantyStatus'] != _selectedFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final orderId = (item['orderId'] as String).toLowerCase();
      final device = (item['device'] as String).toLowerCase();
      final customer = (item['customerName'] as String).toLowerCase();
      final service = (item['service'] as String).toLowerCase();

      return orderId.contains(query) ||
          device.contains(query) ||
          customer.contains(query) ||
          service.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showReceiptDetailSheet(Map<String, dynamic> item) {
    final bool isCancelled = item['warrantyStatus'] == 'Dibatalkan';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 16, 22, 26),
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
                  'Nota Digital • ${item['orderId']}',
                  style: const TextStyle(
                    fontSize: 16.5,
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
                    color: item['badgeBg'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item['warrantyStatus'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: item['badgeText'] as Color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Selesai pada ${item['completedDate']}',
              style: const TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            // Box Rincian Transaksi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5FB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pelanggan',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        item['customerName'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Perangkat',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        item['device'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFCBD5E1)),
                  ),
                  Text(
                    item['service'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  if (!isCancelled) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Jasa Teknisi',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF475569),
                          ),
                        ),
                        Text(
                          item['serviceFee'] as String,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Biaya Sparepart',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF475569),
                          ),
                        ),
                        Text(
                          item['partFee'] as String,
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
                      child: Divider(height: 1, color: Color(0xFFCBD5E1)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Lunas (Tunai di Toko)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F766E),
                          ),
                        ),
                        Text(
                          item['totalPrice'] as String,
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F766E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Ulasan Pelanggan Jika Ada
            if (item['review'] != null) ...[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFCE8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFEF08A)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 17,
                          color: Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Ulasan Pelanggan (${item['rating']})',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78350F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '“${item['review']}”',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF334155),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),

            if (!isCancelled)
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Mencetak ulang nota ${item['orderId']} ke printer thermal...',
                      ),
                      backgroundColor: const Color(0xFF1D5CE5),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.print_outlined, size: 19),
                label: const Text(
                  'Cetak Ulang Nota Fisik',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D5CE5),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              )
            else
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE6ECF8),
                  foregroundColor: const Color(0xFF1E293B),
                  minimumSize: const Size(double.infinity, 48),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Tutup',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredHistory;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRevenueSummaryBanner(),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 14),
            _buildFilterChips(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Catatan Servis & Nota',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  '${items.length} Transaksi',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (items.isEmpty)
              _buildEmptyState()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) => _buildHistoryCard(items[index]),
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
                'Riwayat Servis',
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

  // Banner Ringkasan Pendapatan Tunai & Garansi
  Widget _buildRevenueSummaryBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1D5CE5),
            Color(0xFF1E40AF),
          ],
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
          painter: _HistoryBannerCircuitPainter(),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'PENDAPATAN TUNAI BULAN INI',
                          style: TextStyle(
                            fontSize: 11.5,
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
                        'Nov 2026',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rp 6.420.000',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _buildMiniStat(
                      value: '24 Unit',
                      label: 'Servis Selesai',
                      valueColor: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    _buildMiniStat(
                      value: '2 Aktif',
                      label: 'Garansi Toko',
                      valueColor: const Color(0xFF6EE7B7),
                    ),
                    const SizedBox(width: 10),
                    _buildMiniStat(
                      value: '4.8 ★',
                      label: 'Kepuasan',
                      valueColor: const Color(0xFFFDE68A),
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

  Widget _buildMiniStat({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: valueColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10.5,
                color: Colors.white,
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
        decoration: const InputDecoration(
          hintText: 'Cari nomor nota, tipe HP, atau pelanggan...',
          hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFF64748B),
            size: 21,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filterOptions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = _filterOptions[index];
          final isSelected = _selectedFilter == label;

          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = label),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    final bool isCancelled = item['warrantyStatus'] == 'Dibatalkan';

    return Container(
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
          // Baris 1: Order ID + Status Garansi Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['orderId'] as String,
                style: const TextStyle(
                  fontSize: 12.5,
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
                  color: item['badgeBg'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: item['badgeDot'] as Color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item['warrantyDetail'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: item['badgeText'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Nama Perangkat & Tindakan
          Text(
            item['device'] as String,
            style: const TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item['service'] as String,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),

          // Bar Info Pelanggan + Rating Ulasan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item['avatarBg'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    item['initials'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: item['avatarText'] as Color,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
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
                        item['completedDate'] as String,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                if (item['rating'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: Color(0xFFF59E0B),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          item['rating'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: CustomPaint(
              size: const Size(double.infinity, 1),
              painter: _HistoryDashedLinePainter(),
            ),
          ),

          // Footer Total Pembayaran & Tombol Lihat Nota
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['paymentStatus'] as String,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: isCancelled
                          ? const Color(0xFFDC2626)
                          : const Color(0xFF64748B),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['totalPrice'] as String,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isCancelled
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF0F766E),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showReceiptDetailSheet(item),
                icon: const Icon(Icons.receipt_long_outlined, size: 17),
                label: Text(
                  isCancelled ? 'Detail' : 'Lihat Nota',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEEF2FA),
                  foregroundColor: const Color(0xFF1D5CE5),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
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
          Icon(
            Icons.history_toggle_off_rounded,
            size: 38,
            color: Color(0xFF94A3B8),
          ),
          SizedBox(height: 10),
          Text(
            'Riwayat transaksi tidak ditemukan',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba pilih filter status lain atau hapus kata kunci pencarian.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Bar Khusus Mitra (Tab Riwayat Aktif)
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
                isSelected: true,
                icon: Icons.history_rounded,
                label: 'Riwayat',
                onTap: () {},
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
    final color = isSelected ? const Color(0xFF1D5CE5) : const Color(0xFF64748B);

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

class _HistoryBannerCircuitPainter extends CustomPainter {
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
      ..moveTo(size.width * 0.68, 0)
      ..lineTo(size.width * 0.80, size.height * 0.34)
      ..lineTo(size.width * 0.96, size.height * 0.34);

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.80, size.height * 0.34),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HistoryDashedLinePainter extends CustomPainter {
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