import 'package:arcana/screens/home_screen.dart';
import 'package:arcana/screens/uploaded_paper_screen.dart';
import 'package:arcana/utils/constants.dart';
import 'package:arcana/widgets/custom_button.dart';
import 'package:arcana/widgets/segmented_toggle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePaperScreen extends StatelessWidget {
  const CreatePaperScreen({super.key});

  Future<void> uploadAndOpenPaper(
    BuildContext context, PlatformFile file) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2:8000/upload"),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', file.path!),
    );

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    print("UPLOAD STATUS: ${response.statusCode}");
    print("UPLOAD RESPONSE: $respStr");

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: ${response.statusCode}")),
      );
      return;
    }

    final data = jsonDecode(respStr);

    if (!data.containsKey("paper_id")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("paper_id missing from backend")),
      );
      return;
    }

    final paperId = data["paper_id"];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaperDetailsScreen(
          filePath: file.path!,
          fileName: file.name,
          paperId: paperId,
        ),
      ),
    );

  } catch (e) {
    print("UPLOAD ERROR: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

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

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      SegmentedToggle(
                        isFirstSelected: false,
                        firstTitle: 'Your Papers',
                        secondTitle: 'New Paper',
                        firstScreen: HomeScreen(),
                        secondScreen: CreatePaperScreen(),
                      ),

                      const SizedBox(height: 40),

                      CustomButton(
                        title: 'Upload File',
                        icon: 'assets/icons/open-folder.png',
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            final file = result.files.single;

                            await uploadAndOpenPaper(context, file); // ✅ FIXED FLOW
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      CustomButton(
                        title: 'Build From Scratch',
                        icon: 'assets/icons/wirte (1).png',
                        onTap: () {},
                      ),
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