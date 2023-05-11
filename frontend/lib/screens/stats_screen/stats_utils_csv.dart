import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;

void exportAndShowCsv(WidgetRef ref, BuildContext context) async {
  final user = ref.read(authProvider).user;

  if (user == null) {
    return;
  }

  final csvResponse = await http.get(
      Uri.parse('http://localhost:3001/api/work/summary'),
      headers: {"Authorization": "Bearer ${user.token}"});

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => _CSVScreen(csv: csvResponse.body),
    ),
  );
}

class _CSVScreen extends StatelessWidget {
  const _CSVScreen({
    super.key,
    required this.csv,
  });

  final String csv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSV"),
      ),
      body: Center(child: Text(csv)),
    );
  }
}
