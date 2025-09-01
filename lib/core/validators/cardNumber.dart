bool validateCardNumber(String input) {
  String number = input.replaceAll(RegExp(r'[^0-9]'), '');

  if (number.length < 13) return false;

  int sum = 0;
  bool alternate = false;

  for (int i = number.length - 1; i >= 0; i--) {
    int digit = int.parse(number[i]);

    if (alternate) {
      digit *= 2;
      if (digit > 9) digit -= 9;
    }

    sum += digit;
    alternate = !alternate;
  }

  return (sum % 10 == 0);
}
