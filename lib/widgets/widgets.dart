import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_data.dart';

// ── Stat Chip ─────────────────────────────────────────────────
class StatChip extends StatelessWidget {
  final String emoji;
  final String value;
  final String? label;
  final Color bg;
  final Color border;
  final Color textColor;

  const StatChip({
    super.key,
    required this.emoji,
    required this.value,
    this.label,
    required this.bg,
    required this.border,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(value,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w800, fontSize: 13)),
          if (label != null) ...[
            const SizedBox(width: 3),
            Text(label!,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String linkText;

  const SectionHeader({super.key, required this.title, required this.linkText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: 0.5)),
        Text(linkText,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.featherGreen)),
      ],
    );
  }
}

// ── Unit Banner ───────────────────────────────────────────────
class UnitBanner extends StatelessWidget {
  const UnitBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.featherGreen, AppColors.maskGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: AppColors.featherGreen.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Unit Aktif · Sesi 3 dari 5',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5)),
                const SizedBox(height: 6),
                const Text('Percakapan Sehari-hari',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                const Text('Bahasa Inggris · Tingkat Menengah',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Text('▶', style: TextStyle(fontSize: 12)),
                  label: const Text('LANJUTKAN',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          letterSpacing: 0.5)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.featherGreen,
                    elevation: 4,
                    shadowColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Text('🦉', style: TextStyle(fontSize: 52)),
        ],
      ),
    );
  }
}

// ── XP Progress Bar ───────────────────────────────────────────
class XpProgressBar extends StatelessWidget {
  const XpProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: '⚡ XP Hari Ini', linkText: 'Target: 50 XP'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Text('32 XP',
                  style: TextStyle(
                      color: AppColors.featherGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 10,
                    backgroundColor: const Color(0xFFE8E8E8),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.featherGreen),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('50 XP',
                  style: TextStyle(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Lesson Node ───────────────────────────────────────────────
class LessonNodeWidget extends StatelessWidget {
  final LessonNode node;

  const LessonNodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    Color circleColor;
    Color shadowColor;

    switch (node.status) {
      case LessonStatus.done:
        circleColor = AppColors.featherGreen;
        shadowColor = const Color(0xFF45A800);
        break;
      case LessonStatus.active:
        circleColor = AppColors.macaw;
        shadowColor = const Color(0xFF0E8FC9);
        break;
      case LessonStatus.locked:
        circleColor = const Color(0xFFE5E5E5);
        shadowColor = const Color(0xFFC0C0C0);
        break;
    }

    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: shadowColor, offset: const Offset(0, 4), blurRadius: 0)],
            border: Border.all(color: shadowColor, width: 2.5),
          ),
          child: Center(
            child: Text(node.icon,
                style: TextStyle(
                    fontSize: node.status == LessonStatus.done ? 18 : 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900)),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 60,
          child: Text(node.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted)),
        ),
      ],
    );
  }
}

// ── Path Unit Card ────────────────────────────────────────────
class PathUnitCard extends StatelessWidget {
  final PathUnit unit;

  const PathUnitCard({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color headerBg;
    Color numBg;
    double opacity;

    switch (unit.status) {
      case UnitStatus.completed:
        borderColor = AppColors.featherGreen;
        headerBg = const Color(0xFFF0FDE0);
        numBg = AppColors.featherGreen;
        opacity = 1.0;
        break;
      case UnitStatus.active:
        borderColor = AppColors.macaw;
        headerBg = const Color(0xFFE8F4FF);
        numBg = AppColors.macaw;
        opacity = 1.0;
        break;
      case UnitStatus.locked:
        borderColor = const Color(0xFFCCCCCC);
        headerBg = const Color(0xFFF9F9F9);
        numBg = const Color(0xFFCCCCCC);
        opacity = 0.7;
        break;
    }

    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: headerBg,
              borderRadius: BorderRadius.circular(10),
              border: Border(left: BorderSide(color: borderColor, width: 4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: numBg, shape: BoxShape.circle),
                  child: Center(
                    child: Text('${unit.number}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(unit.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 14)),
                      Text(unit.desc,
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Text(
                  '⭐' * unit.stars,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          if (unit.lessons.isNotEmpty) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: unit.lessons
                    .map((l) => LessonNodeWidget(node: l))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Stats Grid ─────────────────────────────────────────────────
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('1,240', 'Total XP', AppColors.featherGreen),
      ('14', 'Streak Hari', AppColors.macaw),
      ('87%', 'Akurasi Rata-rata', AppColors.fox),
      ('23', 'Sesi Selesai', AppColors.beetle),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.8,
      children: stats
          .map((s) => _StatCard(value: s.$1, label: s.$2, color: s.$3))
          .toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatCard({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.w900)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ── Mini Bar Chart ────────────────────────────────────────────
class MiniBarChart extends StatelessWidget {
  const MiniBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('XP 7 Hari Terakhir',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMuted)),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: xpChartData.map((d) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FractionallySizedBox(
                            heightFactor: d.percent,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: d.isToday
                                    ? AppColors.macaw
                                    : AppColors.featherGreen,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(4)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(d.label,
                          style: const TextStyle(
                              fontSize: 8,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── News Card ─────────────────────────────────────────────────
class NewsCard extends StatelessWidget {
  final NewsItem item;

  const NewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color iconBg;
    switch (item.iconBg) {
      case 'yellow':
        iconBg = const Color(0xFFFFF9E0);
        break;
      case 'blue':
        iconBg = const Color(0xFFE8F4FF);
        break;
      default:
        iconBg = const Color(0xFFF0FDE0);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(item.icon, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.tag,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.featherGreen,
                        letterSpacing: 1)),
                const SizedBox(height: 3),
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(item.desc,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                        height: 1.4)),
                const SizedBox(height: 5),
                Text(item.date,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFAAAAAA),
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mission Item ──────────────────────────────────────────────
class MissionTile extends StatelessWidget {
  final MissionItem mission;

  const MissionTile({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    Color fillColor;
    if (mission.percent >= 1.0) {
      fillColor = AppColors.featherGreen;
    } else if (mission.icon == '🎤') {
      fillColor = AppColors.macaw;
    } else {
      fillColor = AppColors.cardinal;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(mission.icon, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mission.name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700)),
                Text(mission.progress,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: mission.percent,
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE8E8E8),
                    valueColor: AlwaysStoppedAnimation<Color>(fillColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(mission.reward,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.bee)),
          ),
        ],
      ),
    );
  }
}

// ── Leaderboard Row ───────────────────────────────────────────
class LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: entry.isMe ? const Color(0xFFF0FDE0) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text('${entry.rank}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                color: Color(entry.color), shape: BoxShape.circle),
            child: Center(
              child: Text(entry.initial,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(entry.name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: entry.isMe ? AppColors.featherGreen : AppColors.textPrimary)),
          ),
          Text('${entry.xp} XP',
              style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Widget Card wrapper ───────────────────────────────────────
class WidgetCard extends StatelessWidget {
  final String title;
  final Color headerColor;
  final Widget body;

  const WidgetCard({
    super.key,
    required this.title,
    required this.headerColor,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8)),
          ),
          Padding(padding: const EdgeInsets.all(14), child: body),
        ],
      ),
    );
  }
}

// ── Promo Card ────────────────────────────────────────────────
class PromoCardWidget extends StatelessWidget {
  final PromoItem item;

  const PromoCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x22CE82FF), Color(0x222B70C9)],
        ),
        border: Border.all(color: const Color(0x44CE82FF)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(item.icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w800)),
                Text(item.desc,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.cardinal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(item.badge,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

// ── Right Sidebar Panel ────────────────────────────────────────
class RightSidebarPanel extends StatelessWidget {
  const RightSidebarPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Daily Mission
        WidgetCard(
          title: '🎯 Misi Harian',
          headerColor: AppColors.featherGreen,
          body: Column(
            children: sampleMissions
                .map((m) => MissionTile(mission: m))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        // League
        WidgetCard(
          title: '🏆 Liga Perunggu',
          headerColor: AppColors.macaw,
          body: Column(
            children: [
              Column(
                children: [
                  const Text('🥉', style: TextStyle(fontSize: 36)),
                  const SizedBox(height: 4),
                  const Text('Liga Perunggu',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14)),
                  const Text('Peringkat #4 dari 30',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              ...sampleLeaderboard
                  .map((e) => LeaderboardRow(entry: e)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Store promo
        WidgetCard(
          title: '🛒 Promo Toko',
          headerColor: AppColors.bee,
          body: Column(
            children: samplePromos
                .map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: PromoCardWidget(item: p),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
