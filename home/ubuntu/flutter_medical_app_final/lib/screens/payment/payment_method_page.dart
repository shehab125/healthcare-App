import 'package:flutter/material.dart';
import 'add_card_page.dart';
import 'payment_page.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    final savedCards = AddCardPage.cards;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment Method', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text('Credit & Debit Card', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 12),
                if (savedCards.isNotEmpty)
                  ...List.generate(savedCards.length, (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildCardOption(
                      card: savedCards[i],
                      value: 100 + i,
                      selected: _selectedMethod == 100 + i,
                      onTap: () => setState(() => _selectedMethod = 100 + i),
                    ),
                  )),
                _buildOptionCard(
                  icon: Icons.credit_card,
                  label: 'Add New Card',
                  value: 0,
                  onTap: () {
                    setState(() => _selectedMethod = 0);
                    Navigator.pushNamed(context, '/add_card').then((_) => setState(() {}));
                  },
                ),
                const SizedBox(height: 24),
                const Text('More Payment Option', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _buildOptionCard(icon: Icons.apple, label: 'Apple Play', value: 1, onTap: () => setState(() => _selectedMethod = 1)),
                const SizedBox(height: 12),
                _buildOptionCard(icon: Icons.account_balance_wallet, label: 'Paypal', value: 2, onTap: () => setState(() => _selectedMethod = 2)),
                const SizedBox(height: 12),
                _buildOptionCard(icon: Icons.android, label: 'Google Play', value: 3, onTap: () => setState(() => _selectedMethod = 3)),
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
                      dynamic selected;
                      if (_selectedMethod >= 100) {
                        selected = savedCards[_selectedMethod - 100];
                      } else {
                        selected = _selectedMethod;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(paymentMethod: selected),
                        ),
                      );
                    },
                    child: const Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardOption({required CardModel card, required int value, required bool selected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: selected ? Border.all(color: Color(0xFF3EC6E0), width: 2) : null,
        ),
        child: Row(
          children: [
            const Icon(Icons.credit_card, color: Color(0xFF3EC6E0), size: 28),
            const SizedBox(width: 16),
            Expanded(child: Text('${card.holderName} | ${card.number}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF3EC6E0), width: 2),
                color: selected ? const Color(0xFF3EC6E0) : Colors.transparent,
              ),
              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({required IconData icon, required String label, required int value, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF3EC6E0), size: 28),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF3EC6E0), width: 2),
                color: value == _selectedMethod ? const Color(0xFF3EC6E0) : Colors.transparent,
              ),
              child: value == _selectedMethod
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
} 