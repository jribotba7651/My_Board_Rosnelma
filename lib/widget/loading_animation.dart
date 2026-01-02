import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  final double? size;
  final Color? color;

  const LoadingAnimation({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 50,
        height: size ?? 50,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class CustomLoader extends StatelessWidget {
  final String? message;

  const CustomLoader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LoadingAnimation(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ],
      ),
    );
  }
}