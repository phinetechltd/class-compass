class ClassRoutineBody {
  List<Routine>? routine;

  ClassRoutineBody({this.routine});

  ClassRoutineBody.fromJson(Map<String, dynamic> json) {
    if (json['routine'] != null) {
      routine = <Routine>[];
      json['routine'].forEach((v) {
        routine!.add(Routine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (routine != null) {
      data['routine'] = routine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routine {
  int? classId;
  int? sectionId;
  int? subjectId;
  String? day;
  String? startTime;
  String? endTime;
  int? teacherId;

  Routine(
      {this.classId,
        this.sectionId,
        this.subjectId,
        this.day,
        this.startTime,
        this.endTime,
        this.teacherId});

  Routine.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    teacherId = json['teacher_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['teacher_id'] = teacherId;
    return data;
  }
}
