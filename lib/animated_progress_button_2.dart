import 'package:flutter/material.dart';

enum ButtonState { init, loading, done }

class AnimatedProgressButtonTwo extends StatefulWidget {
  const AnimatedProgressButtonTwo({super.key});

  @override
  State<AnimatedProgressButtonTwo> createState() => _AnimatedProgressButtonTwoState();
}

class _AnimatedProgressButtonTwoState extends State<AnimatedProgressButtonTwo> {
  bool isStretched = true;
  bool isDone = false;
  bool isAnimating = true;
  ButtonState state = ButtonState.init;
  onPressed() async {
    setState(() => state = ButtonState.loading);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => state = ButtonState.done);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => state = ButtonState.init);
  }

  @override
  Widget build(BuildContext context) {
    isDone = state == ButtonState.done;
    isStretched = isAnimating || state == ButtonState.init;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: 50,
      width: state == ButtonState.init ? 333 : 50,
      onEnd: () => setState(() => isAnimating = !isAnimating),
      child: isStretched ? MainButton(onPressed: onPressed) : SmallButton(isDone: isDone),
    );
  }
}

class MainButton extends StatelessWidget {
  final Function onPressed;
  const MainButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 24),
        shape: const StadiumBorder(),
        side: const BorderSide(
          width: 2,
          color: Colors.indigo,
        ),
      ),
      child: const FittedBox(
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: 24,
            color: Colors.indigo,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final bool isDone;
  const SmallButton({super.key, required this.isDone});

  @override
  Widget build(BuildContext context) {
    final Color color = isDone ? Colors.green : Colors.indigo;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: const EdgeInsets.all(9),
      child: Center(
        child: isDone
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              )
            : const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
      ),
    );
  }
}
