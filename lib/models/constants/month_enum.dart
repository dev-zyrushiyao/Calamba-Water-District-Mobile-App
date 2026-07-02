enum Month {
  jan(1),
  feb(2),
  mar(3),
  apr(4),
  may(5),
  jun(6),
  jul(7),
  aug(8),
  sept(9),
  oct(10),
  nov(11),
  dec(12);

  final int numberValue;
  const Month(this.numberValue);

  String get capitalize => name[0].toUpperCase() + name.substring(1);
}
