import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lightforisrael/data/services/memorials_service.dart';

class CreateCandles extends StatefulWidget {
  const CreateCandles({Key? key}) : super(key: key);

  @override
  _CreateCandlesState createState() => _CreateCandlesState();
}

class _CreateCandlesState extends State<CreateCandles> {
  final _formKey = GlobalKey<FormState>();
  String? _personName;
  String? _description;
  DateTime? _birthDate;
  DateTime? _deceasedDate;
  File? _imageFile;
  final MemorialService _memorialService = MemorialService();
  final _descriptionController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _deceasedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() {
        _description = _descriptionController.text;
      });
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(
                  255, 53, 80, 103), // Header and selected date color
              onPrimary: Colors.white, // Text color for selected date
              onSurface: Colors.white, // Text color for non-selected dates
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white), // Date text
              titleMedium: TextStyle(color: Colors.white), // Header text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color.fromARGB(255, 53, 80, 103), // Cancel/Ok buttons
              ),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.black,
              dayStyle: TextStyle(color: Colors.white), // Non-selected days
              headerHelpStyle: TextStyle(color: Colors.white), // Header
              yearStyle: TextStyle(color: Colors.white), // Year
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (isBirthDate) {
          _birthDate = selectedDate;
          _birthDateController.text = '${_birthDate!.toLocal()}'.split(' ')[0];
        } else {
          _deceasedDate = selectedDate;
          _deceasedDateController.text =
              '${_deceasedDate!.toLocal()}'.split(' ')[0];
        }
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select an image')));
        return;
      }

      try {
        await _memorialService.createMemorial(
          personName: _personName!,
          description: _description!,
          birthDate: _birthDate!,
          deceasedDate: _deceasedDate!,
          imageFile: _imageFile!,
        );

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Memorial has been created successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ).then((_) {
          // Reset the form fields
          setState(() {
            _formKey.currentState?.reset();
            _birthDateController.clear();
            _deceasedDateController.clear();
            _imageFile = null;
          });
        });
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _birthDateController.dispose();
    _deceasedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Candle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey[600]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        image: _imageFile != null
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _imageFile == null
                          ? Icon(Icons.camera_alt,
                              color: Colors.grey[600], size: 50)
                          : null,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload Photo',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Person Name Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Person Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _personName = value,
              ),

              const SizedBox(height: 16),

              // Birth Date Picker
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, true),
                controller: _birthDateController,
              ),
              const SizedBox(height: 16),

              // Deceased Date Picker
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Deceased Date',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, false),
                controller: _deceasedDateController,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 53, 80, 103),
                    ),
                  ),
                ),
                maxLength: 200,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Candle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
