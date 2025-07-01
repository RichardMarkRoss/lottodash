import 'package:flutter/material.dart';
import 'package:lottodash/components/EditProfileDialog.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LeftDrawerContent extends StatelessWidget {
  const LeftDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const EditProfileDialog()],
        ),
      ),
    );
  }
}

class LeftDraw extends StatelessWidget {
  const LeftDraw({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeftDrawerContent(); // No need for an inner drawer
  }
}
