class TimeUtils {

  String formatTime(DateTime time) {
    // Use the provided timestamp as the reference "now" time
    final now = DateTime.parse("2024-09-04T13:51:52.172Z");
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${time.day} ${getMonthAbbreviation(time.month)}';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours.toString().padLeft(2, '0')}:${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes.toString().padLeft(2, '0')}:${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    } else {
      return 'Just now';
    }
  }

  String getMonthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

}