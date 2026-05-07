import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String paperId;

  const ChatScreen({
    super.key,
    required this.paperId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  bool isLoading = false;

  Future<void> sendMessage(String text) async {
    final question = text.trim();
    if (question.isEmpty) return;

    controller.clear();

    setState(() {
      messages.add({
        "role": "user",
        "text": question,
      });
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "paper_id": widget.paperId,
          "question": question,
        }),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          messages.add({
            "role": "ai",
            "text": data["answer"] ?? "No response",
          });
          isLoading = false;
        });
      } else {
        setState(() {
          messages.add({
            "role": "ai",
            "text": "Server Error: ${response.statusCode}",
          });
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        messages.add({
          "role": "ai",
          "text": "Error: $e",
        });
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Arcana Chat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];

                  return Align(
                    alignment: msg["role"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg["role"] == "user"
                            ? Colors.blue
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg["text"] ?? ""),
                    ),
                  );
                },
              ),
            ),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Ask something...",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      sendMessage(controller.text);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}