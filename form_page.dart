import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  final bool isAdmin;
  const FormPage({super.key, required this.isAdmin});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  List<String> _selectedItems = [];

  final List<String> _menuItems = [
    'Strawberry Shortcake',
    'Chocolate Lava Cake',
    'Earl Grey Scone',
    'Cranberry Scone',
    'Belgian Waffle',
    'Waffle with Ice Cream',
    'Café Latte',
    'Chamomile Tea',
    'Matcha Frappe',
    'Iced Caramel Macchiato'
  ];

  final CollectionReference _ordersCollection = FirebaseFirestore.instance.collection('orders');

  void _addOrder() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _ordersCollection.add({
          'name': _nameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'item': _selectedItems.join(', '),
          'notes': _notesController.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (!mounted) return;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Order Placed! 🎀', style: TextStyle(fontFamily: 'DM Serif Display')),
            content: const Text("We'll prepare it with love."),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _nameController.clear();
                  _phoneController.clear();
                  _notesController.clear();
                  setState(() {
                    _selectedItems = [];
                  });
                  _formKey.currentState?.reset();
                },
                child: const Text('OK', style: TextStyle(color: Color(0xFFE8899A))),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to place order: $e')));
      }
    }
  }

  void _deleteOrder(String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Order'),
        content: const Text('Are you sure you want to delete this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              _ordersCollection.doc(docId).delete();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editOrder(DocumentSnapshot doc) {
    final editNameCtrl = TextEditingController(text: doc['name']);
    final editPhoneCtrl = TextEditingController(text: doc['phone']);
    List<String> editSelectedItems = (doc['item'] as String? ?? '').split(', ').where((e) => e.isNotEmpty).toList();
    final editNotesCtrl = TextEditingController(text: doc['notes']);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Edit Order', style: TextStyle(fontFamily: 'DM Serif Display')),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editNameCtrl,
                    decoration: const InputDecoration(labelText: 'Customer Name'),
                  ),
                  TextField(
                    controller: editPhoneCtrl,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Items Ordered', style: TextStyle(color: Color(0xFF8A7070), fontSize: 12)),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _menuItems.map((item) {
                      final isSelected = editSelectedItems.contains(item);
                      return FilterChip(
                        label: Text(item, style: const TextStyle(fontSize: 12)),
                        selected: isSelected,
                        selectedColor: const Color(0xFFF2A7BB),
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                          setStateDialog(() {
                            if (selected) {
                              editSelectedItems.add(item);
                            } else {
                              editSelectedItems.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: editNotesCtrl,
                    decoration: const InputDecoration(labelText: 'Special Notes'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () {
                  _ordersCollection.doc(doc.id).update({
                    'name': editNameCtrl.text.trim(),
                    'phone': editPhoneCtrl.text.trim(),
                    'item': editSelectedItems.join(', '),
                    'notes': editNotesCtrl.text.trim(),
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save', style: TextStyle(color: Color(0xFFE8899A))),
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!widget.isAdmin) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Place an Order', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Customer Name',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE8899A))),
                        ),
                        validator: (v) => v!.isEmpty ? 'Please enter name' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE8899A))),
                        ),
                        validator: (v) => v!.isEmpty ? 'Please enter phone' : null,
                      ),
                      const SizedBox(height: 16),
                      FormField<List<String>>(
                        initialValue: _selectedItems,
                        validator: (v) => v == null || v.isEmpty ? 'Please select at least one item' : null,
                        builder: (FormFieldState<List<String>> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Items Ordered', style: TextStyle(color: Color(0xFF8A7070), fontSize: 12)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: _menuItems.map((item) {
                                  final isSelected = state.value!.contains(item);
                                  return FilterChip(
                                    label: Text(item),
                                    selected: isSelected,
                                    selectedColor: const Color(0xFFF2A7BB),
                                    checkmarkColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: isSelected ? Colors.white : const Color(0xFF3B2A2A),
                                    ),
                                    onSelected: (bool selected) {
                                      final newValue = List<String>.from(state.value!);
                                      if (selected) {
                                        newValue.add(item);
                                      } else {
                                        newValue.remove(item);
                                      }
                                      state.didChange(newValue);
                                      _selectedItems = newValue;
                                    },
                                  );
                                }).toList(),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(state.errorText!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Special Notes / Request',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFE8899A))),
                        ),
                        validator: (v) => v!.isEmpty ? 'Please enter notes (or type None)' : null,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addOrder,
                          child: const Text('Submit Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
          Text('All Orders', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          StreamBuilder<QuerySnapshot>(
            stream: _ordersCollection.orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFE8899A)));
              }
              final docs = snapshot.data?.docs ?? [];
              if (docs.isEmpty) {
                return const Text('No orders yet.');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data() as Map<String, dynamic>;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              if (widget.isAdmin)
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                      onPressed: () => _editOrder(doc),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                      onPressed: () => _deleteOrder(doc.id),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const Divider(),
                          Text('Item: ${data['item']}'),
                          Text('Phone: ${data['phone']}'),
                          Text('Notes: ${data['notes']}', style: const TextStyle(fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
