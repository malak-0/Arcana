import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummaryScreen extends StatefulWidget {
  final String paperId;

  const SummaryScreen({
    super.key,
    required this.paperId,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String summary = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/summarize"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "paper_id": widget.paperId,
        }),
      );

      print("SUMMARY STATUS: ${response.statusCode}");
      print("SUMMARY BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          summary = data["summary"] ?? "No summary found";
          isLoading = false;
        });
      } else {
        setState(() {
          summary = "Server Error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        summary = "Error: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paper Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Text(
                  summary,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
      ),
    );
  }
}