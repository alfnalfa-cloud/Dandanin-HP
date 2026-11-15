import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';

  final List<String> _filters = [
    'Semua',
    'Spesialis LCD',
    'Baterai & Charger',
    'IC & Mati Total',
    'Rating 4.8+',
  ];

  final List<Map<String, dynamic>> _allPartners = [
    {
      'name': 'Dandani Cell Purwokerto',
      'rating': 4.8,
      'reviewsCount': 142,
      'distance': '2.5 km',
      'address': 'Jl. HR Boenyamin No. 42, Grendeng, Purwokerto',
      'hours': 'Buka • Tutup 21.00 WIB',
      'specialty': 'Spesialis Layar & LCD',
      'category': 'LCD',
      'badgeIcon': Icons.verified_outlined,
      'startingPrice': 'Rp250.000',
      'warranty': 'Garansi 30 Hari',
      'highlight': 'Menerima jemput & antar unit area Purwokerto',
      'priceList': [
        {'service': 'Ganti LCD OLED / Ori (Samsung / iPhone)', 'price': 'Rp350.000 - Rp850.000'},
        {'service': 'Ganti LCD IPS Fullset (Xiaomi / OPPO / Vivo)', 'price': 'Rp250.000 - Rp420.000'},
        {'service': 'Ganti Kaca Touchscreen Saja', 'price': 'Rp180.000'},
      ],
      'reviews': [
        {
          'user': 'Budi Santoso',
          'device': 'Samsung Galaxy A54 5G',
          'rating': 5,
          'comment': 'Layar kembali jernih, fingerprint aman, harga sesuai penawaran awal.',
          'date': '2 hari lalu',
        },
        {
          'user': 'Rina Kartika',
          'device': 'Redmi Note 12',
          'rating': 5,
          'comment': 'Pengerjaan cepat cuma 2 jam ditunggu di konter.',
          'date': '1 minggu lalu',
        },
      ],
    },
    {
      'name': 'Dokter Gadget Purwokerto',
      'rating': 4.9,
      'reviewsCount': 215,
      'distance': '3.1 km',
      'address': 'Jl. Jenderal Soedirman No. 118, Sokaraja',
      'hours': 'Buka • Tutup 20.30 WIB',
      'specialty': 'Ganti Baterai & IC',
      'category': 'Baterai',
      'badgeIcon': Icons.battery_charging_full_rounded,
      'startingPrice': 'Rp150.000',
      'warranty': 'Garansi 90 Hari',
      'highlight': 'Gratis cek kesehatan baterai & pembersihan mesin',
      'priceList': [
        {'service': 'Ganti Baterai Original / Double Power', 'price': 'Rp150.000 - Rp350.000'},
        {'service': 'Ganti Fleksibel Konektor Charger', 'price': 'Rp120.000 - Rp200.000'},
        {'service': 'Perbaikan IC Charger / Fast Charging', 'price': 'Rp250.000 - Rp400.000'},
      ],
      'reviews': [
        {
          'user': 'Dimas Pratama',
          'device': 'iPhone 11 128GB',
          'rating': 5,
          'comment': 'Battery health balik 100%, awet seharian dan bergaransi panjang.',
          'date': '4 hari lalu',
        },
      ],
    },
    {
      'name': 'FixPhone Center Purwokerto',
      'rating': 4.8,
      'reviewsCount': 98,
      'distance': '1.8 km',
      'address': 'Jl. Gerilya No. 12, Purwokerto Selatan',
      'hours': 'Buka • Tutup 21.00 WIB',
      'specialty': 'IC Power & Mati Total',
      'category': 'IC',
      'badgeIcon': Icons.memory_rounded,
      'startingPrice': 'Rp200.000',
      'warranty': 'Garansi 60 Hari',
      'highlight': 'Peralatan mikroskop lengkap & data HP aman',
      'priceList': [
        {'service': 'Perbaikan HP Mati Total / Korslet Mesin', 'price': 'Rp250.000 - Rp550.000'},
        {'service': 'Ganti IC Power / IC Sinyal', 'price': 'Rp280.000 - Rp450.000'},
        {'service': 'Penanganan HP Terkena Air (Water Damage)', 'price': 'Rp200.000'},
      ],
      'reviews': [
        {
          'user': 'Aji Nugroho',
          'device': 'Xiaomi Redmi Note 11 Pro',
          'rating': 5,
          'comment': 'Sempat mati total di tempat lain divonis ganti mesin, di sini berhasil hidup lagi.',
          'date': '5 hari lalu',
        },
      ],
    },
    {
      'name': 'Bintang Service HP',
      'rating': 4.6,
      'reviewsCount': 64,
      'distance': '1.5 km',
      'address': 'Jl. Prof. Dr. Suharso, Arcawinangun, Purwokerto',
      'hours': 'Buka • Tutup 20.00 WIB',
      'specialty': 'Spesialis Layar & LCD',
      'category': 'LCD',
      'badgeIcon': Icons.smartphone_rounded,
      'startingPrice': 'Rp220.000',
      'warranty': 'Garansi 14 Hari',
      'highlight': 'Harga ekonomis cocok untuk pelajar & mahasiswa',
      'priceList': [
        {'service': 'Ganti LCD Grade-A High Contrast', 'price': 'Rp220.000 - Rp380.000'},
        {'service': 'Ganti Speaker / Mic Telepon', 'price': 'Rp100.000 - Rp160.000'},
      ],
      'reviews': [
        {
          'user': 'Nadia Putri',
          'device': 'OPPO A57',
          'rating': 5,
          'comment': 'Harga ramah di kantong mahasiswa, teknisi jujur jelasin opsi part.',
          'date': '1 minggu lalu',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredPartners {
    final query = _searchController.text.trim().toLowerCase();

    return _allPartners.where((partner) {
      // Filter kategori chip
      bool matchesFilter = true;
      if (_selectedFilter == 'Spesialis LCD') {
        matchesFilter = partner['category'] == 'LCD';
      } else if (_selectedFilter == 'Baterai & Charger') {
        matchesFilter = partner['category'] == 'Baterai';
      } else if (_selectedFilter == 'IC & Mati Total') {
        matchesFilter = partner['category'] == 'IC';
      } else if (_selectedFilter == 'Rating 4.8+') {
        matchesFilter = (partner['rating'] as double) >= 4.8;
      }

      if (!matchesFilter) return false;
      if (query.isEmpty) return true;

      // Filter kata kunci pencarian
      final name = (partner['name'] as String).toLowerCase();
      final specialty = (partner['specialty'] as String).toLowerCase();
      final address = (partner['address'] as String).toLowerCase();
      final priceListText = (partner['priceList'] as List<dynamic>)
          .map((item) => (item['service'] as String).toLowerCase())
          .join(' ');

      return name.contains(query) ||
          specialty.contains(query) ||
          address.contains(query) ||
          priceListText.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredPartners;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildTopAppBar(),
      body: Column(
        children: [
          // Header Pencarian & Filter Sticky
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cari Mitra & Estimasi Harga',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Temukan konter terverifikasi di sekitar Purwokerto',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 14),
                _buildSearchInput(),
                const SizedBox(height: 12),
                _buildFilterChips(),
              ],
            ),
          ),

          // Daftar Hasil Mitra
          Expanded(
            child: results.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                    itemCount: results.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Menampilkan ${results.length} Mitra Teknisi',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475569),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.near_me_outlined,
                                  size: 14,
                                  color: Color(0xFF1D5CE5),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Terdekat',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1D5CE5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return _buildPartnerDirectoryCard(results[index - 1]);
                    },
                  ),
          ),
        ],
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
            child: const Icon(
              Icons.person,
              color: Color(0xFF475569),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          fontSize: 13.5,
          color: Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          hintText: 'Ketik kerusakan (LCD, baterai) atau nama konter...',
          hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF1D5CE5),
            size: 21,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF64748B),
                    size: 19,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1D5CE5)
                    : const Color(0xFFEEF2FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPartnerDirectoryCard(Map<String, dynamic> partner) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Profil Konter
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.store_mall_directory_rounded,
                  color: Color(0xFF475569),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      partner['name'] as String,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFF59E0B),
                                size: 14,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${partner['rating']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB45309),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '(${partner['reviewsCount']} ulasan)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          partner['distance'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      partner['address'] as String,
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
            ],
          ),
          const SizedBox(height: 12),

          // Badge Spesialisasi & Garansi
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      partner['badgeIcon'] as IconData,
                      size: 14,
                      color: const Color(0xFF0F766E),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      partner['specialty'] as String,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F766E),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  partner['warranty'] as String,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Kotak Kisaran Biaya & Keunggulan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        partner['hours'] as String,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        partner['highlight'] as String,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF475569),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Jasa Mulai',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      partner['startingPrice'] as String,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Tombol Lihat Profil & Ulasan (Seragam + Hover/Tekan Biru)
          ElevatedButton(
            onPressed: () => _showPartnerDetailSheet(partner),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.pressed)) {
                  return const Color(0xFF1D5CE5);
                }
                return const Color(0xFFDBEAFE);
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.pressed)) {
                  return Colors.white;
                }
                return const Color(0xFF1D5CE5);
              }),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              minimumSize: WidgetStateProperty.all(
                const Size(double.infinity, 46),
              ),
              elevation: WidgetStateProperty.all(0),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lihat Daftar Harga & Ulasan',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet Profil Publik Mitra, Estimasi Harga & Ulasan Pelanggan
  void _showPartnerDetailSheet(Map<String, dynamic> partner) {
    final priceList = partner['priceList'] as List<dynamic>;
    final reviews = partner['reviews'] as List<dynamic>;

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
        builder: (context, scrollController) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
                children: [
                  Text(
                    partner['name'] as String,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF59E0B),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${partner['rating']} (${partner['reviewsCount']} ulasan)',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Color(0xFF94A3B8))),
                      const SizedBox(width: 8),
                      Text(
                        partner['hours'] as String,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          partner['address'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                  ),

                  // Estimasi Harga Layanan
                  const Text(
                    'Kisaran Biaya Layanan Populer',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...priceList.map((item) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['service'] as String,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              item['price'] as String,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D5CE5),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 14),

                  // Ulasan Publik Pelanggan
                  const Text(
                    'Ulasan Pelanggan Terverifikasi',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...reviews.map((rev) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  rev['user'] as String,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  rev['date'] as String,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Servis: ${rev['device']}',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F766E),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '"${rev['comment']}"',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF334155),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            // Tombol Ajukan Perbaikan di bagian bawah Sheet
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                    blurRadius: 14,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/request');
                  },
                  icon: const Icon(Icons.build_rounded, size: 18),
                  label: const Text(
                    'Ajukan Perbaikan Sekarang',
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 32,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Mitra atau layanan tidak ditemukan',
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coba gunakan kata kunci lain seperti LCD, baterai, atau pilih filter Semua.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
          ],
        ),
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
                isSelected: true,
                icon: Icons.explore_rounded,
                label: 'Cari',
                onTap: () {},
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
                              color: const Color(0xFF1D5CE5).withValues(alpha: 0.35),
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
                isSelected: false,
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
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
    final color = isSelected ? const Color(0xFF1D5CE5) : const Color(0xFF64748B);

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