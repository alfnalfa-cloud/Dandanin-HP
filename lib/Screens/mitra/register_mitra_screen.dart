import 'package:flutter/material.dart';

class RegisterMitraScreen extends StatefulWidget {
  const RegisterMitraScreen({super.key});

  @override
  State<RegisterMitraScreen> createState() => _RegisterMitraScreenState();
}

class _RegisterMitraScreenState extends State<RegisterMitraScreen> {
  final _ownerNameController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _phoneController = TextEditingController(text: '+62 812-3456-7890');
  final _emailController = TextEditingController(
    text: 'budi.service@gmail.com',
  );
  final _addressController = TextEditingController(
    text: 'Jl. Margonda Raya No. 124, Depok',
  );

  String _selectedHours = '09:00 - 21:00 WIB (Buka Setiap Hari)';
  final List<String> _operationalHoursOptions = [
    '09:00 - 21:00 WIB (Buka Setiap Hari)',
    '08:00 - 20:00 WIB (Senin - Sabtu)',
    '10:00 - 22:00 WIB (Buka Setiap Hari)',
    '09:00 - 18:00 WIB (Senin - Jumat)',
  ];

  int _photoSampleIndex = 0;
  final List<Map<String, String>> _photoSamples = [
    {
      'title': 'Meja Servis & Mikroskop Solder',
      'size': '1.8 MB',
      'caption': 'Area kerja teknisi & etalase depan konter',
    },
    {
      'title': 'Etalase Depan & Ruang Tunggu',
      'size': '2.3 MB',
      'caption': 'Tampak depan toko & papan nama gerai',
    },
  ];

  @override
  void dispose() {
    _ownerNameController.dispose();
    _shopNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _detectGpsLocation() {
    setState(() {
      _addressController.text =
          'Jl. HR Boenyamin No. 42, Grendeng, Purwokerto Utara';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Lokasi GPS berhasil terdeteksi.'),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _changeShopPhoto() {
    setState(() {
      _photoSampleIndex = (_photoSampleIndex + 1) % _photoSamples.length;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Foto etalase & meja servis diperbarui.'),
        backgroundColor: const Color(0xFF1D5CE5),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _previewShopPhoto() {
    final currentPhoto = _photoSamples[_photoSampleIndex];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pratinjau Foto Toko',
                    style: TextStyle(
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
              _buildWorkshopPhotoPreview(height: 200, showButtons: false),
              const SizedBox(height: 12),
              Text(
                currentPhoto['title']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${currentPhoto['caption']} • Ukuran ${currentPhoto['size']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitMitraRegistration() {
    if (_ownerNameController.text.trim().isEmpty ||
        _shopNameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Harap lengkapi seluruh data identitas dan alamat toko mitra.',
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
                'Pendaftaran Mitra Terkirim',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Pengajuan untuk "${_shopNameController.text.trim()}" dengan ID Tiket #MITRA-REG-8821 sedang ditinjau Administrator (maks. 1×24 jam). Anda dapat masuk melalui halaman Login setelah akun diverifikasi.',
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
              Navigator.pushReplacementNamed(context, '/login');
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
              'Kembali ke Halaman Masuk',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPortalHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                children: [
                  _buildRegistrationStatusCard(),
                  const SizedBox(height: 18),
                  _buildIdentityCard(),
                  const SizedBox(height: 18),
                  _buildLocationAndOperationalCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomSubmitBar(),
    );
  }

  Widget _buildPortalHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFEFF4FF),
            Color(0xFFDBEAFE),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: CustomPaint(
        painter: _MitraHeaderCircuitPainter(),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol Kembali + Identitas Mitra Service Network
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFF0F172A),
                          size: 20,
                        ),
                      ),
                    ),
                    // Ikon Aplikasi Dandanin HP
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D5CE5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1D5CE5).withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.phonelink_setup_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 7,
                                color: Color(0xFF1D5CE5),
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Mitra Service Network',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E3A8A),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Bench Tech & Workshop Portal',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'Daftar sebagai Mitra Dandanin HP',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kartu Status Pendaftaran (#MITRA-REG-8821)
  Widget _buildRegistrationStatusCard() {
    return Container(
      width: double.infinity,
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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE68A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.hourglass_bottom_rounded,
                  color: Color(0xFF78350F),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status\nPendaftaran',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'ID Tiket: #MITRA-REG-\n8821',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        height: 1.3,
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
                  color: const Color(0xFFFDE68A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: Color(0xFF78350F),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Verifikasi\nTertunda',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78350F),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Menunggu Verifikasi Administrator. Akun Anda sedang ditinjau oleh tim kami (1×24 jam) sebelum dapat menerima pesanan dan mengajukan lelang bursa.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF475569),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Kartu 2: Data Identitas Mitra
  Widget _buildIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    color: Color(0xFF1D5CE5),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Data Identitas Mitra',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                'Tahap 1 / 2',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D5CE5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          _buildRequiredLabel('Nama Pemilik Toko'),
          const SizedBox(height: 8),
          TextField(
            controller: _ownerNameController,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            decoration: _buildInputDecoration(
              hintText: 'contoh: Budi Santoso',
              prefixIcon: Icons.person_outline_rounded,
            ),
          ),
          const SizedBox(height: 16),

          _buildRequiredLabel('Nama Toko Service'),
          const SizedBox(height: 8),
          TextField(
            controller: _shopNameController,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
            decoration: _buildInputDecoration(
              hintText: 'contoh: Budi Cell & Service',
              prefixIcon: Icons.storefront_outlined,
            ),
          ),
          const SizedBox(height: 16),

          _buildRequiredLabel('Nomor WhatsApp / Telepon'),
          const SizedBox(height: 8),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
            ),
            decoration: _buildInputDecoration(
              hintText: '+62 812-3456-7890',
              prefixIcon: Icons.phone_outlined,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Digunakan untuk notifikasi lelang & tiket servis baru',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          _buildRequiredLabel('Email Operasional'),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
            ),
            decoration: _buildInputDecoration(
              hintText: 'budi.service@gmail.com',
              prefixIcon: Icons.mail_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }

  // Kartu 3: Lokasi & Operasional
  Widget _buildLocationAndOperationalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Color(0xFF1D5CE5),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Lokasi & Operasional',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Alamat Lengkap Toko + Deteksi GPS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRequiredLabel('Alamat Lengkap Toko'),
              GestureDetector(
                onTap: _detectGpsLocation,
                child: const Row(
                  children: [
                    Icon(
                      Icons.my_location_rounded,
                      size: 15,
                      color: Color(0xFF1D5CE5),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Deteksi GPS',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D5CE5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              hintText: 'Masukkan alamat lengkap gerai / konter...',
              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13.5,
              ),
              filled: true,
              fillColor: const Color(0xFFF1F5FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 16),

          // Jam Operasional Toko
          _buildRequiredLabel('Jam Operasional Toko'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedHours,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF64748B),
                ),
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F172A),
                ),
                items: _operationalHoursOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 19,
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
                    setState(() => _selectedHours = newValue);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Foto Etalase & Meja Servis
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRequiredLabel('Foto Etalase & Meja Servis'),
              const Text(
                'JPG/PNG maks. 5MB',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildWorkshopPhotoPreview(height: 170, showButtons: true),
        ],
      ),
    );
  }

  Widget _buildWorkshopPhotoPreview({
    required double height,
    required bool showButtons,
  }) {
    final currentPhoto = _photoSamples[_photoSampleIndex];

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height,
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
              // Dekorasi ilustrasi meja servis & mikroskop
              Positioned(
                right: 16,
                top: 16,
                child: Icon(
                  Icons.precision_manufacturing_rounded,
                  size: 86,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        currentPhoto['title']!,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Overlay gelap di bagian bawah foto
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.68),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Foto Meja Servis Siap',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currentPhoto['size']!,
                          style: const TextStyle(
                            fontSize: 11,
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
        if (showButtons) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _changeShopPhoto,
                  icon: const Icon(Icons.camera_alt_outlined, size: 18),
                  label: const Text(
                    'Ganti Foto Toko',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1D5CE5),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _previewShopPhoto,
                icon: const Icon(Icons.visibility_outlined, size: 18),
                label: const Text(
                  'Lihat',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA7F3D0),
                  foregroundColor: const Color(0xFF064E3B),
                  elevation: 0,
                  minimumSize: const Size(96, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
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
          onPressed: _submitMitraRegistration,
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
              Text(
                'Daftar Mitra Sekarang',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, size: 19),
            ],
          ),
        ),
      ),
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

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 13.5,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFF64748B),
        size: 20,
      ),
      filled: true,
      fillColor: const Color(0xFFF1F5FB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    );
  }
}

class _MitraHeaderCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.35),
      72,
      circlePaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.14)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.56, size.height * 0.36)
      ..lineTo(size.width * 0.72, size.height * 0.36)
      ..lineTo(size.width * 0.82, size.height * 0.54)
      ..lineTo(size.width * 0.96, size.height * 0.54);

    canvas.drawPath(path, linePaint);
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.36),
      3.5,
      dotPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.54),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}