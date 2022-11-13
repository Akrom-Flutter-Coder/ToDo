import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
class ToDo_items extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onToDoDelateitem;
   ToDo_items({super.key,
  required this.todo,
  required this.onToDoChanged,
  required this.onToDoDelateitem,
  });
 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow:const [
          BoxShadow(
            color:Colors.black12,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(-5, -5)
          ),
           BoxShadow(
            color:Color.fromARGB(255, 1, 123, 111),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(5, 5)
          )
        ]
      ),
      margin: EdgeInsets.only(bottom:30,right: 8,left: 8),
      child: ListTile(
        onTap: () {
          //print('click on tab ');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading:  Icon(
         todo.isDone? Icons.check_box:Icons.check_box_outline_blank,
          color: Color.fromARGB(255, 107, 240, 111),
          size: 35,),
        title: Text(todo.todoText!,
        style:  TextStyle(
          color: Colors.white,
          fontSize: 16,
          decoration: todo.isDone? TextDecoration.lineThrough:null
        ),),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Color(0xFFDA4040),
            borderRadius: BorderRadius.circular(5)
          ),
          child:Center(
            child: IconButton(
              color: Colors.white.withOpacity(0.8),
              iconSize: 18,
              icon: Icon(Icons.delete),
             onPressed: (() {
              //print('click delate button');
              onToDoDelateitem(todo.id);
              }), 
            ),
          ) 
        ), 
      ),
    );
  }
}