
import 'package:flutter/material.dart';
class TarefasListItem extends StatelessWidget {
  const TarefasListItem({Key? key,required this.title}) : super(key: key);

  final String title;

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
          Text('20/03/2022',
            style: TextStyle(
              fontSize: 12
            ),
          ),

          Text(
            title,
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
