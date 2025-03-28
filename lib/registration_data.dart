// registration_data.dart
class RegistrationData {
  final String name;
  final String email;
  final String contact;
  final String rollNo;
  final double hscPercentage;
  final double sscPercentage;
  final double cgpa;
  final String additionalCourses;

  RegistrationData({
    required this.name,
    required this.email,
    required this.contact,
    required this.rollNo,
    required this.hscPercentage,
    required this.sscPercentage,
    required this.cgpa,
    required this.additionalCourses,
  });
}

// Global variable to store registration data.
RegistrationData? registrationData;
