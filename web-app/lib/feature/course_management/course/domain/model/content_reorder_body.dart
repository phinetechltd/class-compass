class ContentReorderBody {
  int? chapterId;
  List<Content>? contents;

  ContentReorderBody({this.chapterId, this.contents});

  ContentReorderBody.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    if (json['contents'] != null) {
      contents = <Content>[];
      json['contents'].forEach((v) {
        contents!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_id'] = chapterId;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int? contentId;
  int? serial;

  Content({this.contentId, this.serial});

  Content.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['serial'] = serial;
    return data;
  }
}
