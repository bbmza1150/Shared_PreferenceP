import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_mongo_lab1/Widget/customCliper.dart';
import 'package:flutter_mongo_lab1/controllers/auth_controller.dart';
import 'package:flutter_mongo_lab1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการออกจากระบบ'),
          content: const Text('คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
            TextButton(
              child: const Text('ออกจากระบบ'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
                Navigator.popAndPushNamed(
                    context, '/login'); // navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'id': '1',
        'productName': 'Product 1',
        'productType': 'Electronics',
        'price': 200,
        'unit': 'pcs',
        'createdAt': DateTime.now().subtract(const Duration(days: 1)),
        'updatedAt': DateTime.now(),
      },
      {
        'id': '2',
        'productName': 'Product 2',
        'productType': 'Clothing',
        'price': 300,
        'unit': 'pcs',
        'createdAt': DateTime.now().subtract(const Duration(days: 2)),
        'updatedAt': DateTime.now(),
      },
      {
        'id': '3',
        'productName': 'Product 3',
        'productType': 'Books',
        'price': 100,
        'unit': 'pcs',
        'createdAt': DateTime.now().subtract(const Duration(days: 5)),
        'updatedAt': DateTime.now(),
      },
    ];

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .1),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'จัดการ',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 13, 10, 11),
                        ),
                        children: [
                          TextSpan(
                            text: 'สินค้า',
                            style: TextStyle(
                                color: Color.fromARGB(255, 232, 130, 71), fontSize: 35),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Consumer<UserProvider>(
                      builder: (context, UserProvider, _) {
                        return Column(
                          children: [
                            const Text(
                              'Access Token : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 59, 222, 33),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              UserProvider.accessToken,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 108, 69, 80),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Refresh Token : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 23, 202, 7),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              UserProvider.refreshToken,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 24, 231, 227),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AuthController().refreshToken(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 135, 212, 28),
                              ),
                              child: const Text(
                                'Update Token',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // Button to add new product
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add_product');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 135, 212, 28),
                      ),
                      child: const Text(
                        'เพิ่มสินค้าใหม่',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Products List
                    Column(
                      children: List.generate(products.length, (index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 225, 215, 183),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index]['productName']!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 230, 59, 225)),
                                    ),
                                    Text(
                                      'ประเภท: ${products[index]['productType']}',  
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'ราคา: \$${products[index]['price']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'หน่วย: ${products[index]['unit']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'สร้างเมื่อ: ${products[index]['createdAt']}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'แก้ไขล่าสุด: ${products[index]['updatedAt']}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              // Edit Button
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 21, 216, 132),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/edit_product',
                                  );
                                },
                              ),
                              // Delete Button
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 221, 107, 139),
                                ),
                                onPressed: () {
                                  // Handle delete functionality
                                  print(
                                      'Delete product: ${products[index]['id']}');
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            // LogOut Button
            Positioned(
              top: 50.0,
              right: 16.0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
                child: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 240, 99, 146),
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
