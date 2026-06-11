// ── Leaderboard data models ───────────────────────────────────

class LbPlayer {
  final int rank;
  final String initials;
  final String name;
  final String flag;
  final int xp;
  final int streak;
  final bool isMe;
  final bool isOnline;
  final int avatarColor; // ARGB

  const LbPlayer({
    required this.rank,
    required this.initials,
    required this.name,
    required this.flag,
    required this.xp,
    required this.streak,
    this.isMe = false,
    this.isOnline = false,
    required this.avatarColor,
  });
}

class AchievementBadge {
  final String icon;
  final String label;
  final bool earned;

  const AchievementBadge({
    required this.icon,
    required this.label,
    required this.earned,
  });
}

// ── Friends leaderboard ───────────────────────────────────────
final friendsLeaderboard = [
  const LbPlayer(rank: 1, initials: 'RW', name: 'Rani_W',   flag: '🇮🇩', xp: 620,  streak: 21, isOnline: true,  avatarColor: 0xFFFFC800),
  const LbPlayer(rank: 2, initials: 'AR', name: 'Andi_R',   flag: '🇮🇩', xp: 580,  streak: 14, avatarColor: 0xFF8E9AAB),
  const LbPlayer(rank: 3, initials: 'SL', name: 'Siti_L',   flag: '🇮🇩', xp: 470,  streak: 9,  avatarColor: 0xFFFF9600),
  const LbPlayer(rank: 4, initials: 'KM', name: 'Kamu ⬅',  flag: '🇮🇩', xp: 320,  streak: 14, isMe: true, isOnline: true, avatarColor: 0xFF58CC02),
  const LbPlayer(rank: 5, initials: 'DP', name: 'Dani_P',   flag: '🇮🇩', xp: 290,  streak: 7,  avatarColor: 0xFF1CB0F6),
  const LbPlayer(rank: 6, initials: 'BW', name: 'Budi_W',   flag: '🇮🇩', xp: 260,  streak: 5,  avatarColor: 0xFFCE82FF),
  const LbPlayer(rank: 7, initials: 'FN', name: 'Fitri_N',  flag: '🇲🇾', xp: 210,  streak: 3,  avatarColor: 0xFFFF4B4B),
  const LbPlayer(rank: 8, initials: 'HS', name: 'Hendra_S', flag: '🇮🇩', xp: 180,  streak: 2,  avatarColor: 0xFF2B70C9),
];

// ── World leaderboard ─────────────────────────────────────────
final worldLeaderboard = [
  const LbPlayer(rank: 1,  initials: 'YK', name: 'Yuki_K',     flag: '🇯🇵', xp: 1420, streak: 45, isOnline: true,  avatarColor: 0xFFCE82FF),
  const LbPlayer(rank: 2,  initials: 'MC', name: 'MariaCosta',  flag: '🇧🇷', xp: 1180, streak: 32, avatarColor: 0xFF8E9AAB),
  const LbPlayer(rank: 3,  initials: 'JL', name: 'Jin_Lee',     flag: '🇰🇷', xp: 980,  streak: 28, avatarColor: 0xFFFF9600),
  const LbPlayer(rank: 4,  initials: 'AB', name: 'Ahmed_B',     flag: '🇸🇦', xp: 870,  streak: 19, avatarColor: 0xFFFF4B4B),
  const LbPlayer(rank: 5,  initials: 'PN', name: 'Pierre_N',    flag: '🇫🇷', xp: 760,  streak: 15, avatarColor: 0xFF1CB0F6),
  const LbPlayer(rank: 6,  initials: 'LM', name: 'Lila_M',      flag: '🇮🇳', xp: 650,  streak: 11, avatarColor: 0xFF58CC02),
  const LbPlayer(rank: 7,  initials: 'GV', name: 'Giulia_V',    flag: '🇮🇹', xp: 540,  streak: 8,  avatarColor: 0xFF2B70C9),
  const LbPlayer(rank: 8,  initials: 'KM', name: 'Kamu ⬅',     flag: '🇮🇩', xp: 320,  streak: 14, isMe: true, isOnline: true, avatarColor: 0xFF58CC02),
  const LbPlayer(rank: 9,  initials: 'TS', name: 'Tanaka_S',    flag: '🇯🇵', xp: 300,  streak: 6,  avatarColor: 0xFFFFC800),
  const LbPlayer(rank: 10, initials: 'EM', name: 'Emma_M',      flag: '🇩🇪', xp: 270,  streak: 4,  avatarColor: 0xFFCE82FF),
];

// ── Achievements ──────────────────────────────────────────────
final lbAchievements = [
  const AchievementBadge(icon: '🥇', label: 'Juara Liga',   earned: true),
  const AchievementBadge(icon: '🔥', label: 'Streak 14',    earned: true),
  const AchievementBadge(icon: '⚡', label: 'XP 1K+',       earned: true),
  const AchievementBadge(icon: '🏆', label: 'Top 3',        earned: false),
  const AchievementBadge(icon: '💫', label: 'Dunia Top 5',  earned: false),
  const AchievementBadge(icon: '🌟', label: 'Naik Liga',    earned: false),
  const AchievementBadge(icon: '👑', label: 'Raja Liga',    earned: false),
  const AchievementBadge(icon: '🦅', label: 'Streak 30',    earned: false),
];
