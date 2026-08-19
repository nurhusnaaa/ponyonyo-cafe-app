import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Cakes', 'Scones', 'Waffles', 'Hot Drinks', 'Cold Drinks'];

  final List<Map<String, String>> _menuItems = [
    {'name': 'Strawberry Shortcake', 'category': 'Cakes', 'price': 'RM 12.90', 'image': 'assets/images/strawberry_cake.png', 'desc': 'Light sponge cake with fresh strawberries and cream.'},
    {'name': 'Chocolate Lava Cake', 'category': 'Cakes', 'price': 'RM 13.50', 'image': 'assets/images/choco_lava_cake.png', 'desc': 'Warm chocolate cake with a gooey molten center.'},
    {'name': 'Earl Grey Scone', 'category': 'Scones', 'price': 'RM 8.50', 'image': 'assets/images/earl_grey_scone.png', 'desc': 'Buttery scone infused with fragrant Earl Grey tea.'},
    {'name': 'Cranberry Scone', 'category': 'Scones', 'price': 'RM 8.00', 'image': 'assets/images/cranberry_scone.png', 'desc': 'Classic baked scone dotted with sweet cranberries.'},
    {'name': 'Belgian Waffle', 'category': 'Waffles', 'price': 'RM 11.00', 'image': 'assets/images/belgian_waffle.png', 'desc': 'Crispy golden waffle served with maple syrup.'},
    {'name': 'Waffle with Ice Cream', 'category': 'Waffles', 'price': 'RM 13.00', 'image': 'assets/images/waffle_ice_cream.png', 'desc': 'Warm belgian waffle topped with vanilla bean ice cream.'},
    {'name': 'Café Latte', 'category': 'Hot Drinks', 'price': 'RM 9.00', 'image': 'assets/images/cafe_latte.png', 'desc': 'Smooth espresso blended with steamed milk.'},
    {'name': 'Chamomile Tea', 'category': 'Hot Drinks', 'price': 'RM 7.50', 'image': 'assets/images/chamomile_tea.png', 'desc': 'Soothing herbal tea with calming floral notes.'},
    {'name': 'Matcha Frappe', 'category': 'Cold Drinks', 'price': 'RM 10.50', 'image': 'assets/images/matcha_frappe.png', 'desc': 'Iced blended premium matcha topped with whipped cream.'},
    {'name': 'Iced Caramel Macchiato', 'category': 'Cold Drinks', 'price': 'RM 11.00', 'image': 'assets/images/iced_caramel_macchiato.png', 'desc': 'Iced espresso with vanilla syrup and caramel drizzle.'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedCategory == 'All'
        ? _menuItems
        : _menuItems.where((item) => item['category'] == _selectedCategory).toList();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: const Color(0xFFB5C9B0), // Sage green
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF3B2A2A),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        item['image']!,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']!,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['category']!,
                                  style: const TextStyle(color: Color(0xFF8A7070), fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['desc']!,
                                  style: const TextStyle(color: Color(0xFF8A7070), fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item['price']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFE8899A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
