import 'package:flutter/material.dart';

class MitraEditShopScreen extends StatefulWidget {
  const MitraEditShopScreen({super.key});

  @override
  State<MitraEditShopScreen> createState() => _MitraEditShopScreenState();
}

class _MitraEditShopScreenState extends State<MitraEditShopScreen> {
  final _shopNameController = TextEditingController(text: 'Budi Phone Repair');
  final _ownerNameController = TextEditingController(text: 'Budi Santoso');
  final _phoneController = TextEditingController(text: '+62 812-3456-7890');
  final _emailController = TextEditingController(
    text: 'budi.service@gmail.com',
  );
  final _addressController = TextEditingController(
    text: 'Jl. Margonda Raya No. 124, Depok',
  );
  final _sinceYearController = TextEditingController(text: '2022');

  String _gpsCoordinate = '-6.3728, 106.8324';
  int _photoSampleIndex = 0;
  bool _isInitialized = false;

  final List<Map<String, dynamic>> _boothPhotos = [
    {
      'title': 'Booth & Meja Servis Utama',
      'size': '1.9 MB',
      'desc': 'Tampak etalase konter & meja kerja teknisi bersertifikat',
    },
    {
      'title': 'Tampak Depan & Papan Nama Gerai',
      'size': '2.2 MB',
      'desc': 'Fasad depan toko Budi Phone Repair di Jl. Margonda Raya',
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
      if (args != null) {
        _shopNameController.text =
            args['shopName'] ?? _shopNameController.text;
        _ownerNameController.text =
            args['ownerName'] ?? _ownerNameController.text;
        _addressController.text = args['address'] ?? _addressController.text;
        _sinceYearController.text =
            args['sinceYear'] ?? _sinceYearController.text;
        _phoneController.text = args['phone'] ?? _phoneController.text;
        _emailController.text = args['email'] ?? _emailController.text;
        _gpsCoordinate = args['gpsCoordinate'] ?? _gpsCoordinate;
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _sinceYearController.dispose();
    super.dispose();
  }

  void _updateGpsPoint() {
    setState(() {
      _gpsCoordinate = '-6.3731, 106.8329 (Akurasi 5m)';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Titik koordinat GPS toko berhasil diperbarui.'),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _switchBoothPhoto() {
    setState(() {
      _photoSampleIndex = (_photoSampleIndex + 1) % _boothPhotos.length;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Foto booth & etalase toko diperbarui.'),
        backgroundColor: const Color(0xFF1D5CE5),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _saveShopChanges() {
    if (_shopNameController.text.trim().isEmpty ||
        _ownerNameController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Nama toko, kepala teknisi, dan alamat lengkap wajib diisi.',
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Informasi toko & lokasi berhasil disimpan.'),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.pop(context, {
      'shopName': _shopNameController.text.trim(),
      'ownerName': _ownerNameController.text.trim(),
      'address': _addressController.text.trim(),
      'sinceYear': _sinceYearController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'gpsCoordinate': _gpsCoordinate,
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPhoto = _boothPhotos[_photoSampleIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
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
              'Edit Informasi Toko',
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          children: [
            // Kartu 1: Foto Booth & Etalase Toko
            Container(
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.photo_camera_back_outlined,
                            color: Color(0xFF1D5CE5),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Foto Booth & Etalase',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Terverifikasi',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    height: 165,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A),
                          Color(0xFF1D5CE5),
                          Color(0xFF0F766E),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 16,
                          top: 16,
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 82,
                            color: Colors.white.withValues(alpha: 0.16),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              currentPhoto['title']!,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.65),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    currentPhoto['desc']!,
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    currentPhoto['size']!,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _switchBoothPhoto,
                    icon: const Icon(Icons.camera_alt_outlined, size: 18),
                    label: const Text(
                      'Ganti Foto Booth Toko',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1D5CE5),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Kartu 2: Identitas Gerai & Kontak Operasional
            Container(
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
                        Icons.badge_outlined,
                        color: Color(0xFF1D5CE5),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Identitas Gerai & Kontak',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFieldLabel('Nama Toko Service'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _shopNameController,
                    icon: Icons.storefront_outlined,
                    hint: 'Nama konter servis',
                  ),
                  const SizedBox(height: 14),
                  _buildFieldLabel('Nama Kepala Teknisi / Pemilik'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _ownerNameController,
                    icon: Icons.person_outline_rounded,
                    hint: 'Nama pemilik toko',
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Nomor WhatsApp Toko'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _phoneController,
                              icon: Icons.phone_outlined,
                              hint: '+62 812-xxxx-xxxx',
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Berdiri Sejak'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _sinceYearController,
                              icon: Icons.calendar_today_outlined,
                              hint: '2022',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildFieldLabel('Email Operasional'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.mail_outline_rounded,
                    hint: 'email@toko.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Kartu 3: Alamat Toko & Titik Koordinat GPS
            Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF1D5CE5),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Lokasi & Titik GPS',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _updateGpsPoint,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.my_location_rounded,
                              size: 15,
                              color: Color(0xFF1D5CE5),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Perbarui GPS',
                              style: TextStyle(
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
                  _buildFieldLabel('Alamat Lengkap Konter'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _addressController,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF0F172A),
                      height: 1.4,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan alamat lengkap toko...',
                      filled: true,
                      fillColor: const Color(0xFFF1F5FB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF5F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_outlined,
                          size: 17,
                          color: Color(0xFF0B6E64),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Pin Peta: $_gpsCoordinate',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B6E64),
                            ),
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
      bottomNavigationBar: Container(
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
          child: ElevatedButton.icon(
            onPressed: _saveShopChanges,
            icon: const Icon(Icons.save_outlined, size: 19),
            label: const Text(
              'Simpan Perubahan Toko',
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D5CE5),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
        prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 19),
        filled: true,
        fillColor: const Color(0xFFF1F5FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
      ),
    );
  }
}