import 'package:flutter/material.dart';

import '../widgets/TarefasListItem.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   List<String> tarefas = [];

   final TextEditingController tarefaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: tarefaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex: Estudar',

                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)

                      ),
                        onPressed: (){
                          String text =tarefaController.text;
                          setState((){
                            tarefas.add(text);

                          });
                          tarefaController.clear();

                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                        )
                    )
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(String tarefa in tarefas)
                        TarefasListItem(
                          title: tarefa,
                        ),


                    ],
                  ),
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(child: Text('Você possui ${tarefas.length} tarefas pendentes')),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14)
                      ),
                        onPressed: (){},
                        child: Text('Limpar tudo')
                    )
                  ],
                )

              ],
            ),
          ),
        ),


      ),
    );
  }
}
