import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_mongo_lab1/Widget/customCliper.dart'; // Assuming you already have customClipper

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String productType = '';
  int price = 0;
  String unit = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            // Background
            Positioned(
              top: -height * .15,
              right: -width * .4,
              child: Transform.rotate(
                angle: -pi / 3.5,
                child: ClipPath(
                  clipper: ClipPainter(),
                  child: Container(
                    height: height * .5,
                    width: width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 1, 197, 27),
                          
                          Color.fromARGB(255, 232, 225, 13), 
                          Color.fromARGB(255, 232, 21, 21),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Form content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * .1),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'เพิ่ม',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 19, 20, 19),
                        ),
                        children: [
                          TextSpan(
                            text: 'สินค้าใหม่',
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 188, 60), fontSize: 35),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildTextField(
                            label: 'ชื่อสินค้า',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกชื่อสินค้า';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              productName = value!;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'ประเภทสินค้า',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกประเภทสินค้า';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              productType = value!;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'ราคา',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกราคา';
                              }
                              if (int.tryParse(value) == null) {
                                return 'กรุณากรอกจำนวนเต็มที่ถูกต้อง';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              price = int.parse(value!);
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            label: 'หน่วย',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกหน่วย';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              unit = value!;
                            },
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // บันทึกข้อมูลสินค้าใหม่
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 221, 109, 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              child: Text(
                                'บันทึก',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 18, 2, 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType? keyboardType,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
