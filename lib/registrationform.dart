import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lab4/studentdetails.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();

  // HSC
  final TextEditingController _hscCollegeController = TextEditingController();
  final TextEditingController _hscYearController = TextEditingController();
  final TextEditingController _hscTotalController = TextEditingController();
  final TextEditingController _hscOutOfController = TextEditingController();
  double hscPercentage = 0.0;

  // SSC
  final TextEditingController _sscCollegeController = TextEditingController();
  final TextEditingController _sscYearController = TextEditingController();
  final TextEditingController _sscTotalController = TextEditingController();
  final TextEditingController _sscOutOfController = TextEditingController();
  double sscPercentage = 0.0;

  // Sem 1-5
  final TextEditingController _cgpaController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();

  // Additional
  final TextEditingController _additionalCoursesController =
      TextEditingController();

  // Resume
  String? resumeFileName;
  bool isLoading = false;

  // Current form step
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();

  // Calculate HSC Percentage
  void calculateHSCPercentage() {
    final total = double.tryParse(_hscTotalController.text) ?? 0;
    final outOf = double.tryParse(_hscOutOfController.text) ?? 0;
    if (outOf > 0) {
      setState(() {
        hscPercentage = (total / outOf) * 100;
      });
    }
  }

  // Calculate SSC Percentage
  void calculateSSCPercentage() {
    final total = double.tryParse(_sscTotalController.text) ?? 0;
    final outOf = double.tryParse(_sscOutOfController.text) ?? 0;
    if (outOf > 0) {
      setState(() {
        sscPercentage = (total / outOf) * 100;
      });
    }
  }

  // Pick Resume File
  Future<void> pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        resumeFileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF01282B),
                  const Color(0xFF024E54),
                ],
              ),
            ),
          ),

          // App Bar with back button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Student Registration',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Column(
                children: [
                  // Progress indicator and step labels
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        _buildStepIndicator(0, "Personal"),
                        _buildStepConnector(_currentStep >= 1),
                        _buildStepIndicator(1, "Education"),
                        _buildStepConnector(_currentStep >= 2),
                        _buildStepIndicator(2, "Resume"),
                      ],
                    ),
                  ),

                  // Form content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: _buildCurrentStep(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Build step indicator (circle with number)
  Widget _buildStepIndicator(int step, String label) {
    bool isActive = _currentStep >= step;
    bool isCurrent = _currentStep == step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF01282B) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrent ? Colors.white : const Color(0xFF01282B),
                width: 2,
              ),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                (step + 1).toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF01282B),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Build connector line between steps
  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 30,
      height: 2,
      color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
    );
  }

  // Build the current step content
  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildEducationStep();
      case 2:
        return _buildResumeStep();
      default:
        return Container();
    }
  }

  // Step 1: Personal Information
  Widget _buildPersonalInfoStep() {
    return Column(
      key: ValueKey('personal'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Information'),
        SizedBox(height: 24),
        _buildInputLabel('Full Name'),
        _buildTextField(
          controller: _nameController,
          hintText: 'Enter your full name',
          icon: Icons.person_outline,
          validator: (value) => value!.isEmpty ? 'Name is required' : null,
        ),
        SizedBox(height: 20),
        _buildInputLabel('Email Address'),
        _buildTextField(
          controller: _emailController,
          hintText: 'Enter your email address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        _buildInputLabel('Contact Number'),
        _buildTextField(
          controller: _contactController,
          hintText: 'Enter your contact number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              value!.isEmpty ? 'Contact number is required' : null,
        ),
        SizedBox(height: 20),
        _buildInputLabel('Roll Number'),
        _buildTextField(
          controller: _rollNoController,
          hintText: 'Enter your roll number',
          icon: Icons.numbers_outlined,
          validator: (value) =>
              value!.isEmpty ? 'Roll number is required' : null,
        ),
        SizedBox(height: 40),
        _buildNavigationButtons(
          onNext: () {
            if (_validatePersonalInfo()) {
              setState(() {
                _currentStep = 1;
              });
            }
          },
        ),
      ],
    );
  }

  // Step 2: Education Information
  Widget _buildEducationStep() {
    return Column(
      key: ValueKey('education'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education Details'),
        SizedBox(height: 24),

        // HSC Details
        _buildSubsectionTitle('HSC Details'),
        SizedBox(height: 16),

        _buildInputLabel('College/Institution'),
        _buildTextField(
          controller: _hscCollegeController,
          hintText: 'Enter your HSC college',
          icon: Icons.school_outlined,
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Year of Passing'),
                  _buildTextField(
                    controller: _hscYearController,
                    hintText: 'YYYY',
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Total Marks'),
                  _buildTextField(
                    controller: _hscTotalController,
                    hintText: 'Total',
                    icon: Icons.score_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculateHSCPercentage(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Out of'),
                  _buildTextField(
                    controller: _hscOutOfController,
                    hintText: 'Max marks',
                    icon: Icons.pending_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculateHSCPercentage(),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 8),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF01282B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.percent, color: const Color(0xFF01282B)),
              SizedBox(width: 10),
              Text(
                'HSC Percentage: ${hscPercentage.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF01282B),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // SSC Details
        _buildSubsectionTitle('SSC Details'),
        SizedBox(height: 16),

        _buildInputLabel('College/Institution'),
        _buildTextField(
          controller: _sscCollegeController,
          hintText: 'Enter your SSC college',
          icon: Icons.school_outlined,
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Year of Passing'),
                  _buildTextField(
                    controller: _sscYearController,
                    hintText: 'YYYY',
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Total Marks'),
                  _buildTextField(
                    controller: _sscTotalController,
                    hintText: 'Total',
                    icon: Icons.score_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculateSSCPercentage(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Out of'),
                  _buildTextField(
                    controller: _sscOutOfController,
                    hintText: 'Max marks',
                    icon: Icons.pending_outlined,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => calculateSSCPercentage(),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 8),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF01282B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.percent, color: const Color(0xFF01282B)),
              SizedBox(width: 10),
              Text(
                'SSC Percentage: ${sscPercentage.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF01282B),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // Semester Details
        _buildSubsectionTitle('Semester 1-5 Details'),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('CGPA'),
                  _buildTextField(
                    controller: _cgpaController,
                    hintText: 'Current CGPA',
                    icon: Icons.grade_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel('Percentage'),
                  _buildTextField(
                    controller: _percentageController,
                    hintText: 'Equivalent %',
                    icon: Icons.percent,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40),

        _buildNavigationButtons(
          onPrevious: () {
            setState(() {
              _currentStep = 0;
            });
          },
          onNext: () {
            if (_validateEducationInfo()) {
              setState(() {
                _currentStep = 2;
              });
            }
          },
        ),
      ],
    );
  }

  // Step 3: Resume & Additional Information
  Widget _buildResumeStep() {
    return Column(
      key: ValueKey('resume'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Final Details'),
        SizedBox(height: 24),
        _buildSubsectionTitle('Additional Courses/Skills'),
        SizedBox(height: 16),
        _buildTextField(
          controller: _additionalCoursesController,
          hintText: 'Enter any additional courses, certifications or skills',
          icon: Icons.library_books_outlined,
          maxLines: 4,
        ),
        SizedBox(height: 24),
        _buildSubsectionTitle('Resume Upload'),
        SizedBox(height: 16),
        GestureDetector(
          onTap: pickResume,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48,
                  color: const Color(0xFF01282B),
                ),
                SizedBox(height: 16),
                Text(
                  resumeFileName != null
                      ? 'Change Resume'
                      : 'Upload Your Resume',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF01282B),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'PDF, DOC or DOCX (Max. 5MB)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                if (resumeFileName != null) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF01282B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 20,
                          color: const Color(0xFF01282B),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            resumeFileName!,
                            style: TextStyle(
                              color: const Color(0xFF01282B),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 40),
        _buildNavigationButtons(
          onPrevious: () {
            setState(() {
              _currentStep = 1;
            });
          },
          onSubmit: () {
            _submitForm();
          },
        ),
      ],
    );
  }

  // Form validation and submission methods
  bool _validatePersonalInfo() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _contactController.text.isEmpty ||
        _rollNoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return false;
    }
    return true;
  }

  bool _validateEducationInfo() {
    // Simplified validation - you can add more specific validation as needed
    if (_hscCollegeController.text.isEmpty ||
        _hscYearController.text.isEmpty ||
        _hscTotalController.text.isEmpty ||
        _hscOutOfController.text.isEmpty ||
        _sscCollegeController.text.isEmpty ||
        _sscYearController.text.isEmpty ||
        _sscTotalController.text.isEmpty ||
        _sscOutOfController.text.isEmpty ||
        _cgpaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required education fields')),
      );
      return false;
    }
    return true;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Simulate API call or processing
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });

        // Gather data from all controllers
        final String name = _nameController.text.trim();
        final String email = _emailController.text.trim();
        final String contact = _contactController.text.trim();
        final String rollNo = _rollNoController.text.trim();
        final double hsc = hscPercentage;
        final double ssc = sscPercentage;
        final double cgpa = double.tryParse(_cgpaController.text) ?? 0.0;
        final String additionalCourses =
            _additionalCoursesController.text.trim();

        // Navigate to the StudentDetailPage with the collected data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailPage(
              name: name,
              email: email,
              contact: contact,
              rollNo: rollNo,
              hscPercentage: hsc,
              sscPercentage: ssc,
              cgpa: cgpa,
              additionalCourses: additionalCourses,
            ),
          ),
        );
      });
    }
  }

  // UI helper methods
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF01282B),
      ),
    );
  }

  Widget _buildSubsectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF01282B),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: const Color(0xFF01282B)),
        contentPadding: EdgeInsets.symmetric(
          vertical: maxLines > 1 ? 16 : 0,
          horizontal: maxLines > 1 ? 16 : 0,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: const Color(0xFF01282B), width: 2),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons({
    Function()? onPrevious,
    Function()? onNext,
    Function()? onSubmit,
  }) {
    return Row(
      children: [
        if (onPrevious != null)
          Expanded(
            child: ElevatedButton(
              onPressed: onPrevious,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF01282B),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: const Color(0xFF01282B)),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text('Previous'),
                ],
              ),
            ),
          ),
        if (onPrevious != null && (onNext != null || onSubmit != null))
          SizedBox(width: 16),
        if (onNext != null)
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF01282B),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        if (onSubmit != null)
          Expanded(
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF01282B),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Submit'),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle_outline),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
