class AudioModel {
  AudioModel({
      this.total, 
      this.page, 
      this.limit, 
      this.totalPages, 
      this.data,});

  AudioModel.fromJson(dynamic json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AudioData.fromJson(v));
      });
    }
  }
  num? total;
  num? page;
  num? limit;
  num? totalPages;
  List<AudioData>? data;
AudioModel copyWith({  num? total,
  num? page,
  num? limit,
  num? totalPages,
  List<AudioData>? data,
}) => AudioModel(  total: total ?? this.total,
  page: page ?? this.page,
  limit: limit ?? this.limit,
  totalPages: totalPages ?? this.totalPages,
  data: data ?? this.data,
);
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

class AudioData {
  AudioData({
      this.id, 
      this.type, 
      this.title, 
      this.url, 
      this.artist, 
      this.thumbnail, 
      this.duration, 
      this.createdAt, 
      this.comments,});

  AudioData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    url = json['url'];
    artist = json['artist'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
  }
  num? id;
  String? type;
  String? title;
  String? url;
  String? artist;
  String? thumbnail;
  String? duration;
  String? createdAt;
  List<Comments>? comments;
AudioData copyWith({  num? id,
  String? type,
  String? title,
  String? url,
  String? artist,
  String? thumbnail,
  String? duration,
  String? createdAt,
  List<Comments>? comments,
}) => AudioData(  id: id ?? this.id,
  type: type ?? this.type,
  title: title ?? this.title,
  url: url ?? this.url,
  artist: artist ?? this.artist,
  thumbnail: thumbnail ?? this.thumbnail,
  duration: duration ?? this.duration,
  createdAt: createdAt ?? this.createdAt,
  comments: comments ?? this.comments,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['title'] = title;
    map['url'] = url;
    map['artist'] = artist;
    map['thumbnail'] = thumbnail;
    map['duration'] = duration;
    map['createdAt'] = createdAt;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
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
Comments copyWith({  num? id,
  String? user,
  num? userId,
  String? text,
  String? createdAt,
  bool? isOwn,
}) => Comments(  id: id ?? this.id,
  user: user ?? this.user,
  userId: userId ?? this.userId,
  text: text ?? this.text,
  createdAt: createdAt ?? this.createdAt,
  isOwn: isOwn ?? this.isOwn,
);
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