import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SegmentedToggle extends StatelessWidget {
  final bool isFirstSelected;
  final String firstTitle;
  final String secondTitle;

  final Widget firstScreen;
  final Widget secondScreen;

  const SegmentedToggle({
    super.key,
    required this.isFirstSelected,
    required this.firstTitle,
    required this.secondTitle,
    required this.firstScreen,
    required this.secondScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _segment(
            context,
            firstTitle,
            isFirstSelected,
            firstScreen,
          ),

          const SizedBox(width: 8),

          _segment(
            context,
            secondTitle,
            !isFirstSelected,
            secondScreen,
          ),
        ],
      ),
    );
  }

  Widget _segment(
    BuildContext context,
    String title,
    bool selected,
    Widget screen,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },

        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.dark
                : AppColors.background,

            borderRadius: BorderRadius.circular(22),

            border: Border.all(
              color: AppColors.border,
            ),
          ),

          alignment: Alignment.center,

          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? AppColors.background
                  : AppColors.dark,

              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}