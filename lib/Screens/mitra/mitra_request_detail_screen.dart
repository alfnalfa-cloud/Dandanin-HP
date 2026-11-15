import 'package:flutter/material.dart';

class MitraRequestDetailScreen extends StatefulWidget {
  const MitraRequestDetailScreen({super.key});

  @override
  State<MitraRequestDetailScreen> createState() =>
      _MitraRequestDetailScreenState();
}

class _MitraRequestDetailScreenState extends State<MitraRequestDetailScreen> {
  final TextEditingController _priceController = TextEditingController(
    text: '450.000',
  );
  final TextEditingController _noteController = TextEditingController(
    text:
        'Harus ganti modul LCD + Touchscreen satu set. Pengerjaan menggunakan sparepart kualitas Original Equipment, garansi tes fungsi layar 7 hari di toko mitra.',
  );

  String _selectedDuration = '1 Hari (Selesai Besok Siang)';
  final List<String> _durationOptions = [
    'Express (2 - 3 Jam)',
    '1 Hari (Selesai Besok Siang)',
    '2 Hari Kerja',
    '3 Hari Kerja',
  ];

  String _selectedWarranty = '7 Hari (Standar)';
  final List<String> _warrantyOptions = [
    '3 Hari',
    '7 Hari (Standar)',
    '30 Hari',
  ];

  // Data default sesuai tampilan Detail Permintaan
  String _customerName = 'Rian P.';
  String _distanceText = '1.8 km dari workshop Anda';
  String _incomingTime = '09:30 WIB';
  String _deviceName = 'Samsung Galaxy A54 5G';
  String _deviceVariant = 'Awesome Violet • 8GB/256GB';
  String _damageReport =
      '“Layar jatuh saat berkendara. Kaca retak seribu di pojok kanan bawah, touchscreen kadang ghost-touch atau tidak merespons sama sekali. Kamera dan mesin telepon masih berdering normal.”';

  bool _isInitialized = false;

  final List<Map<String, dynamic>> _unitPhotos = [
    {
      'label': 'Layar Depan',
      'desc': 'Retak kaca bagian kanan bawah, tampilan LCD masih menyala.',
      'icon': Icons.smartphone_rounded,
      'colors': const [Color(0xFF1E293B), Color(0xFF3B82F6)],
    },
    {
      'label': 'Sudut Kanan',
      'desc': 'Bekas benturan ringan pada bezel sudut kanan bawah.',
      'icon': Icons.phonelink_erase_rounded,
      'colors': const [Color(0xFF334155), Color(0xFF64748B)],
    },
    {
      'label': 'Bodi & Kamera',
      'desc': 'Bodi belakang dan lensa kamera dalam kondisi utuh.',
      'icon': Icons.camera_rear_rounded,
      'colors': const [Color(0xFF312E81), Color(0xFF6366F1)],
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _deviceName = (args['device'] as String?) ?? _deviceName;
        if (args['distance'] != null) {
          _distanceText = '${args['distance']} dari workshop Anda';
        }
        if (args['issueDesc'] != null) {
          _damageReport = '“${args['issueDesc']}”';
        }
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String get _formattedButtonPrice {
    final raw = _priceController.text.trim();
    return raw.isEmpty ? '0' : raw;
  }

  void _showPhotoPreviewDialog(int initialIndex) {
    final photo = _unitPhotos[initialIndex];
    final colors = photo['colors'] as List<Color>;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lampiran: ${photo['label']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      photo['icon'] as IconData,
                      size: 84,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          photo['desc'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            height: 1.35,
                          ),
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
    );
  }

  void _submitOffer() {
    if (_priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Masukkan total biaya servis yang ditawarkan.'),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF0F766E),
              size: 24,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Penawaran Terkirim',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Penawaran sebesar Rp $_formattedButtonPrice ($_selectedDuration, garansi $_selectedWarranty) telah dikirimkan kepada $_customerName untuk unit $_deviceName.',
          style: const TextStyle(
            fontSize: 13.5,
            color: Color(0xFF475569),
            height: 1.45,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
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
              'Kembali ke Bursa Permintaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
            _buildBackToBursaChip(),
            const SizedBox(height: 14),
            _buildDeviceAndDamageCard(),
            const SizedBox(height: 18),
            _buildOfferFormCard(),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Detail Permintaan',
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

  Widget _buildBackToBursaChip() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFE6ECF8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              size: 15,
              color: Color(0xFF1E293B),
            ),
            SizedBox(width: 6),
            Text(
              'Kembali ke Bursa',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kartu 1: Info Pelanggan, Perangkat, Laporan Kerusakan & 3 Lampiran Foto
  Widget _buildDeviceAndDamageCard() {
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
          // Baris Identitas Pelanggan + Waktu Masuk
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 5,
                      runSpacing: 2,
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 15,
                          color: Color(0xFF1D5CE5),
                        ),
                        Text(
                          _customerName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                        const Text(
                          '•',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        Text(
                          _distanceText,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _deviceName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _deviceVariant,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      _incomingTime,
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
          const SizedBox(height: 16),

          // Kotak Laporan Kerusakan oleh Pelanggan
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
                const Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 16,
                      color: Color(0xFF78350F),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Laporan Kerusakan oleh Pelanggan',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _damageReport,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1E293B),
                    height: 1.48,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Header Lampiran Foto Fisik Unit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'FOTO FISIK UNIT (3 LAMPIRAN)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475569),
                  letterSpacing: 0.4,
                ),
              ),
              GestureDetector(
                onTap: () => _showPhotoPreviewDialog(0),
                child: const Row(
                  children: [
                    Icon(
                      Icons.touch_app_outlined,
                      size: 14,
                      color: Color(0xFF1D5CE5),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Ketuk perbesar',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D5CE5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Grid 3 Thumbnail Foto Fisik Unit
          Row(
            children: List.generate(_unitPhotos.length, (index) {
              final item = _unitPhotos[index];
              final colors = item['colors'] as List<Color>;

              return Expanded(
                child: GestureDetector(
                  onTap: () => _showPhotoPreviewDialog(index),
                  child: Container(
                    height: 96,
                    margin: EdgeInsets.only(right: index < 2 ? 10 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: colors,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            item['icon'] as IconData,
                            size: 34,
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(7, 14, 7, 7),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.75),
                                ],
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.zoom_in_rounded,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    item['label'] as String,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.15,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Kartu 2: Formulir Penawaran Mitra
  Widget _buildOfferFormCard() {
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
          // Header Formulir Penawaran
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D5CE5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.handshake_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Formulir Penawaran',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tentukan harga kompetitif & waktu servis Anda',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 1. Total Biaya Servis Ditawarkan
          const Text(
            'Total Biaya Servis Ditawarkan',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Text(
                  'Rp',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D5CE5),
                    ),
                    decoration: const InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // 2. Estimasi Waktu Pengerjaan
          const Text(
            'Estimasi Waktu Pengerjaan',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedDuration,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF475569),
                ),
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
                items: _durationOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() => _selectedDuration = newValue);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 18),

          // 3. Jaminan Garansi Toko
          const Text(
            'Jaminan Garansi Toko',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: _warrantyOptions.map((option) {
              final isSelected = _selectedWarranty == option;
              final isMiddle = option == '7 Hari (Standar)';

              return Expanded(
                flex: isMiddle ? 3 : 2,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedWarranty = option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    margin: EdgeInsets.only(
                      right: option != _warrantyOptions.last ? 8 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1D5CE5)
                          : const Color(0xFFEEF2FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF334155),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),

          // 4. Catatan Teknisi & Rekomendasi
          const Text(
            'Catatan Teknisi & Rekomendasi',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1E293B),
              height: 1.45,
            ),
            decoration: InputDecoration(
              hintText:
                  'Jelaskan jenis sparepart, estimasi pengerjaan, dan syarat garansi...',
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
        ],
      ),
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
          onPressed: _submitOffer,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D5CE5),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.send_outlined, size: 19),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Kirim Penawaran Harga (Rp $_formattedButtonPrice)',
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}