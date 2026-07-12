class BlogModel {
  BlogModel({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.data,});

  BlogModel.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BlogData.fromJson(v));
      });
    }
  }
  num? total;
  num? page;
  num? limit;
  num? totalPages;
  List<BlogData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['limit'] = limit;
    map['totalPages'] = totalPages;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class BlogData {
  BlogData({
      this.id, 
      this.type, 
      this.title, 
      this.excerpt, 
      this.author, 
      this.createdAt, 
      this.comments, 
      this.coverImage, 
      this.content,});

  BlogData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    excerpt = json['excerpt'];
    author = json['author'];
    createdAt = json['createdAt'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    coverImage = json['coverImage'];
    content = json['content'];
  }
  num? id;
  String? type;
  String? title;
  String? excerpt;
  String? author;
  String? createdAt;
  List<Comments>? comments;
  String? coverImage;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['title'] = title;
    map['excerpt'] = excerpt;
    map['author'] = author;
    map['createdAt'] = createdAt;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    map['coverImage'] = coverImage;
    map['content'] = content;
    return map;
  }

}

class Comments {
  Comments({
      this.id, 
      this.user, 
      this.userId, 
      this.text, 
      this.createdAt, 
      this.isOwn,});

  Comments.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'];
    userId = json['userId'];
    text = json['text'];
    createdAt = json['createdAt'];
    isOwn = json['isOwn'];
  }
  num? id;
  String? user;
  num? userId;
  String? text;
  String? createdAt;
  bool? isOwn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user'] = user;
    map['userId'] = userId;
    map['text'] = text;
    map['createdAt'] = createdAt;
    map['isOwn'] = isOwn;
    return map;
  }

}