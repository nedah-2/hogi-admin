bool isEmailValid(String email) {
  // Regular expression pattern for validating email addresses
  String pattern =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}\.[a-zA-Z]{2,4}$';

  // Create a RegExp object with the pattern
  RegExp regex = RegExp(pattern);

  // Use the RegExp object's hasMatch() method to check if the email matches the pattern
  return regex.hasMatch(email);
}
