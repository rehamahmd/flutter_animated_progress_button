import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedProgressButtonOne extends StatefulWidget {
  const AnimatedProgressButtonOne({super.key});

  @override
  State<AnimatedProgressButtonOne> createState() => _AnimatedProgressButtonOneState();
}

class _AnimatedProgressButtonOneState extends State<AnimatedProgressButtonOne> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          isLoading = false;
        });
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 24),
        minimumSize: const Size.fromHeight(50),
        shape: const StadiumBorder(),
        backgroundColor: isLoading ? Colors.deepPurple.withOpacity(.4) : null,
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(width: 24),
                Text("Please wait ..."),
              ],
            )
          : const Text("Login"),
    );
  }
}
