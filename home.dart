import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final bool isAdmin;
  final VoidCallback onNavigateToOrder;
  final VoidCallback onNavigateToMenu;
  const HomePage({
    super.key,
    required this.isAdmin,
    required this.onNavigateToOrder,
    required this.onNavigateToMenu,
  });

  @override
  Widget build(BuildContext context) {
    final recentItems = [
      {'name': 'Strawberry Shortcake', 'price': 'RM 12.90', 'image': 'assets/images/strawberry_cake.png'},
      {'name': 'Earl Grey Scone', 'price': 'RM 8.50', 'image': 'assets/images/earl_grey_scone.png'},
      {'name': 'Belgian Waffle', 'price': 'RM 11.00', 'image': 'assets/images/belgian_waffle.png'},
      {'name': 'Café Latte', 'price': 'RM 9.00', 'image': 'assets/images/cafe_latte.png'},
      {'name': 'Matcha Frappe', 'price': 'RM 10.50', 'image': 'assets/images/matcha_frappe.png'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, welcome to Ponyonyo Cafe ☕',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Today is a great day for something sweet!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Card(
            color: const Color(0xFFF2A7BB),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's Special",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Strawberry\nShortcake',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'DM Serif Display'),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFFE8899A),
                          ),
                          onPressed: onNavigateToOrder,
                          child: const Text('Order Now'),
                        )
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/strawberry_cake.png',
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Recent Items',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentItems.length,
            itemBuilder: (context, index) {
              final item = recentItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item['image']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['price']!),
                  trailing: const Icon(Icons.chevron_right, color: Color(0xFFB5C9B0)),
                  onTap: onNavigateToMenu,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
