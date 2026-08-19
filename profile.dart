import 'package:flutter/material.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  final bool isAdmin;
  const ProfilePage({super.key, required this.isAdmin});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top Section - Greeting
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: isAdmin ? const Color(0xFF7A9E78) : const Color(0xFFF2A7BB),
                    child: Icon(
                      isAdmin ? Icons.admin_panel_settings : Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isAdmin ? 'Hello, Admin! 👋' : 'Hello, Guest! 👋',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isAdmin ? const Color(0xFF7A9E78) : const Color(0xFFF2A7BB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isAdmin ? 'ADMIN' : 'GUEST',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Middle Section - Guest Info (Hidden for admin)
          if (!isAdmin) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Info', style: Theme.of(context).textTheme.titleLarge),
                    const Divider(height: 24),
                    _buildInfoRow(Icons.person, 'Full Name', 'Customer'),
                    _buildInfoRow(Icons.email, 'Email', 'guest@ponyonyo.com'),
                    _buildInfoRow(Icons.phone, 'Phone', '+60 11-2345 6789'),
                    _buildInfoRow(Icons.wc, 'Gender', 'Female'),
                    _buildInfoRow(Icons.calendar_today, 'Member Since', 'January 2025'),
                    _buildInfoRow(Icons.favorite, 'Favourite Item', 'Matcha Frappe 🧋'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Bottom Section - Cafe Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF2A7BB).withOpacity(0.2),
                        child: Image.asset('assets/images/logo.png', width: 36),
                      ),
                      const SizedBox(width: 12),
                      Text('About Ponyonyo Cafe', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text(
                    'Sweet moments, every sip 🌸',
                    style: TextStyle(fontStyle: FontStyle.italic, color: Color(0xFF8A7070)),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.email, 'Email', 'ponyonyocafe@gmail.com'),
                  _buildInfoRow(Icons.phone, 'Phone', '+60 12-345 6789'),
                  _buildInfoRow(Icons.location_on, 'Location', 'Kuala Lumpur, Malaysia'),
                  _buildInfoRow(Icons.access_time, 'Opening Hours', 'Mon–Sun, 9:00 AM – 9:00 PM'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () => _logout(context),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB5C9B0), size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF8A7070))),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF3B2A2A))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
