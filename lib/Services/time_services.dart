
class TimeService {
  // Logic: Posting opens Friday 12:00 PM and ends Sunday 11:59:59 PM
  static bool isPostingWindowOpen() {
    final now = DateTime.now();
    final weekday = now.weekday; // Mon=1, Fri=5, Sat=6, Sun=7
    final hour = now.hour;

    if (weekday == 5 && hour >= 12) return true; // Friday after 12 PM
    if (weekday == 6 || weekday == 7) return true; // Saturday & Sunday
    return false;
  }

  static Duration getTimeRemaining() {
    final now = DateTime.now();
    DateTime target;

    if (isPostingWindowOpen()) {
      // If open, calculate time until Sunday midnight
      target = DateTime(now.year, now.month, now.day).add(Duration(days: 7 - now.weekday + 1));
      target = target.subtract(const Duration(seconds: 1));
    } else {
      // If closed, calculate time until next Friday 12 PM
      int daysUntilFriday = (5 - now.weekday + 7) % 7;
      if (daysUntilFriday == 0 && now.hour >= 12) daysUntilFriday = 7;
      target = DateTime(now.year, now.month, now.day).add(Duration(days: daysUntilFriday));
      target = DateTime(target.year, target.month, target.day, 12, 0, 0);
    }
    return target.difference(now);
  }

  static String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    return "${days}d ${hours}h ${minutes}m";
  }
}