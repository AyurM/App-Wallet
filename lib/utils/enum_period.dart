enum Period {
  week,
  month,
  year;

  String get text => name[0].toUpperCase() + name.substring(1);
}
