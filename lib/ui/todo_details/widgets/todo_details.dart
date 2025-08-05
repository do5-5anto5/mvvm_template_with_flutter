import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listando detalhes do Todo')),
      body: Center(
        child: Text('Visualizando detalhes do todo: ${widget.id}'),
      ),
    );
  }
}
