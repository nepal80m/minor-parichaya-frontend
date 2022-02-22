String getFormattedExpiry(DateTime expiryDate) {
  final expiryDate = DateTime(2022, 02, 22, 19);

  final now = DateTime.now();

  final days = expiryDate.difference(now).inDays;

  final hours = expiryDate.difference(now).inHours - days * 24;

  final minutes = expiryDate.difference(now).inMinutes - (hours * 60);

  String formattedExpiry = '';

  if (days > 0) {
    formattedExpiry = "$days day${days > 1 ? 's' : ''}";
  } else if (hours > 0) {
    formattedExpiry = '$hours hour${hours > 1 ? 's' : ''}';
  } else if (minutes > 0) {
    formattedExpiry = '$minutes minute${minutes > 1 ? 's' : ''}';
  }

  return formattedExpiry;
}
