emailValidator(value) {
  if(value.isEmpty) {
    return 'Email is required';
  }
  if(!value.contains('@')) {
    return 'Invalid email';
  }
  return null;
}

passwordValidator(value) {
  if(value.isEmpty) {
    return 'Password is required';
  }
  if(value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

confirmPasswordValidator(value, password) {
  if(value.isEmpty) {
    return 'Confirm password is required';
  }
  if(value != password) {
    return 'Passwords do not match';
  }
  return null;
}

requiredFieldValidator(String fieldName) {
  return (value) {
    if(value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  };
}