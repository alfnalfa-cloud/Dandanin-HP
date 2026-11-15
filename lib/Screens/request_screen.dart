import 'package:flutter/material.dart';

class RequestRepairScreen extends StatefulWidget {
  const RequestRepairScreen({super.key});

  @override
  State<RequestRepairScreen> createState() => _RequestRepairScreenState();
}

class _RequestRepairScreenState extends State<RequestRepairScreen> {
  String _selectedBrand = 'Samsung';
  final List<String> _brands = [
    'Samsung',
    'Xiaomi',
    'iPhone',
    'OPPO',
    'Vivo',
    'Realme',
    'ASUS',
    'Lainnya',
  ];

  final TextEditingController _modelController = TextEditingController(
    text: 'Galaxy A54 5G',
  );

  final TextEditingController _symptomController = TextEditingController(
    text: 'HP jatuh dari meja kemarin sore, layar retak di pojok kanan bawah. Touchscreen masih merespon tapi ada garis hijau tipis.',
  );

  String _selectedCategory = 'Layar Pecah / Retak';

  final List<Map<String, dynamic>> _damageCategories = [
    {
      'title': 'Layar Pecah\nRetak',
      'value': 'Layar Pecah / Retak',
      'icon': Icons.broken_image_outlined,
    },
    {
      'title': 'Baterai Drop\nKembung',
      'value': 'Baterai Drop / Kembung',
      'icon': Icons.battery_alert_outlined,
    },
  ];

  final List<String> _uploadedPhotos = ['Layar Depan'];

  @override
  void dispose() {
    _modelController.dispose();
    _symptomController.dispose();
    super.dispose();
  }

  void _addDummyPhoto() {
    if (_uploadedPhotos.length >= 3) return;
    final labels = ['Layar Depan', 'Bodi Belakang', 'Sisi Samping'];
    setState(() {
      _uploadedPhotos.add(labels[_uploadedPhotos.length]);
    });
  }

  void _removePhoto(int index) {
    setState(() {
      _uploadedPhotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          children: [
            _buildDeviceIdentityCard(),
            const SizedBox(height: 16),
            _buildDamageCategoryCard(),
            const SizedBox(height: 16),
            _buildSymptomCard(),
            const SizedBox(height: 16),
            _buildPhysicalPhotosCard(),
            const SizedBox(height: 16),
            _buildGuaranteeCard(),
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
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 22),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Ajukan Perbaikan',
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
            child: const Icon(Icons.person, color: Color(0xFF475569), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceIdentityCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.smartphone_rounded,
                color: Color(0xFF1D5CE5),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Identitas Perangkat',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRequiredLabel('Merek HP'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedBrand,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                ),
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F172A),
                ),
                borderRadius: BorderRadius.circular(12),
                items: _brands.map((brand) {
                  return DropdownMenuItem<String>(
                    value: brand,
                    child: Text(brand),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedBrand = value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildRequiredLabel('Tipe / Model Lengkap'),
          const SizedBox(height: 8),
          TextField(
            controller: _modelController,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              hintText: 'Contoh: Galaxy A54 5G',
              hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              suffixIcon: _modelController.text.trim().isNotEmpty
                  ? const Icon(
                      Icons.verified_outlined,
                      color: Color(0xFF0F766E),
                      size: 20,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageCategoryCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.build_rounded, color: Color(0xFF1D5CE5), size: 19),
                  SizedBox(width: 8),
                  Text(
                    'Kategori Kerusakan Utama',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              _buildTagBadge('Wajib'),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _damageCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.35,
            ),
            itemBuilder: (context, index) {
              final item = _damageCategories[index];
              final isSelected = _selectedCategory == item['value'];

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedCategory = item['value'] as String);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1D5CE5)
                        : const Color(0xFFF1F5FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 20,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: Color(0xFF1D5CE5),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Gejala Kerusakan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                '${_symptomController.text.length}/500',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _symptomController,
            maxLines: 4,
            maxLength: 500,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF1E293B),
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: 'Jelaskan kronologi dan detail kerusakan HP Anda agar teknisi memberi estimasi akurat...',
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
        ],
      ),
    );
  }

  Widget _buildPhysicalPhotosCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF1D5CE5),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Foto Kondisi Fisik',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              _buildTagBadge('Opsional'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Foto membantu teknisi mendiagnosa sparepart yang tepat untuk memberikan estimasi biaya paling presisi.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _uploadedPhotos.length < 3
                ? _uploadedPhotos.length + 1
                : _uploadedPhotos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              if (index < _uploadedPhotos.length) {
                return _buildPhotoPreviewTile(
                  label: _uploadedPhotos[index],
                  onRemove: () => _removePhoto(index),
                );
              }
              return _buildAddPhotoTile();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPreviewTile({
    required String label,
    required VoidCallback onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF334155), Color(0xFF1E293B)],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.smartphone_rounded,
              size: 48,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFDC2626),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPhotoTile() {
    return InkWell(
      onTap: _addDummyPhoto,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFDBEAFE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_a_photo_outlined,
                color: Color(0xFF1D5CE5),
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambah Foto',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D5CE5),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Maks. 3 foto (JPG/PNG)',
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuaranteeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F7F4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: Color(0xFF0F766E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Jaminan Transaksi Aman & Fleksibel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F766E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildGuaranteeItem(
            title: 'Tanpa bayar di muka: ',
            description: 'Konsultasi dan lelang penawaran 100% gratis.',
          ),
          const SizedBox(height: 8),
          _buildGuaranteeItem(
            title: 'Bayar tunai di tempat: ',
            description:
                'Pembayaran langsung di counter mitra yang disepakati.',
          ),
          const SizedBox(height: 8),
          _buildGuaranteeItem(
            title: 'Bebas pilih harga: ',
            description:
                'Pilih tawaran teknisi dengan ulasan dan garansi terbaik.',
          ),
        ],
      ),
    );
  }

  Widget _buildGuaranteeItem({
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFF0F766E),
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF334155),
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                TextSpan(text: description),
              ],
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
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/select',
            ); // Aksi mengirim permintaan lelang perbaikan
          },
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
              Icon(Icons.rocket_launch_outlined, size: 19),
              SizedBox(width: 8),
              Text(
                'Kirim Permintaan (Cari Penawaran)',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
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

  Widget _buildTagBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF475569),
        ),
      ),
    );
  }
}
