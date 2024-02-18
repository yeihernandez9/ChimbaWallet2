class Validation {
  static String? validateMinLength(String value) {
    if (value.length < 5) {
      return 'El campo debe tener al menos 5 caracteres';
    }
    return null;
  }
}