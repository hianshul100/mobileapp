import 'package:flutter/material.dart';

const skillGreen = Color(0xFF008C7A);
const skillInk = Color(0xFF17112C);
const skillMuted = Color(0xFF675F7A);
const skillSurface = Color(0xFFFFFBF2);
const skillPanel = Color(0xFFFFE3A6);
const skillBorder = Color(0xFFE3D8FF);
const skillGold = Color(0xFFFFD15C);
const skillViolet = Color(0xFF6D4AFF);
const skillCoral = Color(0xFFFF5C7A);
const skillSky = Color(0xFF45C7FF);

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
      borderSide: const BorderSide(color: skillViolet, width: 2),
    ),
  );
}

ButtonStyle skillButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: skillCoral,
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
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE3A6), Color(0xFFFFA8B8), Color(0xFFB9F3FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: skillViolet.withOpacity(0.14),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: skillViolet, width: 4)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
