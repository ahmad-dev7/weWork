import 'dart:math';

String generateTeamCode() {
  const String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
  const String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String digits = '0123456789';
  const String specialChars = '!@#\$%^&*()=+[{]}|';

  final Random random = Random.secure();
  String password = '';

  // Add at least one character from each character set
  password += lowercaseChars[random.nextInt(lowercaseChars.length)];
  password += uppercaseChars[random.nextInt(uppercaseChars.length)];
  password += digits[random.nextInt(digits.length)];
  password += specialChars[random.nextInt(specialChars.length)];

  // Fill the rest of the password with random characters
  for (int i = password.length; i < 8; i++) {
    String characterSet = lowercaseChars +
        uppercaseChars +
        digits +
        specialChars; // Combine all character sets
    password += characterSet[random.nextInt(characterSet.length)];
  }

  // Shuffle the password to make it more random
  List<String> passwordList = password.split('');
  passwordList.shuffle();
  return passwordList.join();
}
