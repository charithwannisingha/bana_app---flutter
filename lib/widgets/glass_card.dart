import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const GlassCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // වීදුරු ගතිය සඳහා වර්ණ
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(20),
          // සුදු පාට රාමුවක් (Border)
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6),
            width: 1.5,
          ),
          // ලස්සන Shadow එකක්
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : color.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Icon එක වටේට ලස්සන රවුමක්
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? color.withOpacity(0.2) : color.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isDark ? color : Colors.brown.shade800, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF2D1B14), // තද දුඹුරු පාටින් අකුරු
                  ),
                ),
              ),
              // ඉස්සරහට යන ඊතලය
              Icon(Icons.arrow_forward_ios_rounded, color: isDark ? Colors.white38 : Colors.black26, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}