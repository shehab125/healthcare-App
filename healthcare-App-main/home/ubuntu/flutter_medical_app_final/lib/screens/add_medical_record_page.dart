import 'package:flutter/material.dart';

class AddMedicalRecordPage extends StatefulWidget {
  const AddMedicalRecordPage({super.key});

  @override
  State<AddMedicalRecordPage> createState() => _AddMedicalRecordPageState();
}

class _AddMedicalRecordPageState extends State<AddMedicalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _medicationsController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _doctorController.dispose();
    _specialtyController.dispose();
    _diagnosisController.dispose();
    _medicationsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Medical Record',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3EC8D6), Color(0xFF6EE2F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_dateController, 'Date', 'Enter visit date'),
              _buildTextField(
                  _doctorController, 'Doctor Name', 'Enter treating doctor name'),
              _buildTextField(
                  _specialtyController, 'Specialty', 'Enter doctor specialty'),
              _buildTextField(_diagnosisController, 'Diagnosis', 'Enter diagnosis'),
              _buildTextField(_medicationsController, 'Medications',
                  'Enter prescribed medications (comma separated)'),
              _buildTextField(
                  _notesController, 'Notes', 'Enter any additional notes',
                  maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Medical record added successfully!')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3EC8D6),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add Record',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF3EC8D6), width: 2),
          ),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
