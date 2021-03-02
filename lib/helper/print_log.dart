class PrintLog {
  static bool _isAblePrint = true;

  static void printMessage(String message) {
    if (_isAblePrint) {
      print(message);
    }
  }
}

