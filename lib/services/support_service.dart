import 'dart:math';

class SupportService {
  int generateTicketNumber() {
    int min = 10_000_000;
    int max = 80_000_000;
    int value = Random().nextInt(max) + min;

    return value;
  }
}
