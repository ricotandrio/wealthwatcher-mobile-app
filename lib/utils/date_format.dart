class DateFormat {
  static final List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static String format(DateTime date) {
    return '${date.day}, ${monthNames[date.month - 1]} ${date.year}';
  }
}
