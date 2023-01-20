extension DateExtension on DateTime? {
  String toShowFormat(String? fallBackText) {
    if (this == null) {
      return fallBackText ?? "";
    }
    var date = "${this!.year}/${this!.month}/${this!.day}";
    var time = "${this!.hour}:${this!.minute}";
    return "$date $time";
  }
}
extension DurationExtension on Duration? {
  String toShowFormat(String? fallBackText) {
    if (this == null) {
      return fallBackText ?? "";
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this!.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this!.inSeconds.remainder(60));
    return "${twoDigits(this!.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
