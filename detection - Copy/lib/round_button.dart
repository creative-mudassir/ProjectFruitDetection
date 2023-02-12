import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 5, 5),
            // gradient: const LinearGradient(
            //   colors: [
            //     Color.fromARGB(255, 248, 58, 100),
            //     Color.fromARGB(255, 43, 156, 70),
            //   ],
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topLeft,
            // ),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
