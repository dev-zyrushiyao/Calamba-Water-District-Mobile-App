enum Month {
  jan,
  feb,
  mar,
  apr,
  may,
  jun,
  jul,
  aug,
  sept,
  oct,
  nov,
  dec;

  String get capitalize => name[0].toUpperCase() + name.substring(1);
}
