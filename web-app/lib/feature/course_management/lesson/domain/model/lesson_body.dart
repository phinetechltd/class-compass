class LessonBody {
  String? courseId;
  String? chapterId;
  String? title;
  String? description;
  String? videoType;
  String? videoUrl;
  String? playbackHours;
  String? playbackMinutes;
  String? playbackSeconds;
  String? isScheduled;
  String? scheduledAt;
  String? visibility;
  String? password;
  String? sMethod;


  LessonBody(
      {this.courseId,
        this.title,
        this.description,
        this.videoType,
        this.videoUrl,
        this.playbackHours,
        this.playbackMinutes,
        this.playbackSeconds,
        this.isScheduled,
        this.scheduledAt,
        this.visibility,
        this.password,
        this.chapterId,
        this.sMethod,
      });

  LessonBody.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    title = json['title'];
    description = json['description'];
    videoType = json['video_type'];
    videoUrl = json['video_url'];
    playbackHours = json['playback_hours'];
    playbackMinutes = json['playback_minutes'];
    playbackSeconds = json['playback_seconds'];
    isScheduled = json['is_scheduled'];
    scheduledAt = json['scheduled_at'];
    visibility = json['visibility'];
    password = json['password'];
    chapterId = json['chapter_id'];
    sMethod = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};

    if (courseId != null) data['course_id'] = courseId!;
    if (title != null) data['title'] = title??'';
    if (description != null) data['description'] = description??'';
    if (videoType != null) data['video_type'] = videoType??'';
    if (videoUrl != null) data['video_url'] = videoUrl??'';
    if (playbackHours != null) data['playback_hours'] = playbackHours??'';
    if (playbackMinutes != null) data['playback_minutes'] = playbackMinutes??'';
    if (playbackSeconds != null) data['playback_seconds'] = playbackSeconds??'';
    if (isScheduled != null) data['is_scheduled'] = isScheduled??'';
    if (scheduledAt != null) data['scheduled_at'] = scheduledAt??'';
    if (visibility != null) data['visibility'] = visibility??'';
    if (password != null) data['password'] = password??'';
    if (chapterId != null) data['chapter_id'] = chapterId??'';
    if (sMethod != null) data['_method'] = sMethod??'';

    return data;
  }

}
