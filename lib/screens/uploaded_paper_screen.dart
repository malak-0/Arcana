import 'package:arcana/screens/summary_screen.dart';
import 'package:arcana/utils/constants.dart';
import 'package:arcana/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class PaperDetailsScreen extends StatelessWidget {
  final String filePath;
  final String fileName;
  final String paperId; // UUID

  const PaperDetailsScreen({
    super.key,
    required this.filePath,
    required this.fileName,
    required this.paperId,
  });

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

              const SizedBox(height: 30),

              Row(
                children: [
                  const Icon(Icons.description, size: 42),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      fileName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(child: Text(filePath)),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Tag(
                      title: 'summary',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SummaryScreen(
                              paperId: paperId,
                            ),
                          ),
                        );
                      },
                    ),

                  const _Tag(title: 'relative work'),

                  _Tag(
                    title: 'ask question',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            paperId: paperId, 
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _Tag({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(title),
      ),
    );
  }
}