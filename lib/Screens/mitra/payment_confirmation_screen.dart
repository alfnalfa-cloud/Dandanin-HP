import 'package:flutter/material.dart';

class MitraPaymentConfirmationScreen extends StatefulWidget {
  const MitraPaymentConfirmationScreen({super.key});

  @override
  State<MitraPaymentConfirmationScreen> createState() =>
      _MitraPaymentConfirmationScreenState();
}

class _MitraPaymentConfirmationScreenState
    extends State<MitraPaymentConfirmationScreen> {
  bool _isInitialized = false;

  String _orderId = '#SRV-2024-0891';
  String _deviceName = 'Samsung Galaxy A54 5G';
  String _customerName = 'Ahmad Fauzi';
  String _initials = 'AF';
  String _phoneNumber = '+62 812-8902-1142';
  String _totalPrice = 'Rp350.000';
  String _serviceFee = 'Rp150.000';
  String _partName = 'Sparepart LCD Super AMOLED\n(Grade A)';
  String _partFee = 'Rp200.000';
  String _warrantyText = '7 Hari Nota Fisik';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _orderId = (args['orderId'] as String?) ?? _orderId;
        _deviceName = (args['device'] as String?) ?? _deviceName;
        _customerName = (args['customerName'] as String?) ?? _customerName;
        _initials = (args['initials'] as String?) ?? _initials;
        _phoneNumber = (args['phone'] as String?) ?? _phoneNumber;
        _totalPrice = (args['price'] as String?) ?? _totalPrice;
      }
      _isInitialized = true;
    }
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

  void _confirmCashReceived() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF0F766E),
              size: 26,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Pembayaran Tunai Lunas',
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
          'Pembayaran tunai sebesar $_totalPrice untuk pesanan $_orderId ($_deviceName) telah dicatat lunas. Unit resmi diserahkan kepada $_customerName dan garansi toko ($_warrantyText) mulai berlaku.',
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
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/mitra-antrean',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B6E64),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 46),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Selesai & Kembali ke Antrean',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrintReceiptSheet() {
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
                const Text(
                  'Pratinjau Nota Servis Fisik',
                  style: TextStyle(
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
                    color: const Color(0xFFEEF2FA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _orderId,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D5CE5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BUDI PHONE REPAIR • DANDANIN HP',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pelanggan: $_customerName ($_phoneNumber)',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF475569),
                    ),
                  ),
                  Text(
                    'Unit: $_deviceName',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFCBD5E1)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jasa Teknisi Ganti LCD',
                        style: TextStyle(fontSize: 12, color: Color(0xFF334155)),
                      ),
                      Text(
                        _serviceFee,
                        style: const TextStyle(
                          fontSize: 12,
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
                      const Expanded(
                        child: Text(
                          'Sparepart LCD Super AMOLED (Grade A)',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF334155)),
                        ),
                      ),
                      Text(
                        _partFee,
                        style: const TextStyle(
                          fontSize: 12,
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
                        'TOTAL LUNAS (TUNAI)',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                      Text(
                        _totalPrice,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Garansi Toko: $_warrantyText (Segel tidak rusak)',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nota servis fisik $_orderId dikirim ke printer thermal.',
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
                'Cetak Sekarang (Printer Thermal)',
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
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          children: [
            _buildHeroStatusSection(),
            const SizedBox(height: 20),
            _buildHandoverInstructionCard(),
            const SizedBox(height: 16),
            _buildCashBillCard(),
            const SizedBox(height: 16),
            _buildWorkReceiptCard(),
            const SizedBox(height: 16),
            _buildCustomerContactCard(),
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
            'Konfirmasi Pembayaran',
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

  // Bagian Atas: Ikon Centang Teal, Status Pill & Judul Penyerahan
  Widget _buildHeroStatusSection() {
    return Column(
      children: [
        SizedBox(
          width: 84,
          height: 84,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  color: Color(0xFFD1FAE5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B6E64),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.smartphone_rounded,
                    color: Color(0xFF1D5CE5),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF99F6E4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.circle,
                size: 7,
                color: Color(0xFF0B6E64),
              ),
              SizedBox(width: 7),
              Text(
                'SIAP DISERAHKAN • LUNAS DI TEMPAT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0B6E64),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Menunggu Pengambilan &\nPembayaran',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            height: 1.25,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF475569),
                height: 1.45,
              ),
              children: [
                const TextSpan(text: 'HP '),
                TextSpan(
                  text: _deviceName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const TextSpan(
                  text: ' telah selesai diperbaiki dan siap diserahkan kepada pelanggan ',
                ),
                TextSpan(
                  text: _customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Kartu 1: Instruksi Serah Terima Unit
  Widget _buildHandoverInstructionCard() {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: Color(0xFF1D5CE5),
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instruksi Serah Terima Unit',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Pelanggan akan datang langsung ke toko fisik Anda. Lakukan cek fungsi layar & touch screen bersama di meja servis sebelum menerima uang tunai.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF475569),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Kartu 2: Total Tagihan Tunai (Cash)
  Widget _buildCashBillCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFDDF5F0),
        borderRadius: BorderRadius.circular(22),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          painter: _CashTargetWatermarkPainter(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      size: 18,
                      color: Color(0xFF0B6E64),
                    ),
                    SizedBox(width: 7),
                    Text(
                      'TOTAL TAGIHAN TUNAI (CASH)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0B6E64),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _totalPrice,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        color: Color(0xFF78350F),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Khusus Uang Tunai di Etalase Toko',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF78350F),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tidak menerima transfer bank, QRIS, atau dompet digital untuk pesanan ini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kartu 3: Rincian Nota Kerja
  Widget _buildWorkReceiptCard() {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 19,
                    color: Color(0xFF1D5CE5),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Rincian Nota Kerja',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _orderId,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Item 1
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF1D5CE5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Jasa Teknisi Ganti LCD',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
              Text(
                _serviceFee,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Item 2
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D5CE5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _partName,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF334155),
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _partFee,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFE2E8F0)),
          ),

          // Garansi Toko Mitra
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: 17,
                    color: Color(0xFF0B6E64),
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Garansi Toko Mitra',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0B6E64),
                    ),
                  ),
                ],
              ),
              Text(
                _warrantyText,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B6E64),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Kartu 4: Kontak Pelanggan
  Widget _buildCustomerContactCard() {
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
      child: Row(
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _customerName,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.call_outlined,
                      size: 13.5,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _phoneNumber,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _callCustomer,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.call_outlined,
                size: 19,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sticky Bottom Action Bar
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
              onPressed: _confirmCashReceived,
              icon: const Icon(Icons.payments_outlined, size: 20),
              label: const Text(
                'Konfirmasi Uang Tunai Diterima',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B6E64),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _showPrintReceiptSheet,
              icon: const Icon(Icons.print_outlined, size: 19),
              label: const Text(
                'Cetak Nota Servis Fisik',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6ECF8),
                foregroundColor: const Color(0xFF1E293B),
                minimumSize: const Size(double.infinity, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CashTargetWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF0B6E64).withValues(alpha: 0.12)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF0B6E64).withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.87, size.height * 0.78);
    canvas.drawCircle(center, 46, strokePaint);
    canvas.drawCircle(center, 12, fillPaint);

    canvas.drawLine(
      Offset(center.dx, center.dy - 54),
      Offset(center.dx, center.dy - 36),
      strokePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy + 36),
      Offset(center.dx, center.dy + 54),
      strokePaint,
    );
    canvas.drawLine(
      Offset(center.dx - 54, center.dy),
      Offset(center.dx - 36, center.dy),
      strokePaint,
    );
    canvas.drawLine(
      Offset(center.dx + 36, center.dy),
      Offset(center.dx + 54, center.dy),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}