import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 5;

  final List<String> _highlightOptions = [
    'Pengerjaan Cepat',
    'Harga Sesuai Penawaran',
    'Teknisi Ramah',
    'Hasil Rapi & Presisi',
  ];

  final Set<String> _selectedHighlights = {
    'Pengerjaan Cepat',
    'Harga Sesuai Penawaran',
  };

  final TextEditingController _reviewController = TextEditingController();
  final List<String> _servicePhotos = ['Hasil Layar Baru'];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  String get _ratingLabel {
    switch (_rating) {
      case 1:
        return 'Sangat Kecewa (1.0)';
      case 2:
        return 'Kurang Puas (2.0)';
      case 3:
        return 'Cukup Puas (3.0)';
      case 4:
        return 'Puas (4.0)';
      case 5:
      default:
        return 'Sangat Puas (5.0)';
    }
  }

  void _addDummyPhoto() {
    if (_servicePhotos.length >= 3) return;
    setState(() {
      _servicePhotos.add('Foto Servis ${_servicePhotos.length + 1}');
    });
  }

  void _removePhoto(int index) {
    setState(() {
      _servicePhotos.removeAt(index);
    });
  }

  void _submitReview() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Terima kasih! Ulasan Anda telah diterbitkan di profil mitra.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/order',
      (route) => false,
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
            _buildOrderSummaryCard(),
            const SizedBox(height: 16),
            _buildStarRatingCard(),
            const SizedBox(height: 16),
            _buildHighlightsCard(),
            const SizedBox(height: 16),
            _buildExperienceInputCard(),
            const SizedBox(height: 16),
            _buildServicePhotosCard(),
            const SizedBox(height: 18),
            _buildPublicNoticeBanner(),
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
            'Beri Ulasan',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
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

  Widget _buildOrderSummaryCard() {
    return _buildSectionCard(
      child: Column(
        children: [
          // Header Mitra & ID Order
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.store_mall_directory_rounded,
                  color: Color(0xFF475569),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dandanin Cell Purwokerto',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.storefront_outlined,
                            size: 14,
                            color: Color(0xFF1D5CE5),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Jl. HR Soebrantas No. 42',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ID #SRV-8821',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Kotak Info HP & Status Pembayaran
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
                  children: [
                    const Icon(
                      Icons.smartphone_rounded,
                      size: 18,
                      color: Color(0xFF475569),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Samsung Galaxy A54 5G',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Ganti LCD',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D5CE5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: Color(0xFF0F766E),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pesanan Selesai & Pembayaran Tunai Dikonfirmasi',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F766E),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Total Biaya Selesai
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Biaya Selesai',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF475569),
                ),
              ),
              Text(
                'Rp350.000',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRatingCard() {
    return _buildSectionCard(
      child: Column(
        children: [
          const Text(
            'Bagaimana kepuasan Anda\nterhadap hasil perbaikan?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ketuk bintang untuk memberikan nilai',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          // 5 Bintang Interaktif
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              final isSelected = starValue <= _rating;

              return GestureDetector(
                onTap: () => setState(() => _rating = starValue),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    isSelected
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 40,
                    color: isSelected
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFFCBD5E1),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Badge Label Kepuasan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _ratingLabel,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Apa yang paling Anda sukai?',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'Pilih opsi',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _highlightOptions.map((option) {
              final isSelected = _selectedHighlights.contains(option);
              final IconData iconData = option.contains('Cepat')
                  ? Icons.bolt_rounded
                  : option.contains('Harga')
                      ? Icons.sell_outlined
                      : option.contains('Ramah')
                          ? Icons.sentiment_satisfied_alt_rounded
                          : Icons.verified_outlined;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedHighlights.remove(option);
                    } else {
                      _selectedHighlights.add(option);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFDBEAFE)
                        : const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        iconData,
                        size: 16,
                        color: isSelected
                            ? const Color(0xFF1D5CE5)
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        option,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color(0xFF1D5CE5)
                              : const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceInputCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ulasan Pengalaman',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF1E293B),
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText:
                  'Bagaimana hasil servis dan pelayanannya? Tulis pengalaman Anda untuk membantu pelanggan lain...',
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13.5,
              ),
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_reviewController.text.length}/500',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicePhotosCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Foto Hasil Servis',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Opsional',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ...List.generate(_servicePhotos.length, (index) {
                return _buildPhotoThumbnail(
                  onRemove: () => _removePhoto(index),
                );
              }),
              if (_servicePhotos.length < 3) _buildAddPhotoBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoThumbnail({required VoidCallback onRemove}) {
    return Container(
      width: 102,
      height: 102,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF475569),
            Color(0xFF1E293B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.smartphone_rounded,
              size: 42,
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 15,
                  color: Color(0xFFDC2626),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoBox() {
    return InkWell(
      onTap: _addDummyPhoto,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 102,
        height: 102,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              color: Color(0xFF1D5CE5),
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              'Tambah foto HP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicNoticeBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.info_rounded,
              color: Color(0xFF1D5CE5),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF475569),
                  height: 1.45,
                ),
                children: [
                  TextSpan(
                    text:
                        'Ulasan Anda akan langsung tampil di profil publik mitra ',
                  ),
                  TextSpan(
                    text: 'Dandanin Cell Purwokerto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  TextSpan(
                    text: ' untuk membantu komunitas pengguna servis ponsel.',
                  ),
                ],
              ),
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
          onPressed: _submitReview,
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
              Icon(Icons.send_rounded, size: 18),
              SizedBox(width: 8),
              Text(
                'Kirim Ulasan',
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

  Widget _buildSectionCard({required Widget child}) {
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
      child: child,
    );
  }
}