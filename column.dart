import 'package:flutter/material.dart';
import 'home.dart';
import 'menu.dart';
import 'profile.dart';
import 'form_page.dart';
import 'login.dart';

class MainLayout extends StatefulWidget {
  final bool isAdmin;
  const MainLayout({super.key, required this.isAdmin});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        isAdmin: widget.isAdmin,
        onNavigateToOrder: () => _onItemTapped(3),
        onNavigateToMenu: () => _onItemTapped(1),
      ),
      const MenuPage(),
      ProfilePage(isAdmin: widget.isAdmin),
      FormPage(isAdmin: widget.isAdmin),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ponyonyo Cafe'),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFAF7F2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFB5C9B0), // Sage green
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Image.asset('assets/images/logo.png', width: 44),
                      ),
                      const SizedBox(width: 12),
                      if (widget.isAdmin)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7A9E78), // Admin badge green
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'ADMIN',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2A7BB), // Guest badge pink
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'GUEST',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ponyonyo Cafe 🌸',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'DM Serif Display'),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: Color(0xFF8A7070)),
              title: const Text('Home'),
              selected: _currentIndex == 0,
              selectedColor: const Color(0xFFE8899A),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu, color: Color(0xFF8A7070)),
              title: const Text('Menu'),
              selected: _currentIndex == 1,
              selectedColor: const Color(0xFFE8899A),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded, color: Color(0xFF8A7070)),
              title: const Text('Profile'),
              selected: _currentIndex == 2,
              selectedColor: const Color(0xFFE8899A),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_rounded, color: Color(0xFF8A7070)),
              title: const Text('Place Order'),
              selected: _currentIndex == 3,
              selectedColor: const Color(0xFFE8899A),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            const Divider(color: Color(0xFFB5C9B0)),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFE8899A)),
              title: const Text('Logout', style: TextStyle(color: Color(0xFFE8899A))),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFAF7F2),
        selectedItemColor: const Color(0xFFE8899A),
        unselectedItemColor: const Color(0xFF8A7070),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Order',
          ),
        ],
      ),
    );
  }
}
