enum Gender {
  male('Male'),
  female('Female'),
  lgbt('LGBT');

  final String value;

  const Gender(this.value);

  String getProfileDirectory() {
    switch (this) {
      case Gender.male:
        return 'assets/avatar/male.png';
      case Gender.female:
        return 'assets/avatar/female.png';
      case Gender.lgbt:
        return 'assets/avatar/unicorn.png';
    }
  }
}
