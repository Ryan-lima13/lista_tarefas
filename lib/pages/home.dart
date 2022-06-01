import 'package:flutter/material.dart';
import 'package:lista_tarefas/models/lista.dart';
import 'package:lista_tarefas/repositories/todo_repositories.dart';

import '../widgets/TarefasListItem.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   List<Lista> tarefas = [];
   Lista? deletedLista;
   int? deleteListaPos;
   String? erroText;




   final TextEditingController tarefaController = TextEditingController();
   final TodoRepositories todoRepositories = TodoRepositories();
   @override
   void initState(){
     super.initState();
     todoRepositories.getTodoList().then((value) {
       setState((){
         tarefas = value;
       });
     });

   }


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
                          errorText: erroText,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d7f3),
                              width: 2,
                            )
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff00d7f3),
                          )


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
                          if(text.isEmpty){
                           setState((){
                             erroText = 'O texto não pode ser vazio!';
                           });
                            return;
                          }
                          setState((){
                            Lista novaLista = Lista(
                              title: text,
                              dateTime: DateTime.now()
                            );
                            tarefas.add(novaLista);
                            erroText = null;

                          });
                          tarefaController.clear();
                          todoRepositories.saveTodoList(tarefas);


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
                      for(Lista todo  in tarefas)
                        TarefasListItem(
                          todo: todo,
                            onDelete: onDelete,


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
                        onPressed: showDeleteListaConfirmacao,
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
  void onDelete(Lista todo){
    deletedLista = todo;
    deleteListaPos = tarefas.indexOf(todo);
    setState((){
      tarefas.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Tarefa ${todo.title} foi removida com sucesso!',
            style: TextStyle(
              color: Color(0xff060708)
            ),
          ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xff00d7f3),
          onPressed: (){
            setState((){
              tarefas.insert(deleteListaPos!, deletedLista!);
            });
            todoRepositories.saveTodoList(tarefas);
          },
        ) ,
        duration: const Duration(seconds: 5),

      ),

    );
  }
  void showDeleteListaConfirmacao(){
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Limpar Tudo?'),
      content:  Text('Você tem certeza que deseja apagar todas as tarefas?'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          style: TextButton.styleFrom(
            primary: Color(0xff00d7f3),
          ),
        ),
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              deleteAllTodos();

            },
            style: TextButton.styleFrom(
              primary: Colors.red
            ),
            child: Text('Limpar tudo')
        )
      ],

    ),
    );

  }
  void deleteAllTodos(){
    setState((){
      tarefas.clear();
      todoRepositories.saveTodoList(tarefas);
    });
  }
}
