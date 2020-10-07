class CommentsModel {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsModel({this.postId, this.id, this.name, this.email, this.body});

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body']);
}
