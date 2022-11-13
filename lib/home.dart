import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo/todo_item.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList=ToDo.todoList();
  List<ToDo> _foundToDo=[];
  final _todoController=TextEditingController();
@override
  void initState() {
    _foundToDo=todoList;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: _buildAppBar(),
      body:Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child:const Text("Muslimbek's ToDos",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                      ),
                      for(ToDo todoo in _foundToDo.reversed)
                      ToDo_items(
                        
                        todo: todoo,
                        onToDoChanged: _handleTodoChange,
                        onToDoDelateitem: _delateToDoItem ,
                        ),
                ],))
                 
              ],),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 15),
                  padding:const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      boxShadow: const[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset:Offset(0, 0)
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: "Add new ToDo item",
                        
                        border: InputBorder.none
                      ),
                    ),
              )),
              Container(
                margin:const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20),
                  child: ElevatedButton(onPressed: (() {
                    _addtoDoitem(_todoController.text);
                  }),
                   child: Text("+",
                   style: TextStyle(
                    fontSize: 46,
                    
                   ),),
                   style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 193, 121, 14),
                    minimumSize: Size(60, 60),
                    elevation: 10
                   ),
                   ),
              )
            ]),
          )
        ],
      )
    );
  }

  void _handleTodoChange(ToDo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });
  }
void _delateToDoItem(String id){
  setState(() {
    todoList.removeWhere((item) => item.id==id);
  });
}
void  _addtoDoitem(String toDo){
  setState(() {
    todoList.add(ToDo(id:DateTime.now().millisecondsSinceEpoch.toString() , 
    todoText: toDo));
  });
  _todoController.clear();
}
void _filterToDo(String enteredkeyword){
  List<ToDo> results=[];
  if(enteredkeyword.isEmpty){
    results=todoList;
  }
  else{
    results=todoList.where((item) => item.todoText!
    .toLowerCase()
    .contains(enteredkeyword
    .toLowerCase())).toList();
  }
  setState(() {
    _foundToDo=results;
  });
}
  Widget searchBox(){
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange
            ),
            child: TextField(
              onChanged: (value) => _filterToDo(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                 suffix: Icon(Icons.search,
                 color: Colors.white.withOpacity(0.8),size: 24),
                 prefixIconConstraints: BoxConstraints(maxHeight: 30,minWidth: 30),
                 border: InputBorder.none,
                 hintText: "Search",
                 hintStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 22
                 )
              ),
            ),
          );
         }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       const Icon(Icons.menu,size: 30,color: Colors.black,),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
          child: Image.asset('assets/images/1.png')))
      ],)
    );
  }
}