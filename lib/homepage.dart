import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lab4/studentdetails.dart';
import 'package:url_launcher/url_launcher.dart';
import 'registrationform.dart';
import 'companydetails.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: const Color(0xFF01282B)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TPO Office',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF01282B),
                )),
            Text('Sardar Patel Institute of Technology',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                )),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/asset 0.png', height: 40),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF01282B), const Color(0xFF024955)],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/asset 0.png', height: 50),
                    SizedBox(height: 10),
                    Text(
                      'TPO Office',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Navigation',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text('Registration Form',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.business, color: Colors.white),
                title: Text('Company Details',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('Student Details',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentDetailPage()),
                  );
                },
              ),
              Divider(color: Colors.white30),
              ListTile(
                leading: Icon(Icons.contact_mail, color: Colors.white),
                title:
                    Text('Contact Us', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _showContactDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Improved Carousel with overlay text
            Container(
              height: 250,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                    ),
                    items: [
                      'assets/asset 2.jpeg',
                      'assets/asset 3.jpeg',
                      'assets/asset 7.png'
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(i, fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Training & Placement Office',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Connecting talented students with industry leaders',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Placement Highlights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF01282B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(Icons.trending_up,
                                    color: Colors.green, size: 32),
                                SizedBox(height: 8),
                                Text('98%',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text('Placement Rate',
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(Icons.business_center,
                                    color: Colors.blue, size: 32),
                                SizedBox(height: 8),
                                Text('120+',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text('Recruiters',
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(Icons.attach_money,
                                    color: Colors.amber, size: 32),
                                SizedBox(height: 8),
                                Text('32 LPA',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text('Highest CTC',
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // TPO Message Section with Card
                  SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/asset 6.png'),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Shri. Vinod Sikka',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF01282B),
                            ),
                          ),
                          Text(
                            'Head of Training & Placement Office',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Message from TPO',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF01282B),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'The Training and Placement Office at Sardar Patel Institute of Technology (S.P.I.T.) is committed to fostering student excellence and growth. Through expert-led workshops, structured curriculum, comprehensive labs, and innovative projects, students are equipped to excel in their fields. Participation in competitions and regular seminars further enhance their practical skills.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Placement Distribution - Bar Chart instead of Pie Chart
                  SizedBox(height: 24),
                  Text(
                    'Placement Distribution',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF01282B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: _buildBarChart(),
                          ),
                          SizedBox(height: 16),
                          Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildLegendItem(
                                  'Elite', const Color(0xFF1862A1)),
                              _buildLegendItem(
                                  'Super Dream', const Color(0xFF4E12CD)),
                              _buildLegendItem(
                                  'Dream', const Color(0xFF582EC1)),
                              _buildLegendItem(
                                  'Normal', const Color(0xFF746CCE)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Our Esteemed Recruiters with improved layout
                  SizedBox(height: 24),
                  Text(
                    'Our Esteemed Recruiters',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF01282B),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildCompanyLogo('assets/asset 32.jpeg'),
                          _buildCompanyLogo('assets/asset 34.jpeg'),
                          _buildCompanyLogo('assets/asset 39.jpeg'),
                          _buildCompanyLogo('assets/asset 35.jpeg'),
                          _buildCompanyLogo('assets/asset 36.jpeg'),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '100+\nMore',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Call to Action
                  SizedBox(height: 24),
                  Card(
                    elevation: 3,
                    color: const Color(0xFF01282B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Ready to Start Your Career Journey?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF01282B),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Footer
                  SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Sardar Patel Institute of Technology',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Training & Placement Office',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '© 2025 All Rights Reserved',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'CTC Range Distribution (2024-2025)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('50%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('40%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('30%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('20%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('10%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                    Text('0%',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                SizedBox(width: 10),
                // Bars
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar('Elite', const Color(0xFF1862A1), 28),
                      _buildBar('Super Dream', const Color(0xFF4E12CD), 48),
                      _buildBar('Dream', const Color(0xFF582EC1), 22),
                      _buildBar('Normal', const Color(0xFF746CCE), 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // X-axis labels are handled by the _buildBar method
        ],
      ),
    );
  }

  Widget _buildBar(String label, Color color, double percentage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('${percentage.toInt()}%',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Container(
          width: 40,
          height: percentage * 3, // Scale factor to fit in the chart
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Contact Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF01282B),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactSection(
                  'Address',
                  'Sardar Patel Institute of Technology\nBhavan\'s Campus, Munshi Nagar,\nAndheri (West), Mumbai - 400058,\nMaharashtra, India',
                  Icons.location_on,
                ),
                Divider(),
                _buildContactSection(
                  'Training & Placement Office',
                  'Mr. Vinod Sikka (Head, T&P)\nEmail: tpo@spit.ac.in\nPhone: +91-22-2623 7454',
                  Icons.business,
                ),
                Divider(),
                _buildContactSection(
                  'General Inquiry',
                  'Email: office@spit.ac.in\nPhone: +91-22-2623 7454\nFax: +91-22-2623 7452',
                  Icons.email,
                ),
                Divider(),
                _buildContactSection(
                  'Website & Social Media',
                  'Website: www.spit.ac.in\nLinkedIn: Sardar Patel Institute of Technology\nTwitter: @SPIT_Mumbai',
                  Icons.web,
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.map),
                    label: Text('View on Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01282B),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _launchMaps(
                          'Sardar Patel Institute of Technology, Mumbai');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: const Color(0xFF01282B)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactSection(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF01282B), size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF01282B),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _launchMaps(String query) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}');
    try {
      await launchUrl(url);
    } catch (e) {
      print('Could not launch maps: $e');
    }
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(title),
      ],
    );
  }

  Widget _buildCompanyLogo(String asset) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
