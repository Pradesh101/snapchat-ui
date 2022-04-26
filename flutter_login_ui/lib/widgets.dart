import 'package:flutter/material.dart';

Widget text({required String data, required TextStyle style}) {
  return Text(
    data,
    style: style,
  );
}

circularProgressBar() {
  return const Center(
    child: CircularProgressIndicator(
      //value: 2,
      valueColor: AlwaysStoppedAnimation(Colors.blue),
    ),
  );
}
