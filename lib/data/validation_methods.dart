String? emailValidator(String? value) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (value == null || value.isEmpty) {
    return 'email field can\'t be empty';
  } else if (!regex.hasMatch(value)) {
    return 'please enter a valid email';
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }
  return null;
}
String? confirmPassValidator(String? value,String? originalPassword){
   
   if (value == null || value.isEmpty) {
        return 'confirm your password';
      } else if (value != originalPassword) {
          return 'password does not match';
            } else {
                      return null;
                    }
}
bool isValidPhoneNumber(String phoneNumber) {
  // Regular expression for validating phone numbers
  String pattern = r'^(?:[+0]9)?[0-9]{10,12}$'; 
  RegExp regExp = RegExp(pattern);

  if (phoneNumber.isEmpty) {
    return false; // The phone number is required
  } else if (!regExp.hasMatch(phoneNumber)) {
    return false; // The phone number format is incorrect
  }
  return true; // The phone number is valid
}