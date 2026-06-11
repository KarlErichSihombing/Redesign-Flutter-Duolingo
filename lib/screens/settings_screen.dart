import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
enum SettingsTab { akun, belajar, notifikasi, tampilan, privasi, koneksi }

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsTab _activeTab = SettingsTab.akun;
  bool _hasChanges = false;

  // Akun state
  final _nameCtrl = TextEditingController(text: 'Kamu Belajar');
  final _usernameCtrl = TextEditingController(text: 'kamu_belajar');
  final _emailCtrl = TextEditingController(text: 'kamu@email.com');
  String _lang = '🇮🇩 Bahasa Indonesia';
  bool _twoFactor = false;

  // Belajar state
  int _xpGoal = 20;
  bool _speakPractice = true;
  bool _listenPractice = true;
  bool _shuffleMode = false;
  bool _aiAdapt = true;
  String _sessionDuration = '10 menit';

  // Notifikasi state
  TimeOfDay _reminderTime = const TimeOfDay(hour: 19, minute: 0);
  bool _reminderOn = true;
  bool _streakNotif = true;
  bool _missionNotif = true;
  bool _unitNotif = false;
  bool _competitionNotif = true;
  bool _friendBeatNotif = true;
  bool _leagueEndNotif = true;
  bool _promoNotif = false;
  bool _pushNotif = true;
  bool _emailWeekly = true;

  // Tampilan state
  String _theme = 'Terang';
  String _fontSize = 'Normal';
  bool _animations = true;
  bool _sound = true;
  bool _haptic = true;
  Color _accentColor = AppColors.featherGreen;

  // Privasi state
  bool _publicProfile = true;
  bool _showLeaderboard = true;
  bool _shareStats = false;
  String _followWho = 'Hanya teman teman';
  bool _analytics = true;
  bool _cookies = false;

  // Promo code
  final _promoCtrl = TextEditingController();

  void _markChanged() => setState(() => _hasChanges = true);
  void _saveChanges() => setState(() => _hasChanges = false);
  void _cancelChanges() => setState(() => _hasChanges = false);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  return isMobile
      ? Stack(
          children: [
            Column(
              children: [
                _buildProfileCard(compact: true),
                _buildTabBar(scrollable: true),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(14, 16, 14, 100),
                    child: _buildActivePane(),
                  ),
                ),
              ],
            ),
            if (_hasChanges) _buildSaveBar(),
          ],
        )
      : Stack(
          children: [
            _buildWideLayout(),
            if (_hasChanges) _buildSaveBar(),
          ],
        );
}
  // ── Mobile: tabs on top, content below ──────────────────────
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildProfileCard(compact: true),
        _buildTabBar(scrollable: true),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 100),
          child: _buildActivePane(),
        )),
      ],
    );
  }

  // ── Wide: tab list on left, content on right ─────────────────
  Widget _buildWideLayout() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Profile card full width
        _buildProfileCard(compact: false),
        const SizedBox(height: 20),
        // Tab bar + content dalam satu card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tab bar horizontal (underline style)
              _buildTabBar(scrollable: false),
              const Divider(height: 1, color: AppColors.border),
              // Konten tab
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildActivePane(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // ── Profile Card ─────────────────────────────────────────────
  Widget _buildProfileCard({required bool compact}) {
    return Container(
      margin: EdgeInsets.all(compact ? 14 : 0),
      padding: EdgeInsets.all(compact ? 18 : 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0f3460), Color(0xFF1a1a2e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 24, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: compact ? 60 : 80,
                height: compact ? 60 : 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.featherGreen, Color(0xFF89E219)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.25), width: 4),
                ),
                child: Center(
                  child: Text('KM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: compact ? 18 : 24,
                          fontWeight: FontWeight.w900)),
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.featherGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(child: Text('✏️', style: TextStyle(fontSize: 10))),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('⚙️ PENGATURAN AKUN',
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w800,
                        letterSpacing: 1.5, color: AppColors.featherGreen)),
                const SizedBox(height: 4),
                Text('Kamu',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: compact ? 18 : 24,
                        fontWeight: FontWeight.w900)),
                const Text('@kamu_belajar · Bergabung Maret 2024',
                    style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6, runSpacing: 6,
                  children: const [
                    _PcBadge('🔥 14 hari streak'),
                    _PcBadge('⭐ Liga Perunggu'),
                    _PcBadge('🇬🇧 Belajar Inggris'),
                  ],
                ),
              ],
            ),
          ),
          if (!compact) ...[
  const SizedBox(width: 20),
  // Stats boxes
  Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      // Tombol Edit Profil
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.featherGreen,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppColors.maskGreen,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
        ),
        child: const Text('✏️ Edit Profil',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.5)),
      ),
      const SizedBox(height: 12),
      // 3 stat chips horizontal
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ProfileStat('⚡', '1,240', 'Total XP'),
          const SizedBox(width: 8),
          _ProfileStat('📅', '23', 'Sesi Belajar'),
          const SizedBox(width: 8),
          _ProfileStat('🎯', '87%', 'Akurasi'),
        ],
      ),
    ],
  ),
],
        ],
      ),
    );
  }

  // ── Side tab (desktop/tablet) ────────────────────────────────
  // ── Side tab (desktop/tablet) ────────────────────────────────
  Widget _buildSideTab(SettingsTab tab) {
    final active = _activeTab == tab;
    final (icon, label) = _tabMeta(tab);
    
    // Custom label agar namanya sama dengan keinginan lu di gambar
    String customLabel = label;
    if (tab == SettingsTab.belajar) customLabel = 'Pembelajaran';

    return GestureDetector(
      onTap: () => setState(() => _activeTab = tab),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8), // Beri jarak antar tombol menu
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // Jika aktif, beri warna background hijau transparan (opacity 12%)
          color: active ? AppColors.featherGreen.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12), // Sudut tumpul modern
          // Jika aktif, buat border penuh mengelilingi tombol menu
          border: Border.all(
            color: active ? AppColors.featherGreen : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 12),
            Text(
              customLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: active ? FontWeight.bold : FontWeight.w600,
                color: active ? AppColors.featherGreen : AppColors.eel,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Scrollable tab bar (mobile) ──────────────────────────────
  Widget _buildTabBar({required bool scrollable}) {
  final tabs = SettingsTab.values;

  final inner = Row(
    mainAxisSize: scrollable ? MainAxisSize.min : MainAxisSize.max,
    children: tabs.map((tab) {
      final active = _activeTab == tab;
      final (icon, label) = _tabMeta(tab);
      return Expanded(
        flex: scrollable ? 0 : 1,
        child: GestureDetector(
          onTap: () => setState(() => _activeTab = tab),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: active ? AppColors.featherGreen : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(icon, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: active
                        ? AppColors.featherGreen
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );

  if (scrollable) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: inner,
      ),
    );
  }

  // Wide: full width, tabs rata merata
  return Container(
    color: Colors.white,
    child: inner,
  );
}

  // ── Active pane router ───────────────────────────────────────
  Widget _buildActivePane() {
    switch (_activeTab) {
      case SettingsTab.akun:        return _buildPaneAkun();
      case SettingsTab.belajar:     return _buildPaneBelajar();
      case SettingsTab.notifikasi:  return _buildPaneNotifikasi();
      case SettingsTab.tampilan:    return _buildPaneTampilan();
      case SettingsTab.privasi:     return _buildPanePrivasi();
      case SettingsTab.koneksi:     return _buildPaneKoneksi();
    }
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: AKUN
  // ══════════════════════════════════════════════════════════════
  Widget _buildPaneAkun() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Informasi Pribadi',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '👤',
              label: 'Nama Lengkap',
              desc: 'Nama yang ditampilkan ke teman',
              control: _SetInput(controller: _nameCtrl, onChanged: (_) => _markChanged()),
            ),
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '🏷️',
              label: 'Username',
              desc: 'Unik, digunakan untuk dicari teman',
              control: _SetInput(controller: _usernameCtrl, onChanged: (_) => _markChanged()),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '📧',
              label: 'Email',
              desc: 'Untuk login dan notifikasi penting',
              control: _SetInput(controller: _emailCtrl, keyboardType: TextInputType.emailAddress, onChanged: (_) => _markChanged()),
            ),
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '🌏',
              label: 'Bahasa Antarmuka',
              desc: 'Bahasa untuk tampilan aplikasi',
              control: _SetDropdown<String>(
                value: _lang,
                items: const ['🇮🇩 Bahasa Indonesia', '🇬🇧 English', '🇯🇵 日本語', '🇰🇷 한국어'],
                onChanged: (v) { setState(() => _lang = v!); _markChanged(); },
              ),
            ),
          ],
        ),
        _SetSection(
          title: 'Keamanan',
          children: [
            _SetRow(
              iconBg: const Color(0xFFFFF0F0),
              icon: '🔑',
              label: 'Kata Sandi',
              desc: 'Terakhir diubah 3 bulan lalu',
              control: _SetButton(label: 'Ubah Kata Sandi', onTap: _markChanged),
            ),
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '🛡️',
              label: 'Verifikasi Dua Langkah',
              desc: 'Keamanan ekstra untuk akunmu',
              control: _SetToggle(value: _twoFactor, onChanged: (v) { setState(() => _twoFactor = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '📱',
              label: 'Sesi Aktif',
              desc: 'Perangkat yang sedang login',
              control: _SetButton(label: 'Lihat Sesi', onTap: () {}),
            ),
          ],
        ),
        _DangerZone(),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: BELAJAR
  // ══════════════════════════════════════════════════════════════
  Widget _buildPaneBelajar() {
    final goals = [10, 20, 30, 50];
    final goalLabels = ['Santai', 'Reguler', 'Serius', 'Intensif'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Target Harian',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '⚡',
              label: 'Target XP Harian',
              desc: 'Pilih seberapa intensif kamu belajar',
              control: Wrap(
                spacing: 8, runSpacing: 8,
                children: List.generate(goals.length, (i) {
                  final active = _xpGoal == goals[i];
                  return GestureDetector(
                    onTap: () { setState(() => _xpGoal = goals[i]); _markChanged(); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFFF0FDE0) : Colors.white,
                        border: Border.all(
                          color: active ? AppColors.featherGreen : AppColors.border,
                          width: active ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text('${goals[i]}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900,
                                  color: active ? AppColors.featherGreen : AppColors.textPrimary)),
                          Text(goalLabels[i],
                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        _SetSection(
          title: 'Bahasa yang Dipelajari',
          children: [
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '🇬🇧',
              label: 'Bahasa Inggris',
              desc: 'Tingkat Menengah · 1,240 XP',
              control: _SetButton(label: 'Aktif ✓', primary: true, onTap: () {}),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF8E0),
              icon: '🇯🇵',
              label: 'Bahasa Jepang',
              desc: 'Pemula · 120 XP',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SetButton(label: 'Pindah', onTap: () {}),
                  const SizedBox(width: 6),
                  _SetButton(label: '✕', danger: true, onTap: () {}),
                ],
              ),
            ),
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '➕',
              label: 'Tambah Bahasa Baru',
              desc: 'Jelajahi 40+ bahasa tersedia',
              control: _SetButton(label: '+ Tambah', primary: true, onTap: () {}),
            ),
          ],
        ),
        _SetSection(
          title: 'Preferensi Latihan',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF3E8FF),
              icon: '🎤',
              label: 'Latihan Berbicara',
              desc: 'Aktifkan latihan ucapan via mikrofon',
              control: _SetToggle(value: _speakPractice, onChanged: (v) { setState(() => _speakPractice = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '👂',
              label: 'Latihan Mendengar',
              desc: 'Soal berdasarkan audio bahasa target',
              control: _SetToggle(value: _listenPractice, onChanged: (v) { setState(() => _listenPractice = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '🔀',
              label: 'Mode Acak Soal',
              desc: 'Acak urutan latihan setiap sesi',
              control: _SetToggle(value: _shuffleMode, onChanged: (v) { setState(() => _shuffleMode = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '🤖',
              label: 'Adaptasi AI',
              desc: 'Sesuaikan kesulitan otomatis berdasar performa',
              control: _SetToggle(value: _aiAdapt, onChanged: (v) { setState(() => _aiAdapt = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '⏱️',
              label: 'Durasi Sesi Default',
              desc: 'Batas waktu per sesi belajar',
              control: _SetDropdown<String>(
                value: _sessionDuration,
                items: const ['5 menit', '10 menit', '15 menit', '20 menit', 'Tanpa batas'],
                onChanged: (v) { setState(() => _sessionDuration = v!); _markChanged(); },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: NOTIFIKASI
  // ══════════════════════════════════════════════════════════════
  Widget _buildPaneNotifikasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Jadwal Pengingat',
          children: [
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '⏰',
              label: 'Pengingat Belajar Harian',
              desc: 'Notifikasi push di waktu yang kamu pilih',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final t = await showTimePicker(context: context, initialTime: _reminderTime);
                      if (t != null) { setState(() => _reminderTime = t); _markChanged(); }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bg,
                      ),
                      child: Text(
                        '${_reminderTime.hour.toString().padLeft(2, '0')}:${_reminderTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _SetToggle(value: _reminderOn, onChanged: (v) { setState(() => _reminderOn = v); _markChanged(); }),
                ],
              ),
            ),
          ],
        ),
        _SetSection(
          title: 'Kategori Notifikasi',
          children: [
            _NotifCategory(
              title: '📚 Pembelajaran',
              masterValue: true,
              onMasterChanged: (_) => _markChanged(),
              rows: [
                _NotifRow('Pengingat streak harian', _streakNotif, (v) { setState(() => _streakNotif = v); _markChanged(); }),
                _NotifRow('Misi baru tersedia', _missionNotif, (v) { setState(() => _missionNotif = v); _markChanged(); }),
                _NotifRow('Unit baru terbuka', _unitNotif, (v) { setState(() => _unitNotif = v); _markChanged(); }),
              ],
            ),
            const SizedBox(height: 10),
            _NotifCategory(
              title: '🏆 Kompetisi',
              masterValue: _competitionNotif,
              onMasterChanged: (v) { setState(() => _competitionNotif = v); _markChanged(); },
              rows: [
                _NotifRow('Teman mengalahkan XP-mu', _friendBeatNotif, (v) { setState(() => _friendBeatNotif = v); _markChanged(); }),
                _NotifRow('Akhir musim liga mendekat', _leagueEndNotif, (v) { setState(() => _leagueEndNotif = v); _markChanged(); }),
                _NotifRow('Hasil promosi/degradasi liga', true, (_) => _markChanged()),
              ],
            ),
            const SizedBox(height: 10),
            _NotifCategory(
              title: '📣 Update & Promo',
              masterValue: _promoNotif,
              onMasterChanged: (v) { setState(() => _promoNotif = v); _markChanged(); },
              rows: [
                _NotifRow('Fitur baru Duolingo', false, (_) => _markChanged()),
                _NotifRow('Promo & diskon Toko', false, (_) => _markChanged()),
              ],
            ),
          ],
        ),
        _SetSection(
          title: 'Saluran Notifikasi',
          children: [
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '📱',
              label: 'Push Notification',
              desc: 'Notifikasi langsung di perangkat',
              control: _SetToggle(value: _pushNotif, onChanged: (v) { setState(() => _pushNotif = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '📧',
              label: 'Email Mingguan',
              desc: 'Ringkasan progres setiap minggu',
              control: _SetToggle(value: _emailWeekly, onChanged: (v) { setState(() => _emailWeekly = v); _markChanged(); }),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: TAMPILAN
  // ══════════════════════════════════════════════════════════════
  Widget _buildPaneTampilan() {
    final themes = ['Terang', 'Gelap', 'Otomatis'];
    final themeIcons = ['☀️', '🌙', '🔄'];
    final accentColors = [
      AppColors.featherGreen,
      AppColors.macaw,
      AppColors.beetle,
      AppColors.fox,
      AppColors.cardinal,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Tema',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '🌗',
              label: 'Mode Tampilan',
              desc: 'Terang, gelap, atau ikuti sistem',
              control: Wrap(
                spacing: 8,
                children: List.generate(themes.length, (i) {
                  final active = _theme == themes[i];
                  return GestureDetector(
                    onTap: () { setState(() => _theme = themes[i]); _markChanged(); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFFF0FDE0) : Colors.white,
                        border: Border.all(
                          color: active ? AppColors.featherGreen : AppColors.border,
                          width: active ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${themeIcons[i]} ${themes[i]}',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700,
                              color: active ? AppColors.featherGreen : AppColors.textMuted)),
                    ),
                  );
                }),
              ),
            ),
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '🎨',
              label: 'Warna Aksen',
              desc: 'Warna utama antarmuka',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: accentColors.map((c) {
                  final selected = _accentColor == c;
                  return GestureDetector(
                    onTap: () { setState(() => _accentColor = c); _markChanged(); },
                    child: Container(
                      width: 28, height: 28,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? c.withOpacity(0.6) : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: selected
                            ? [BoxShadow(color: c.withOpacity(0.4), blurRadius: 6, spreadRadius: 1)]
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        _SetSection(
          title: 'Ukuran & Animasi',
          children: [
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '🔠',
              label: 'Ukuran Teks',
              desc: 'Sesuaikan keterbacaan',
              control: _SetDropdown<String>(
                value: _fontSize,
                items: const ['Kecil', 'Normal', 'Besar', 'Sangat Besar'],
                onChanged: (v) { setState(() => _fontSize = v!); _markChanged(); },
              ),
            ),
            _SetRow(
              iconBg: const Color(0xFFF3E8FF),
              icon: '✨',
              label: 'Animasi & Efek',
              desc: 'Nonaktifkan untuk hemat baterai',
              control: _SetToggle(value: _animations, onChanged: (v) { setState(() => _animations = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '🔊',
              label: 'Efek Suara',
              desc: 'Suara saat menjawab benar/salah',
              control: _SetToggle(value: _sound, onChanged: (v) { setState(() => _sound = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '📳',
              label: 'Getaran (Haptic)',
              desc: 'Umpan balik getar di perangkat mobile',
              control: _SetToggle(value: _haptic, onChanged: (v) { setState(() => _haptic = v); _markChanged(); }),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: PRIVASI
  // ══════════════════════════════════════════════════════════════
  Widget _buildPanePrivasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Visibilitas Profil',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '👁️',
              label: 'Profil Publik',
              desc: 'Izinkan siapa pun melihat profilmu',
              control: _SetToggle(value: _publicProfile, onChanged: (v) { setState(() => _publicProfile = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFE8F4FF),
              icon: '🏆',
              label: 'Tampil di Leaderboard',
              desc: 'Muncul di papan peringkat publik',
              control: _SetToggle(value: _showLeaderboard, onChanged: (v) { setState(() => _showLeaderboard = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFF3E8FF),
              icon: '📊',
              label: 'Bagikan Statistik',
              desc: 'Teman dapat melihat XP dan streak-mu',
              control: _SetToggle(value: _shareStats, onChanged: (v) { setState(() => _shareStats = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '👥',
              label: 'Siapa yang Bisa Mengikuti',
              desc: 'Kontrol permintaan pertemanan',
              control: _SetDropdown<String>(
                value: _followWho,
                items: const ['Semua orang', 'Hanya teman teman', 'Tidak ada'],
                onChanged: (v) { setState(() => _followWho = v!); _markChanged(); },
              ),
            ),
          ],
        ),
        _SetSection(
          title: 'Data & Analitik',
          children: [
            _SetRow(
              iconBg: const Color(0xFFF5F5F5),
              icon: '📈',
              label: 'Analitik Penggunaan',
              desc: 'Bantu kami meningkatkan kualitas app',
              control: _SetToggle(value: _analytics, onChanged: (v) { setState(() => _analytics = v); _markChanged(); }),
            ),
            _SetRow(
              iconBg: const Color(0xFFFFF0F0),
              icon: '🍪',
              label: 'Cookie Analitik',
              desc: 'Data anonim untuk peningkatan layanan',
              control: _SetToggle(value: _cookies, onChanged: (v) { setState(() => _cookies = v); _markChanged(); }),
            ),
          ],
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TAB: KONEKSI
  // ══════════════════════════════════════════════════════════════
  Widget _buildPaneKoneksi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SetSection(
          title: 'Akun Terhubung',
          children: [
            _ConnectedRow(logo: '🔵', name: 'Facebook', status: '✓ Terhubung sebagai Kamu Belajar', connected: true),
            _ConnectedRow(logo: '🔴', name: 'Google', status: '✓ kamu@gmail.com', connected: true),
            _ConnectedRow(logo: '⬛', name: 'Apple ID', status: 'Belum terhubung', connected: false),
            _ConnectedRow(logo: '🐦', name: 'Twitter / X', status: 'Belum terhubung', connected: false),
          ],
        ),
        _SetSection(
          title: 'Langganan',
          children: [
            _SetRow(
              iconBg: const Color(0xFFFFF4E0),
              icon: '👑',
              label: 'Duolingo Super',
              desc: 'Belajar tanpa iklan, nyawa tak terbatas & lebih banyak',
              control: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.bee, AppColors.fox]),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: AppColors.fox.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('✨ Upgrade', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                ),
              ),
            ),
            _SetRow(
              iconBg: const Color(0xFFF0FDE0),
              icon: '🎁',
              label: 'Kode Hadiah / Promo',
              desc: 'Masukkan kode untuk bonus',
              control: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      controller: _promoCtrl,
                      decoration: InputDecoration(
                        hintText: 'Masukkan kode...',
                        hintStyle: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.border, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.border, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.featherGreen, width: 2),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _SetButton(label: 'Klaim', primary: true, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Save bar (floating) ──────────────────────────────────────
  Widget _buildSaveBar() {
    return Positioned(
      bottom: 20, left: 20, right: 20,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.eel,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, 8))],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ada perubahan yang belum disimpan',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(width: 14),
              GestureDetector(
                onTap: _saveChanges,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.featherGreen,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: AppColors.maskGreen, blurRadius: 0, offset: const Offset(0, 3))],
                  ),
                  child: const Text('💾 Simpan',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _cancelChanges,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Batal',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Tab metadata ─────────────────────────────────────────────
  (String, String) _tabMeta(SettingsTab tab) {
    switch (tab) {
      case SettingsTab.akun:        return ('👤', 'Akun');
      case SettingsTab.belajar:     return ('📚', 'Pembelajaran');
      case SettingsTab.notifikasi:  return ('🔔', 'Notifikasi');
      case SettingsTab.tampilan:    return ('🎨', 'Tampilan');
      case SettingsTab.privasi:     return ('🔒', 'Privasi');
      case SettingsTab.koneksi:     return ('🔗', 'Koneksi');
    }
  }
}

// ─────────────────────────────────────────────
//  REUSABLE SETTING WIDGETS
// ─────────────────────────────────────────────

// Section wrapper
class _SetSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SetSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w900,
                      color: AppColors.textMuted, letterSpacing: 1.2)),
              const SizedBox(width: 10),
              const Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Individual setting row
class _SetRow extends StatelessWidget {
  final Color iconBg;
  final String icon;
  final String label;
  final String desc;
  final Widget control;

  const _SetRow({
    required this.iconBg,
    required this.icon,
    required this.label,
    required this.desc,
    required this.control,
  });

  @override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  if (isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(desc, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600, height: 1.4)),
                  ],
                ),
              ),
              // Hanya toggle/button yang ada di Row — bukan input teks
              if (control is! _SetInput) control,
            ],
          ),
          // Input teks ditaruh di bawah, full width
          if (control is _SetInput) ...[
            const SizedBox(height: 8),
            control,
          ],
          const Divider(color: Color(0xFFF0F0F0), height: 20),
        ],
      ),
    );
  }

  // Desktop/tablet — sama seperti sebelumnya
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.w600, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            control,
          ],
        ),
        const SizedBox(height: 12),
        const Divider(color: Color(0xFFF7F7F7), height: 1),
      ],
    ),
  );
}
}

// Toggle switch
class _SetToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SetToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.featherGreen,
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}

// Dropdown selector
class _SetDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  const _SetDropdown({required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.bg,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<T>(
        value: value,
        underline: const SizedBox(),
        isDense: true,
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary, fontFamily: 'Nunito'),
        items: items.map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        )).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

// Text input
class _SetInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  const _SetInput({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 600;
  return SizedBox(
    width: isMobile ? double.infinity : 200, // ← ini aman karena sudah di luar Row
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.featherGreen, width: 2),
        ),
      ),
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
    ),
  );
}
}

// Action button
class _SetButton extends StatelessWidget {
  final String label;
  final bool primary;
  final bool danger;
  final VoidCallback onTap;
  const _SetButton({
    required this.label,
    this.primary = false,
    this.danger = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color border;

    if (primary) {
      bg = AppColors.featherGreen;
      fg = Colors.white;
      border = AppColors.featherGreen;
    } else if (danger) {
      bg = const Color(0xFFFFF0F0);
      fg = AppColors.cardinal;
      border = const Color(0xFFFFCCCC);
    } else {
      bg = AppColors.bg;
      fg = AppColors.textPrimary;
      border = AppColors.border;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border, width: 2),
          boxShadow: primary
              ? [BoxShadow(color: AppColors.maskGreen, blurRadius: 0, offset: const Offset(0, 3))]
              : null,
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w800, color: fg)),
      ),
    );
  }
}

// Notification category block
class _NotifCategory extends StatelessWidget {
  final String title;
  final bool masterValue;
  final ValueChanged<bool> onMasterChanged;
  final List<_NotifRow> rows;

  const _NotifCategory({
    required this.title,
    required this.masterValue,
    required this.onMasterChanged,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
              const Spacer(),
              Switch(
                value: masterValue,
                onChanged: onMasterChanged,
                activeColor: AppColors.featherGreen,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ],
          ),
          ...rows,
        ],
      ),
    );
  }
}

class _NotifRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _NotifRow(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Color(0xFFEFEFEF), height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.featherGreen,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Connected account row
class _ConnectedRow extends StatelessWidget {
  final String logo;
  final String name;
  final String status;
  final bool connected;
  const _ConnectedRow({
    required this.logo,
    required this.name,
    required this.status,
    required this.connected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(logo, style: const TextStyle(fontSize: 22))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    Text(status,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: connected ? AppColors.featherGreen : AppColors.textMuted)),
                  ],
                ),
              ),
              _SetButton(
                label: connected ? 'Putuskan' : 'Hubungkan',
                primary: !connected,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFF7F7F7), height: 1),
        ],
      ),
    );
  }
}

// Danger zone
class _DangerZone extends StatelessWidget {
  const _DangerZone();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        border: Border.all(color: const Color(0xFFFFCCCC), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⚠️ ZONA BERBAHAYA',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w900,
                  color: AppColors.cardinal, letterSpacing: 1)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: [
              _SetButton(label: '🗑️ Hapus Akun', danger: true, onTap: () {}),
              _SetButton(label: '⛔ Nonaktifkan Akun', danger: true, onTap: () {}),
              _SetButton(label: '📥 Unduh Data Saya', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

// Profile card badge
class _PcBadge extends StatelessWidget {
  final String text;
  const _PcBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11, fontWeight: FontWeight.w800,
              color: Colors.white70)),
    );
  }
}
class _ProfileStat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _ProfileStat(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 5),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
