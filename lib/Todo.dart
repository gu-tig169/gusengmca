class Todo {
  String id;
  String name;
  bool done;
  Todo(this.name, this.done,{this.id});

  factory Todo.fromJson(Map<String, dynamic> data){
    return Todo(
      data['title'],
      data['done'],
      id: data['id']
    );
  }

   Map<String, dynamic> toJson(){
    return {
      'title': name,
      'done': done,
    };
  }
}
