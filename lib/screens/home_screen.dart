import 'package:arcana/screens/new_paper_screen.dart';
import 'package:arcana/utils/constants.dart';
import 'package:arcana/widgets/paper_card.dart';
import 'package:arcana/widgets/segmented_toggle.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Arcana',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.dark,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning'),
                      Text(
                        'Malak',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      const SegmentedToggle(
                        isFirstSelected: true,
                        firstTitle: 'Your Papers',
                        secondTitle: 'New Paper', firstScreen: HomeScreen(), secondScreen: CreatePaperScreen(),
                      ),
                      const SizedBox(height: 40),
                      const PaperCard(title: 'paper 1'),
                      const PaperCard(title: 'paper 2'),
                      const PaperCard(title: 'paper 3'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}