class Validators {
  static String emailValidator(String emailAddress) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailAddress);

    if (emailAddress == "") {
      return "Email cannot be empty!";
    } else if (!emailValid) {
      return "Invalid Email address!";
    }
    return null;
  }

  static String passwordValidator(String password) {
    bool passValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
            .hasMatch(password);
    if (password.isEmpty) {
      return "Password cannot be empty!";
    } else if (!passValid) {
      return "Uppercase, lowercase, number and special character is required!";
    } else if (password.length < 6) {
      return "Password must be greater than 6 characters!";
    }
    return null;
  }

  static String phoneNumberValidator(String phoneNumber) {
    bool validPhone = RegExp(
            r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$')
        .hasMatch(phoneNumber);
    if (phoneNumber.isEmpty) {
      return "Phone number cannot be empty!";
    } else if (!validPhone) {
      return "Invalid Phone Number!";
    }

    return null;
  }
}
