import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_data.dart';
import '../widgets/widgets.dart';
import 'leaderboard_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _drawerOpen = false;

  final List<_NavItem> _navItems = const [
    _NavItem('🏠', 'Beranda'),
    _NavItem('🎯', 'Misi'),
    _NavItem('🏆', 'Leaderboard'),
    _NavItem('👤', 'Profil'),
    _NavItem('🛒', 'Toko'),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // Breakpoints: mobile < 600, tablet 600-1024, desktop > 1024
    final isMobile = w < 600;
    final isTablet = w >= 600 && w < 1024;
    final isDesktop = w >= 1024;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(isMobile, isTablet),
      drawer: isMobile ? _buildDrawer() : null,
      body: isDesktop
          ? _buildDesktopLayout()
          : isTablet
              ? _buildTabletLayout()
              : _buildMobileLayout(),
      bottomNavigationBar: isMobile ? _buildBottomNav() : null,
    );
  }

  // ── AppBar ────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(bool isMobile, bool isTablet) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 2)),
          boxShadow: [
            BoxShadow(
                color: AppColors.featherGreen.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (isMobile)
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const _HamburgerIcon(),
                  ),
                const SizedBox(width: 8),
                
                Image.asset(
                  'assets/logo.png',
                  width: 28,
                  height: 28,
                ),

                const SizedBox(width: 6),
                if (!isMobile)
                  const Text('Duolingo',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.featherGreen,
                          letterSpacing: -0.5)),
                const SizedBox(width: 12),
                // Search
                if (!isMobile)
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.bg,
                          border: Border.all(color: AppColors.border, width: 2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 12),
                            Icon(Icons.search, color: Color(0xFFAAAAAA), size: 18),
                            SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Cari kursus bahasa...',
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted,
                                      fontWeight: FontWeight.w600),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const Spacer(),
                // Stats chips
                Row(
                  children: [
                    StatChip(
                      emoji: '🔥',
                      value: '14',
                      label: isMobile ? null : 'Hari',
                      bg: const Color(0xFFFFF4E0),
                      border: AppColors.fox,
                      textColor: AppColors.fox,
                    ),
                    const SizedBox(width: 6),
                    StatChip(
                      emoji: '❤️',
                      value: '5',
                      label: isMobile ? null : 'Nyawa',
                      bg: const Color(0xFFFFE8E8),
                      border: AppColors.cardinal,
                      textColor: AppColors.cardinal,
                    ),
                    const SizedBox(width: 6),
                    StatChip(
                      emoji: '💎',
                      value: '320',
                      label: isMobile ? null : 'Permata',
                      bg: const Color(0xFFE8F4FF),
                      border: AppColors.macaw,
                      textColor: AppColors.macaw,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border, width: 2),
                          color: Colors.white),
                      child: const Center(
                          child: Text('🇬🇧', style: TextStyle(fontSize: 18))),
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

  // ── Left Sidebar (desktop/tablet) ─────────────────────────
  Widget _buildLeftSidebar({bool compact = false}) {
    return Container(
      width: compact ? 72 : 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.border, width: 2)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        children: [
          if (!compact)
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 4),
              child: Text('MENU UTAMA',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 1)),
            ),
          ..._navItems.asMap().entries.map((e) {
            final idx = e.key;
            final item = e.value;
            final active = _selectedIndex == idx;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = idx),
              child: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.symmetric(
                    horizontal: compact ? 8 : 16, vertical: 10),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFFF0FDE0)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: active
                      ? const Border(
                          left: BorderSide(
                              color: AppColors.featherGreen, width: 3))
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: compact
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Text(item.icon, style: const TextStyle(fontSize: 20)),
                    if (!compact) ...[
                      const SizedBox(width: 12),
                      Text(item.label,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: active
                                  ? AppColors.featherGreen
                                  : AppColors.eel)),
                    ]
                  ],
                ),
              ),
            );
          }),
          const Divider(color: AppColors.border, height: 24),
          if (!compact)
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 4),
              child: Text('LAINNYA',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 1)),
            ),
          _buildNavTile('❓', 'Bantuan', compact),
          _buildNavTile('⚙️', 'Pengaturan', compact),
        ],
      ),
    );
  }

  Widget _buildNavTile(String icon, String label, bool compact) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 16, vertical: 10),
      child: Row(
        mainAxisAlignment:
            compact ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          if (!compact) ...[
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.eel)),
          ],
        ],
      ),
    );
  }

  // ── Drawer (mobile) ───────────────────────────────────────
  Widget _buildDrawer() {
    return Drawer(
      child: _buildLeftSidebar(compact: false),
    );
  }

  // ── Active page body ──────────────────────────────────────
  Widget _buildActivePage() {
    switch (_selectedIndex) {
      case 2:
        return const LeaderboardScreen();
      case 3: 
        return const SettingsScreen();
      default:
        return _buildHomeContent();
    }
  }

  // ── Home content ──────────────────────────────────────────
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UnitBanner(),
          const SizedBox(height: 24),
          const XpProgressBar(),
          const SizedBox(height: 24),
          const SectionHeader(
              title: '🗺️ Jalur Belajar', linkText: 'Lihat semua →'),
          const SizedBox(height: 12),
          ...sampleUnits.map((u) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PathUnitCard(unit: u),
              )),
          const SizedBox(height: 8),
          const SectionHeader(
              title: '📊 Statistik Belajarmu', linkText: 'Detail →'),
          const SizedBox(height: 12),
          const StatsGrid(),
          const SizedBox(height: 12),
          const MiniBarChart(),
          const SizedBox(height: 24),
          const SectionHeader(
              title: '📢 Berita & Update', linkText: 'Semua →'),
          const SizedBox(height: 12),
          ...sampleNews.map((n) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: NewsCard(item: n),
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Layout variants ───────────────────────────────────────
  Widget _buildDesktopLayout() {
    final isHome = _selectedIndex == 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeftSidebar(compact: false),
        Expanded(child: _buildActivePage()),
        if (isHome)
          SizedBox(
            width: 280,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    left: BorderSide(color: AppColors.border, width: 2)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: const RightSidebarPanel(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeftSidebar(compact: true),
        Expanded(child: _buildActivePage()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return _buildActivePage();
  }

  // ── Bottom Nav (mobile) ───────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 2)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            children: _navItems.asMap().entries.map((e) {
              final idx = e.key;
              final item = e.value;
              final active = _selectedIndex == idx;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = idx),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.icon, style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 2),
                      Text(item.label,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: active
                                  ? AppColors.featherGreen
                                  : AppColors.textMuted)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class _HamburgerIcon extends StatelessWidget {
  const _HamburgerIcon();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.5),
          child: Container(
            width: 22,
            height: 2,
            // Hapus color dari sini, pindah ke dalam BoxDecoration ↓
            decoration: BoxDecoration(
              color: AppColors.eel,  // ← pindah ke sini ✅
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
