class LessonNode {
  final String label;
  final LessonStatus status;
  final String icon;

  const LessonNode({
    required this.label,
    required this.status,
    required this.icon,
  });
}

enum LessonStatus { done, active, locked }

class PathUnit {
  final int number;
  final String name;
  final String desc;
  final int stars;
  final UnitStatus status;
  final List<LessonNode> lessons;

  const PathUnit({
    required this.number,
    required this.name,
    required this.desc,
    required this.stars,
    required this.status,
    this.lessons = const [],
  });
}

enum UnitStatus { completed, active, locked }

class MissionItem {
  final String icon;
  final String name;
  final String progress;
  final double percent;
  final String reward;

  const MissionItem({
    required this.icon,
    required this.name,
    required this.progress,
    required this.percent,
    required this.reward,
  });
}

class LeaderboardEntry {
  final int rank;
  final String initial;
  final String name;
  final int xp;
  final bool isMe;
  final int color;

  const LeaderboardEntry({
    required this.rank,
    required this.initial,
    required this.name,
    required this.xp,
    this.isMe = false,
    required this.color,
  });
}

class NewsItem {
  final String icon;
  final String iconBg;
  final String tag;
  final String title;
  final String desc;
  final String date;

  const NewsItem({
    required this.icon,
    required this.iconBg,
    required this.tag,
    required this.title,
    required this.desc,
    required this.date,
  });
}

class PromoItem {
  final String icon;
  final String title;
  final String desc;
  final String badge;

  const PromoItem({
    required this.icon,
    required this.title,
    required this.desc,
    required this.badge,
  });
}

class XpBarData {
  final int day;
  final double percent;
  final String label;
  final bool isToday;

  const XpBarData({
    required this.day,
    required this.percent,
    required this.label,
    this.isToday = false,
  });
}

// ── Static data ──────────────────────────────────────────────
final sampleUnits = [
  const PathUnit(
    number: 1,
    name: 'Salam & Perkenalan',
    desc: 'Dasar percakapan sehari-hari',
    stars: 3,
    status: UnitStatus.completed,
    lessons: [
      LessonNode(label: 'Halo', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Nama', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Asal', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Kuis', status: LessonStatus.done, icon: '🏅'),
    ],
  ),
  const PathUnit(
    number: 2,
    name: 'Percakapan Sehari-hari',
    desc: 'Sedang berjalan · 3/5 selesai',
    stars: 2,
    status: UnitStatus.active,
    lessons: [
      LessonNode(label: 'Cuaca', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Waktu', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Hobi', status: LessonStatus.done, icon: '✓'),
      LessonNode(label: 'Kerja', status: LessonStatus.active, icon: '▶'),
      LessonNode(label: 'Kuis', status: LessonStatus.locked, icon: '🔒'),
    ],
  ),
  const PathUnit(
    number: 3,
    name: 'Perjalanan & Transportasi',
    desc: 'Terkunci — selesaikan Unit 2 dulu',
    stars: 3,
    status: UnitStatus.locked,
  ),
];

final sampleMissions = [
  const MissionItem(
    icon: '⚡',
    name: 'Raih 20 XP',
    progress: '32 / 20 XP',
    percent: 1.0,
    reward: '✓',
  ),
  const MissionItem(
    icon: '🎤',
    name: '3 Latihan Bicara',
    progress: '2 / 3 sesi',
    percent: 0.66,
    reward: '+10',
  ),
  const MissionItem(
    icon: '❤️',
    name: 'Tanpa Kesalahan',
    progress: '0 / 1 sesi',
    percent: 0.0,
    reward: '+15',
  ),
];

final sampleLeaderboard = [
  const LeaderboardEntry(rank: 1, initial: 'A', name: 'Andi_R', xp: 580, color: 0xFFFFC800),
  const LeaderboardEntry(rank: 2, initial: 'S', name: 'Siti_L', xp: 470, color: 0xFFFF4B4B),
  const LeaderboardEntry(rank: 3, initial: 'B', name: 'Budi_W', xp: 390, color: 0xFFCE82FF),
  const LeaderboardEntry(rank: 4, initial: 'K', name: 'Kamu ⬅', xp: 320, isMe: true, color: 0xFF58CC02),
  const LeaderboardEntry(rank: 5, initial: 'D', name: 'Dani_P', xp: 290, color: 0xFF1CB0F6),
];

final sampleNews = [
  const NewsItem(
    icon: '🎉',
    iconBg: 'green',
    tag: 'Fitur Baru',
    title: 'Duolingo Stories kini tersedia dalam Bahasa Indonesia!',
    desc: 'Baca cerita pendek interaktif dan tingkatkan pemahamanmu secara kontekstual.',
    date: '5 Juni 2026',
  ),
  const NewsItem(
    icon: '⚡',
    iconBg: 'yellow',
    tag: 'Event Mingguan',
    title: 'XP Double Weekend — Raih 2x XP mulai Sabtu!',
    desc: 'Kesempatan terbatas. Mainkan lebih banyak sesi untuk naik peringkat liga.',
    date: '7 Juni 2026',
  ),
  const NewsItem(
    icon: '🔬',
    iconBg: 'blue',
    tag: 'Pembaruan',
    title: 'Algoritma adaptif baru — belajar lebih personal',
    desc: 'Sistem kini menyesuaikan latihan berdasarkan pola kesalahanmu secara real-time.',
    date: '1 Juni 2026',
  ),
];

final samplePromos = [
  const PromoItem(icon: '💎', title: 'Paket Permata 500', desc: 'Hemat untuk item premium', badge: '-20%'),
  const PromoItem(icon: '🛡️', title: 'Streak Shield', desc: 'Lindungi streak kamu', badge: 'Hot'),
];

final xpChartData = [
  const XpBarData(day: 0, percent: 0.40, label: 'Sen'),
  const XpBarData(day: 1, percent: 0.70, label: 'Sel'),
  const XpBarData(day: 2, percent: 0.55, label: 'Rab'),
  const XpBarData(day: 3, percent: 0.90, label: 'Kam'),
  const XpBarData(day: 4, percent: 0.45, label: 'Jum'),
  const XpBarData(day: 5, percent: 0.80, label: 'Sab'),
  const XpBarData(day: 6, percent: 0.64, label: 'Hari ini', isToday: true),
];
