class Utils {
  static Utils? _instance;

  Utils._();
  static Utils get instance => _instance ??= Utils._();

  static String formatDuration(String duration) {
    int minutes = int.parse(duration);
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }
}
