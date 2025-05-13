import 'package:flutter/material.dart';

class CardModel {
  final String holderName;
  final String number;
  final String expiry;
  final String cvv;
  CardModel({required this.holderName, required this.number, required this.expiry, required this.cvv});
}

class AddCardPage extends StatefulWidget {
  static List<CardModel> cards = [];
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Card', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3EC6E0), Color(0xFF4F8FEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Card Preview
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3EC6E0), Color(0xFF4F8FEA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_numberController.text.isEmpty ? '000 000 000 00' : _numberController.text,
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Card Holder Name', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text(_nameController.text.isEmpty ? 'John Doe' : _nameController.text,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expiry Date', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text(_expiryController.text.isEmpty ? '04/28' : _expiryController.text,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text('Card Holder Name', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInputField(hint: 'John Doe', controller: _nameController, validator: (v) => v!.isEmpty ? 'Enter card holder name' : null),
                  const SizedBox(height: 18),
                  const Text('Card Number', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInputField(
                    hint: '0000 0000 0000 0000',
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Enter card number';
                      final digits = v.replaceAll(' ', '');
                      if (digits.length != 16) return 'Card number must be 16 digits';
                      if (!RegExp(r'^\d{16}\$').hasMatch(digits)) return 'Invalid card number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Expiry Date', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hint: '04/28',
                              controller: _expiryController,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Enter expiry date';
                                if (!RegExp(r'^(0[1-9]|1[0-2])\/(\d{2})').hasMatch(v)) return 'Invalid format MM/YY';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('CVV', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hint: '0000',
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Enter CVV';
                                if (v.length < 3 || v.length > 4) return 'CVV must be 3 or 4 digits';
                                if (!RegExp(r'^\d{3,4}\$').hasMatch(v)) return 'Invalid CVV';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: const Color(0xFF3EC6E0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AddCardPage.cards.add(CardModel(
                            holderName: _nameController.text,
                            number: _numberController.text,
                            expiry: _expiryController.text,
                            cvv: _cvvController.text,
                          ));
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Card added successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Save Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required String hint, TextEditingController? controller, String? Function(String?)? validator, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
} 