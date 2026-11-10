import 'package:flutter/material.dart';

void main() => runApp(const OneAiApp());

class OneAiApp extends StatelessWidget {
  const OneAiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(title: 'OneAI', theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true), home: const OneAiHome());
}

class OneAiHome extends StatefulWidget {
  const OneAiHome({super.key});
  @override
  State<OneAiHome> createState() => _OneAiHomeState();
}

class _OneAiHomeState extends State<OneAiHome> {
  final controller = TextEditingController();
  final messages = <String>[];

  @override
  void dispose() { controller.dispose(); super.dispose(); }
  void addDraft() { final text = controller.text.trim(); if (text.isEmpty) return; setState(() { messages.add(text); controller.clear(); }); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('OneAI')),
    body: Column(children: [
      Expanded(child: ListView.builder(itemCount: messages.length, itemBuilder: (_, index) => ListTile(title: Text(messages[index])))),
      SafeArea(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: TextField(controller: controller, minLines: 1, maxLines: 4, decoration: const InputDecoration(hintText: 'Message OneAI…', border: OutlineInputBorder()))), const SizedBox(width: 8), IconButton(onPressed: addDraft, icon: const Icon(Icons.send))]))),
    ]),
  );
}
