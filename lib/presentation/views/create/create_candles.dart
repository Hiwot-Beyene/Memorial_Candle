import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:lightforisrael/presentation/widgets/my_button.dart';

class CreateCandles extends StatefulWidget {
  @override
  _CreateCandlesState createState() => _CreateCandlesState();
}

class _CreateCandlesState extends State<CreateCandles> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String _name = '';
  DateTime? _bornDate;
  DateTime? _deathDate;
  String _description = '';
  final _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

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
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isBornDate) async {
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
            primaryColor: const Color.fromARGB(255, 53, 80, 103),
            dialogBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white), // Date text
              titleMedium: TextStyle(color: Colors.white), // Header text
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    Color.fromARGB(255, 53, 80, 103), // Cancel/Ok buttons
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
        if (isBornDate) {
          _bornDate = selectedDate;
        } else {
          _deathDate = selectedDate;
        }
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _image == null
                          ? Icon(Icons.camera_alt,
                              color: Colors.grey[600], size: 50)
                          : null,
                    ),
                    SizedBox(height: 8),
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
              SizedBox(height: 16),

              // Name Field
              Theme(
                data: ThemeData(
                  primaryColor: const Color.fromARGB(255, 53, 80, 103),
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: const Color.fromARGB(255, 53, 80, 103),
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Person Name',
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 53, 80, 103),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 53, 80, 103),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value ?? '';
                  },
                ),
              ),
              SizedBox(height: 16),

              // Born Date Picker
              Theme(
                data: ThemeData(
                  primaryColor: const Color.fromARGB(255, 53, 80, 103),
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: const Color.fromARGB(255, 53, 80, 103),
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Born Date',
                    suffixIcon: Icon(Icons.calendar_today,
                        color: const Color.fromARGB(255, 53, 80, 103)),
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 53, 80, 103),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 53, 80, 103),
                      ),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  controller: TextEditingController(
                    text: _bornDate != null
                        ? '${_bornDate!.toLocal()}'.split(' ')[0]
                        : '',
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Death Date Picker
              Theme(
                data: ThemeData(
                  primaryColor: const Color.fromARGB(255, 53, 80, 103),
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: const Color.fromARGB(255, 53, 80, 103),
                  ),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Death Date',
                    suffixIcon: Icon(Icons.calendar_today,
                        color: const Color.fromARGB(255, 53, 80, 103)),
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 53, 80, 103),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 53, 80, 103),
                      ),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  controller: TextEditingController(
                    text: _deathDate != null
                        ? '${_deathDate!.toLocal()}'.split(' ')[0]
                        : '',
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Description Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: ThemeData(
                      primaryColor: const Color.fromARGB(255, 53, 80, 103),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: const Color.fromARGB(255, 53, 80, 103),
                      ),
                    ),
                    child: TextFormField(
                      controller: _descriptionController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 53, 80, 103),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 53, 80, 103),
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
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              const SizedBox(height: 16),

              // Create Button
              MyButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Candle Created')),
                    );
                  }
                },
                buttonText: 'Create Candle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
