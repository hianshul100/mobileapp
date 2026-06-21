import 'package:flutter/material.dart';

const skillGreen = Color(0xFF1F6F5B);
const skillInk = Color(0xFF17201A);
const skillMuted = Color(0xFF536159);
const skillSurface = Color(0xFFFBFCF8);
const skillPanel = Color(0xFFE6F0EB);
const skillBorder = Color(0xFFD8DFD5);
const skillGold = Color(0xFFFFD15C);

InputDecoration skillInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: skillBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: skillBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: skillGreen, width: 2),
    ),
  );
}

ButtonStyle skillButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: skillGreen,
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}

class SkillPanel extends StatelessWidget {
  const SkillPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: skillPanel,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class SkillCard extends StatelessWidget {
  const SkillCard({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: skillBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: child,
        ),
      ),
    );
  }
}
