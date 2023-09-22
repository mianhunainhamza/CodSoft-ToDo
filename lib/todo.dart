
class Todo {
  int? id;
  String? title;
  String? description;
  bool? status = false;

  Todo({this.id, this.title, this.description, this.status}) {
    id = id;
    title = title;
    description = description;
    status = status;
  }

  toJson() {
    return {
      "id": id,
      "description": description,
      "title": title,
      "status": status
    };
  }

  fromJson(jsonData) {
    return Todo(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        status: jsonData['status']);
  }
}
