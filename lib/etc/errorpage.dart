import 'package:flutter/material.dart';

/* show error alert page for flutter 
 */
class errorpage extends StatelessWidget {
  const errorpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
