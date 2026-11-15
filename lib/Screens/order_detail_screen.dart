import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // 0 = A. Antar HP (Oranye - Default saat halaman dibuka)
  // 1 = B. Masuk Antrean (Kuning/Amber)
  // 2 = C. Diproses (Biru)
  // 3 = D. Selesai (Hijau Tosca)
  int _currentStage = 0;

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
            _buildOrderIdBadge(),
            const SizedBox(height: 14),
            _buildPartnerCard(),
            const SizedBox(height: 16),
            _buildStageSwitcher(),
            const SizedBox(height: 16),
            _buildDynamicStatusBanner(),
            const SizedBox(height: 18),
            _buildProgressTimelineCard(),
            const SizedBox(height: 18),
            _buildTechnicianNoteCard(),
            const SizedBox(height: 18),
            _buildCostAndWarrantyCard(),
            const SizedBox(height: 24),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, '/order');
          }
        },
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
            'Pelacakan Servis',
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

  Widget _buildOrderIdBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE3ECFF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Color(0xFF0F766E),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'ORDER\nID',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
              height: 1.2,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '#SRV-2026-\n00125',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1D5CE5),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard() {
    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CustomPaint(
          painter: _CardCircuitPainter(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.store_mall_directory_rounded,
                        color: Color(0xFF475569),
                        size: 30,
                      ),
                    ),
                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F766E),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.build_rounded,
                          color: Colors.white,
                          size: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dandani Cell Purwokerto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
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
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFF59E0B),
                                  size: 14,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB45309),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              '• Mitra Resmi Dandani',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 14.5,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Jl. HR Boenyamin No. 42, Grendeng, Purwokerto',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF475569),
                                height: 1.35,
                              ),
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
        ),
      ),
    );
  }

  // Switcher 4 Tahap: A. Antar HP | B. Masuk Antrean | C. Diproses | D. Selesai
  Widget _buildStageSwitcher() {
    final tabs = [
      {
        'label': 'A. Antar\nHP',
        'activeColor': const Color(0xFFEA580C),
      },
      {
        'label': 'B. Masuk\nAntrean',
        'activeColor': const Color(0xFFB45309),
      },
      {
        'label': 'C. Sedang\nDiproses',
        'activeColor': const Color(0xFF1D5CE5),
      },
      {
        'label': 'D. Selesai\n(Aktif)',
        'activeColor': const Color(0xFF0F766E),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _currentStage == index;
          final activeColor = tabs[index]['activeColor'] as Color;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentStage = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  tabs[index]['label'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? activeColor : const Color(0xFF475569),
                    height: 1.25,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Banner Status Dinamis A -> B -> C -> D
  Widget _buildDynamicStatusBanner() {
    late List<Color> gradientColors;
    late Color iconCircleColor;
    late Color iconColor;
    late IconData iconData;
    late String title;
    late Widget descriptionWidget;

    if (_currentStage == 0) {
      // A. SEGERA ANTAR HP KE MITRA
      gradientColors = const [Color(0xFFEA580C), Color(0xFF9A3412)];
      iconCircleColor = const Color(0xFFFFEDD5);
      iconColor = const Color(0xFF9A3412);
      iconData = Icons.storefront_rounded;
      title = '📍 Segera Antarkan HP Anda ke Mitra';
      descriptionWidget = RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            height: 1.45,
          ),
          children: [
            TextSpan(text: 'Penawaran telah disetujui! Mohon segera antarkan '),
            TextSpan(
              text: 'Samsung Galaxy A54 5G',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' Anda ke gerai '),
            TextSpan(
              text: 'Dandani Cell Purwokerto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' agar proses servis dapat segera dimulai.'),
          ],
        ),
      );
    } else if (_currentStage == 1) {
      // B. MASUK ANTREAN (Urut dari A sebelumnya)
      gradientColors = const [Color(0xFFD97706), Color(0xFF92400E)];
      iconCircleColor = const Color(0xFFFEF3C7);
      iconColor = const Color(0xFF92400E);
      iconData = Icons.hourglass_bottom_rounded;
      title = '⏳ HP Sedang Dalam Antrean Servis';
      descriptionWidget = RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            height: 1.45,
          ),
          children: [
            TextSpan(text: 'Perangkat Anda sudah aman di konter '),
            TextSpan(
              text: 'Dandani Cell Purwokerto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' dan menunggu giliran meja teknisi.'),
          ],
        ),
      );
    } else if (_currentStage == 2) {
      // C. DIPROSES (Urut dari B sebelumnya)
      gradientColors = const [Color(0xFF1D5CE5), Color(0xFF1E3A8A)];
      iconCircleColor = const Color(0xFFDBEAFE);
      iconColor = const Color(0xFF1D5CE5);
      iconData = Icons.precision_manufacturing_rounded;
      title = '⚡ Teknisi Sedang Memperbaiki HP';
      descriptionWidget = const Text(
        'Penggantian LCD sedang dilakukan oleh Mas Bayu. Pengetesan fungsi layar berlangsung.',
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
          height: 1.45,
        ),
      );
    } else {
      // D. SELESAI (Urut dari C sebelumnya)
      gradientColors = const [Color(0xFF065F46), Color(0xFF047857)];
      iconCircleColor = const Color(0xFF6EE7B7);
      iconColor = const Color(0xFF064E3B);
      iconData = Icons.celebration_rounded;
      title = '🎉 HP Anda Selesai Diperbaiki!';
      descriptionWidget = RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            height: 1.45,
          ),
          children: [
            TextSpan(
              text: 'Silakan datang ke toko untuk mengambil HP dan siapkan ',
            ),
            TextSpan(
              text: 'Pembayaran Tunai Rp350.000',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
            TextSpan(text: '.'),
          ],
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconCircleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    descriptionWidget,
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.payments_outlined,
                  color: Color(0xFFA7F3D0),
                  size: 18,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Hanya menerima pembayaran tunai di konter mitra. Tidak ada pembayaran online / transfer.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.white,
                      height: 1.35,
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

  // Kartu Timeline Progres Pengerjaan (4 Tahap A - D)
  Widget _buildProgressTimelineCard() {
    final steps = [
      {
        'title': 'Penawaran Disetujui (Antar HP)',
        'time': '12 Okt, 10:45',
        'desc':
            'Estimasi perbaikan LCD disepakati Rp350.000. Segera antarkan HP ke konter mitra.',
        'isStar': false,
      },
      {
        'title': 'Masuk Antrean',
        'time': '12 Okt, 13:10',
        'desc':
            'HP telah diserahkan di konter mitra & registrasi tiket servis dibuat.',
        'isStar': false,
      },
      {
        'title': 'Sedang Diproses',
        'time': '13 Okt, 15:30',
        'desc':
            'Teknisi membongkar unit, mengganti modul LCD baru, dan pengetesan layar sentuh.',
        'isStar': false,
      },
      {
        'title': 'Selesai (Siap Ambil)',
        'time': 'Hari ini, 16:40',
        'desc':
            'QC Passed (9/9 poin). Unit siap diambil di meja penyerahan konter.',
        'isStar': true,
      },
    ];

    final int activeStepIndex = _currentStage;

    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_tree_outlined,
                    color: Color(0xFF1D5CE5),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Progres Pengerjaan',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              if (_currentStage < 3)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F7F4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Teknisi Tersertifikasi',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F766E),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Column(
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final bool isCompleted = index < activeStepIndex;
              final bool isCurrent = index == activeStepIndex;
              final bool isStar = step['isStar'] as bool;
              final bool isLast = index == steps.length - 1;

              Color circleBgColor;
              Color circleIconColor;
              Color titleColor = const Color(0xFF0F172A);
              Color timeColor = const Color(0xFF64748B);
              FontWeight descWeight = FontWeight.normal;
              Color descColor = const Color(0xFF64748B);

              if (isCompleted) {
                circleBgColor = const Color(0xFF0F766E);
                circleIconColor = Colors.white;
              } else if (isCurrent) {
                if (_currentStage == 0) {
                  circleBgColor = const Color(0xFFEA580C); // Oranye (Antar HP)
                  descWeight = FontWeight.w600;
                  descColor = const Color(0xFF1E293B);
                } else if (_currentStage == 1) {
                  circleBgColor = const Color(0xFFD97706); // Kuning/Amber
                } else if (_currentStage == 2) {
                  circleBgColor = const Color(0xFF1D5CE5); // Biru
                } else {
                  circleBgColor = const Color(0xFF0F766E); // Hijau Tosca
                  titleColor = const Color(0xFF0F766E);
                  timeColor = const Color(0xFF0F766E);
                  descWeight = FontWeight.w600;
                  descColor = const Color(0xFF1E293B);
                }
                circleIconColor = Colors.white;
              } else {
                circleBgColor = const Color(0xFFE2E8F0);
                circleIconColor = const Color(0xFF94A3B8);
                if (isStar) {
                  titleColor = const Color(0xFF0F766E);
                  timeColor = const Color(0xFF0F766E);
                }
              }

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 28,
                      child: Column(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: circleBgColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isStar
                                  ? Icons.star_rounded
                                  : (index == 0 && isCurrent)
                                      ? Icons.directions_walk_rounded
                                      : Icons.check_rounded,
                              color: circleIconColor,
                              size: 15,
                            ),
                          ),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                color: isCompleted
                                    ? const Color(0xFF5EEAD4)
                                    : const Color(0xFFE2E8F0),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 4 : 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          step['title'] as String,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: titleColor,
                                          ),
                                        ),
                                      ),
                                      if (isStar && isCurrent) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF0F766E),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  step['time'] as String,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: isCurrent
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: timeColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step['desc'] as String,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: descWeight,
                                color: descColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianNoteCard() {
    return Container(
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
                Icons.assignment_turned_in_outlined,
                color: Color(0xFF1D5CE5),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Catatan Teknisi',
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '“LCD Original terpasang rapi, sensor proximity & fingerprint layar berfungsi normal. Garansi toko berlaku 30 hari sejak serah terima fisik HP.”',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 16,
                      color: Color(0xFF0F766E),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'PEMERIKSAAN: MAS BAYU (SENIOR TECH)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostAndWarrantyCard() {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rincian Biaya & Garansi',
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
                  color: const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Cash On Counter',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F766E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCostRow(
            label: 'Penggantian LCD Samsung A54 (OEM Ori)',
            value: 'Rp350.000',
          ),
          const SizedBox(height: 10),
          _buildCostRow(
            label: 'Biaya Jasa Pasang & QC Hardware',
            value: 'Termasuk (Gratis)',
            valueColor: const Color(0xFF0F766E),
          ),
          const SizedBox(height: 10),
          _buildCostRow(
            label: 'Masa Garansi Mitra Toko',
            value: '30 Hari Kalender',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFE2E8F0)),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL TAGIHAN TUNAI',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Bayar pas saat serah terima',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
              Text(
                'Rp350.000',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D5CE5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF1D5CE5),
                    size: 18,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Mohon periksa layar, kamera depan, dan sentuhan bersama teknisi sebelum membayarkan uang tunai.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF334155),
                      height: 1.4,
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

  Widget _buildCostRow({
    required String label,
    required String value,
    Color valueColor = const Color(0xFF0F172A),
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF475569),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    final bool isCompleted = _currentStage == 3;

    return Column(
      children: [
        ElevatedButton(
          onPressed: isCompleted
              ? () => Navigator.pushNamed(context, '/ulasan')
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1D5CE5),
            disabledBackgroundColor: const Color(0xFFCBD5E1),
            foregroundColor: Colors.white,
            disabledForegroundColor: const Color(0xFF64748B),
            minimumSize: const Size(double.infinity, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 20),
              SizedBox(width: 8),
              Text(
                'Konfirmasi HP Diterima & Beri Ulasan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ada kendala saat pengambilan? ',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF475569),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Hubungi CS Mitra',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D5CE5),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF1D5CE5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardCircuitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.08)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF1D5CE5).withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.78, 0)
      ..lineTo(size.width * 0.78, size.height * 0.35)
      ..lineTo(size.width * 0.94, size.height * 0.65)
      ..lineTo(size.width * 0.94, size.height);

    canvas.drawPath(path, paint);
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.35),
      3.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}