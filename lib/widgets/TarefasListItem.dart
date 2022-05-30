
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/lista.dart';
class TarefasListItem extends StatelessWidget {
  const TarefasListItem({Key? key,required this.todo}) : super(key: key);

  final Lista todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[200],
      ),

      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd/MM/yyy - HH:mm').format(todo.dateTime),
            style: TextStyle(
              fontSize: 12
            ),
          ),

          Text(
            todo.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),

          ),
        ],
      ),
    );
  }
}
