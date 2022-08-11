import 'package:flutter/material.dart';

class BMIResult extends StatelessWidget {

  final int result ;
  final bool isMale;
  final int age ;
  BMIResult({
    required this.result,
    required this.age,
    required this.isMale,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gender : ${isMale ? 'Male' : 'Female'}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
            Text('Result : ${result}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
            Text('Age : ${age}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
          ],
        ),
      ),

    );
  }
}
