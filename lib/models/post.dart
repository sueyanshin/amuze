class Post {
  int? id;
  String? name;
  int? likes;
  int? views;
  int? rating;
  int? comments;
  bool? isLike;
  bool? isFavourite;
  bool? isSubscribe;
  String? thumbnail;
  String? filePath;
  String? createdAt;
  String? createdDate;
  String? category;
  CreatedByUser? createdByUser;
  bool? isFollow;

  Post({
    this.id,
    this.name,
    this.likes,
    this.views,
    this.rating,
    this.comments,
    this.isLike,
    this.isFavourite,
    this.isSubscribe,
    this.thumbnail,
    this.filePath,
    this.createdAt,
    this.createdDate,
    this.category,
    this.createdByUser,
    this.isFollow,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    likes = json['likes'];
    views = json['views'];
    rating = json['rating'];
    comments = json['comments'];
    isLike = json['is_like'];
    isFavourite = json['is_favourite'];
    isSubscribe = json['is_subscribe'];
    thumbnail = json['thumbnail'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    createdDate = json['created_date'];
    category = json['category'];
    createdByUser = json['createdByUser'] != null
        ? CreatedByUser.fromJson(json['createdByUser'])
        : null;
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['likes'] = likes;
    data['views'] = views;
    data['rating'] = rating;
    data['comments'] = comments;
    data['is_like'] = isLike;
    data['is_favourite'] = isFavourite;
    data['is_subscribe'] = isSubscribe;
    data['thumbnail'] = thumbnail;
    data['file_path'] = filePath;
    data['created_at'] = createdAt;
    data['created_date'] = createdDate;
    data['category'] = category;
    if (createdByUser != null) {
      data['createdByUser'] = createdByUser!.toJson();
    }
    data['is_follow'] = isFollow;
    return data;
  }
}

class CreatedByUser {
  int? id;
  String? name;
  String? profile;

  CreatedByUser({this.id, this.name, this.profile});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile'] = profile;
    return data;
  }
}
