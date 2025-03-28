import 'package:flutter/material.dart';
import 'registrationform.dart';

class StudentDetailPage extends StatelessWidget {
  final String? name;
  final String? email;
  final String? contact;
  final String? rollNo;
  final double? hscPercentage;
  final double? sscPercentage;
  final double? cgpa;
  final String? additionalCourses;
  final String? resumeFileName;

  const StudentDetailPage({
    Key? key,
    this.name,
    this.email,
    this.contact,
    this.rollNo,
    this.hscPercentage,
    this.sscPercentage,
    this.cgpa,
    this.additionalCourses,
    this.resumeFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine if registration data exists
    final bool isRegistered = (name != null && name!.isNotEmpty);

    if (!isRegistered) {
      // Empty state UI with a more attractive design
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Student Details'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/asset 5.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 24),
              const Text(
                'No Profile Found',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please register to view your student profile',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Register Now',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Enhanced student profile UI
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            // Custom app bar with flexible space
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.indigo, Colors.indigoAccent],
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Navigate to edit profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Profile header with avatar
                  Transform.translate(
                    offset: const Offset(0, -60),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                const AssetImage('assets/asset 5.png'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          email ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Info cards
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contact info card
                        _buildInfoCard(
                          title: 'Contact Information',
                          icon: Icons.contact_page,
                          children: [
                            _buildInfoTile(
                              icon: Icons.phone,
                              title: 'Phone',
                              value: contact ?? 'Not provided',
                            ),
                            const Divider(height: 1),
                            _buildInfoTile(
                              icon: Icons.badge,
                              title: 'Roll Number',
                              value: rollNo ?? 'Not provided',
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Academic info card
                        _buildInfoCard(
                          title: 'Academic Information',
                          icon: Icons.school,
                          children: [
                            _buildInfoTile(
                              icon: Icons.grade,
                              title: 'CGPA',
                              value: cgpa?.toStringAsFixed(2) ?? 'Not provided',
                              valueColor: _getGradeColor(cgpa),
                            ),
                            const Divider(height: 1),
                            _buildInfoTile(
                              icon: Icons.history_edu,
                              title: 'HSC Percentage',
                              value: hscPercentage != null
                                  ? '${hscPercentage!.toStringAsFixed(2)}%'
                                  : 'Not provided',
                              valueColor: _getGradeColor(hscPercentage != null
                                  ? hscPercentage! / 100 * 10
                                  : null),
                            ),
                            const Divider(height: 1),
                            _buildInfoTile(
                              icon: Icons.school_outlined,
                              title: 'SSC Percentage',
                              value: sscPercentage != null
                                  ? '${sscPercentage!.toStringAsFixed(2)}%'
                                  : 'Not provided',
                              valueColor: _getGradeColor(sscPercentage != null
                                  ? sscPercentage! / 100 * 10
                                  : null),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Additional courses card
                        _buildInfoCard(
                          title: 'Additional Qualifications',
                          icon: Icons.workspace_premium,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Additional Courses',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      additionalCourses ?? 'None',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  // Helper method to build the info cards
  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  // Helper method to build info tiles
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.indigo, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to get color based on grade
  Color _getGradeColor(double? grade) {
    if (grade == null) return Colors.black87;
    if (grade >= 9.0) return Colors.green[700]!;
    if (grade >= 8.0) return Colors.green[600]!;
    if (grade >= 7.0) return Colors.blue[700]!;
    if (grade >= 6.0) return Colors.orange[700]!;
    return Colors.red[700]!;
  }
}
