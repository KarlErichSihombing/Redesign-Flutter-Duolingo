import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/lb_data.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool _showFriends = true; // false = world

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;
    final isDesktop = w >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 24).copyWith(
          bottom: isMobile ? 80 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroBanner(
            showFriends: _showFriends,
            onTabChanged: (v) => setState(() => _showFriends = v),
          ),
          const SizedBox(height: 20),
          _SeasonBar(),
          const SizedBox(height: 20),
          // Two-column or single-column
          isDesktop
              ? _buildDesktopGrid()
              : _buildMobileGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _LbColumn(players: friendsLeaderboard, isFriends: true, total: 12)),
            const SizedBox(width: 20),
            Expanded(child: _LbColumn(players: worldLeaderboard, isFriends: false, total: 30)),
          ],
        ),
        const SizedBox(height: 20),
        _AchieveStrip(),
      ],
    );
  }

  Widget _buildMobileGrid(bool isMobile) {
    return Column(
      children: [
        _LbColumn(
          players: _showFriends ? friendsLeaderboard : worldLeaderboard,
          isFriends: _showFriends,
          total: _showFriends ? 12 : 30,
        ),
        const SizedBox(height: 20),
        _AchieveStrip(),
      ],
    );
  }
}

// ── Hero Banner ───────────────────────────────────────────────
class _HeroBanner extends StatelessWidget {
  final bool showFriends;
  final ValueChanged<bool> onTabChanged;

  const _HeroBanner({required this.showFriends, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 24,
              offset: const Offset(0, 6))
        ],
      ),
      child: Stack(
        children: [
          // Decorative stars
          ...List.generate(20, (i) {
            final rng = Random(i * 13 + 7);
            return Positioned(
              left: rng.nextDouble() * 300,
              top: rng.nextDouble() * 100,
              child: Container(
                width: 2 + rng.nextDouble() * 2,
                height: 2 + rng.nextDouble() * 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4 + rng.nextDouble() * 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('⚡ MUSIM 12 · MINGGU KE-3',
                  style: TextStyle(
                      color: AppColors.featherGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2)),
              const SizedBox(height: 8),
              Text('Papan Peringkat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w900,
                      height: 1.1)),
              const SizedBox(height: 6),
              const Text('Bersaing dengan teman & seluruh dunia. Raih XP sebanyak-banyaknya!',
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              // Tabs
              Row(
                children: [
                  _HeroTab(
                    label: '👥 Teman',
                    active: showFriends,
                    onTap: () => onTabChanged(true),
                  ),
                  const SizedBox(width: 8),
                  _HeroTab(
                    label: '🌍 Dunia',
                    active: !showFriends,
                    onTap: () => onTabChanged(false),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _HeroTab({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.featherGreen : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: active ? AppColors.featherGreen : Colors.white24, width: 2),
          boxShadow: active
              ? [BoxShadow(color: AppColors.featherGreen.withOpacity(0.35), blurRadius: 12)]
              : [],
        ),
        child: Text(label,
            style: TextStyle(
                color: active ? Colors.white : Colors.white60,
                fontWeight: FontWeight.w800,
                fontSize: 13)),
      ),
    );
  }
}

// ── Season Bar ────────────────────────────────────────────────
class _SeasonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text('🗓️', style: TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MUSIM BERLANGSUNG',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textMuted,
                        letterSpacing: 1)),
                const SizedBox(height: 4),
                const Text('Musim Semi 2026 — Kumpulkan XP sebelum waktu habis!',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.68,
                    minHeight: 8,
                    backgroundColor: Color(0xFFEEEEEE),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.featherGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('4 Hari',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cardinal)),
              Text('Sisa waktu',
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Leaderboard Column (header + podium + list) ───────────────
class _LbColumn extends StatelessWidget {
  final List<LbPlayer> players;
  final bool isFriends;
  final int total;

  const _LbColumn({
    required this.players,
    required this.isFriends,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final top3 = players.take(3).toList();
    final rest = players.skip(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section header
        _SectionHeader(isFriends: isFriends, total: total),
        const SizedBox(height: 12),
        // Table
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Podium
              _Podium(top3: top3),
              // List
              ...rest.map((p) => _LbRow(player: p, maxXp: players[0].xp)),
              // Footer
              _TableFooter(total: total, isFriends: isFriends),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final bool isFriends;
  final int total;

  const _SectionHeader({required this.isFriends, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFriends
              ? [const Color(0xFF0f3460), const Color(0xFF1a4d8a)]
              : [const Color(0xFF3d0066), const Color(0xFF6a0dad)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: (isFriends ? AppColors.macaw : AppColors.beetle)
                  .withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Text(isFriends ? '👥' : '🌍',
              style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('LEADERBOARD',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white60,
                        letterSpacing: 1.5)),
                const SizedBox(height: 2),
                Text(isFriends ? 'Teman Kamu' : 'Seluruh Dunia',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
                Text(
                    isFriends
                        ? '$total teman · Kamu peringkat #4'
                        : 'Liga Perunggu · $total pemain',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text('$total',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withOpacity(0.2))),
        ],
      ),
    );
  }
}

// ── Podium top-3 ──────────────────────────────────────────────
class _Podium extends StatelessWidget {
  final List<LbPlayer> top3;

  const _Podium({required this.top3});

  @override
  Widget build(BuildContext context) {
    // Order: p2(rank2), p1(rank1), p3(rank3)
    final ordered = [top3[1], top3[0], top3[2]];
    final heights = [36.0, 50.0, 26.0]; // podium block heights
    final avSizes = [48.0, 60.0, 44.0];
    final medals = ['🥈', '🥇', '🥉'];
    final blockColors = [
      [const Color(0xFF8E9AAB), const Color(0xFF6B7789)],
      [const Color(0xFFFFC800), const Color(0xFFE6B400)],
      [const Color(0xFFFF9600), const Color(0xFFD47A00)],
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(3, (i) {
          final p = ordered[i];
          return Expanded(
            child: Column(
              children: [
                if (i == 1) // crown for #1
                  const Text('👑', style: TextStyle(fontSize: 18)),
                Container(
                  width: avSizes[i],
                  height: avSizes[i],
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(p.avatarColor),
                    border: Border.all(
                        color: Color(p.avatarColor).withOpacity(0.6), width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Center(
                    child: Text(p.initials,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: avSizes[i] * 0.28)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(p.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.w800)),
                Text('${p.xp} XP',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: heights[i],
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: blockColors[i],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                  ),
                  child: Center(
                    child: Text(medals[i], style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ── Single LB row ─────────────────────────────────────────────
class _LbRow extends StatelessWidget {
  final LbPlayer player;
  final int maxXp;

  const _LbRow({required this.player, required this.maxXp});

  @override
  Widget build(BuildContext context) {
    Color rankColor = AppColors.textMuted;
    if (player.rank == 1) rankColor = AppColors.bee;
    if (player.rank == 2) rankColor = const Color(0xFF8E9AAB);
    if (player.rank == 3) rankColor = AppColors.fox;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: player.isMe ? const Color(0xFFEDFCD4) : Colors.transparent,
        border: const Border(bottom: BorderSide(color: Color(0xFFF5F5F5))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text('${player.rank}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: rankColor)),
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: Color(player.avatarColor), shape: BoxShape.circle),
                child: Center(
                  child: Text(player.initials,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900)),
                ),
              ),
              if (player.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: AppColors.featherGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(player.name,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: player.isMe
                        ? AppColors.featherGreen
                        : AppColors.textPrimary)),
          ),
          Text(player.flag, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${player.xp} XP',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800)),
              Text('🔥 ${player.streak}',
                  style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.fox,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Table footer ──────────────────────────────────────────────
class _TableFooter extends StatelessWidget {
  final int total;
  final bool isFriends;

  const _TableFooter({required this.total, required this.isFriends});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 2)),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$total ${isFriends ? 'teman total' : 'pemain di liga ini'}',
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700)),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.featherGreen,
              foregroundColor: Colors.white,
              elevation: 3,
              shadowColor: const Color(0xFF45A800),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 12),
            ),
            child: Text(isFriends ? '+ Undang Teman' : 'Lihat Semua'),
          ),
        ],
      ),
    );
  }
}

// ── Achievement Strip ─────────────────────────────────────────
class _AchieveStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🏅 PENCAPAIAN LEADERBOARD KAMU',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMuted,
                  letterSpacing: 1)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: lbAchievements
                .map((a) => _AchieveBadge(badge: a))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AchieveBadge extends StatelessWidget {
  final AchievementBadge badge;

  const _AchieveBadge({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: badge.earned
                ? const Color(0xFFF0FDE0)
                : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: badge.earned ? AppColors.featherGreen : const Color(0xFFDDDDDD),
              width: 2,
            ),
          ),
          child: Center(
            child: ColorFiltered(
              colorFilter: badge.earned
                  ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                  : const ColorFilter.matrix([
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0,      0,      0,      0.5, 0,
                    ]),
              child: Text(badge.icon, style: const TextStyle(fontSize: 22)),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(badge.label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted)),
      ],
    );
  }
}
