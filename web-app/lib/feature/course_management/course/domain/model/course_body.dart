class CourseBody {
  String? courseCategoryId;
  String? title;
  String? slug;
  String? status;
  String? publishDate;
  String? type;
  String? paymentType;
  String? invoiceTitle;
  String? regularPrice;
  String? offerPrice;
  String? repeatCount;
  String? durationHours;
  String? totalCycles;
  String? isInfinity;
  String? isAutoGenerateInvoice;
  String? isSubscriptionAvailable;
  String? description;
  String? faqs;
  String? paymentDuration;
  String? fakeEnrolledStudent;
  String? totalClasses;
  String? totalNotes;
  String? totalExams;
  String? videoType;
  String? videoUrl;
  String? sMethod;


  CourseBody(
      {this.courseCategoryId,
        this.title,
        this.slug,
        this.status,
        this.publishDate,
        this.type,
        this.paymentType,
        this.invoiceTitle,
        this.regularPrice,
        this.offerPrice,
        this.repeatCount,
        this.durationHours,
        this.totalCycles,
        this.isInfinity,
        this.isAutoGenerateInvoice,
        this.isSubscriptionAvailable,
        this.description,
        this.faqs,
        this.paymentDuration,
        this.fakeEnrolledStudent,
        this.totalClasses,
        this.totalNotes,
        this.totalExams,
        this.videoType,
        this.videoUrl,
        this.sMethod});

  CourseBody.fromJson(Map<String, dynamic> json) {
    courseCategoryId = json['course_category_id'];
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    publishDate = json['publish_date'];
    type = json['type'];
    paymentType = json['payment_type'];
    invoiceTitle = json['invoice_title'];
    regularPrice = json['regular_price'];
    offerPrice = json['offer_price'];
    repeatCount = json['repeat_count'];
    durationHours = json['duration_hours'];
    totalCycles = json['total_cycles'];
    isInfinity = json['is_infinity'];
    isAutoGenerateInvoice = json['is_auto_generate_invoice'];
    isSubscriptionAvailable = json['is_subscription_available'];
    description = json['description'];
    faqs = json['faqs'];
    paymentDuration = json['payment_duration'];
    fakeEnrolledStudent = json['fake_enrolled_students'];
    totalClasses = json['total_classes'];
    totalNotes = json['total_notes'];
    totalExams = json['total_exams'];
    videoType = json['video_type'];
    videoUrl = json['video_url'];
    sMethod = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = {};

    if (courseCategoryId != null) data['course_category_id'] = courseCategoryId!;
    if (title != null) data['title'] = title!;
    if (slug != null) data['slug'] = slug!;
    if (status != null) data['status'] = status!;
    if (publishDate != null) data['publish_date'] = publishDate!;
    if (type != null) data['type'] = type!;
    if (paymentType != null) data['payment_type'] = paymentType!;
    if (invoiceTitle != null) data['invoice_title'] = invoiceTitle!;
    if (regularPrice != null) data['regular_price'] = regularPrice!;
    if (offerPrice != null) data['offer_price'] = offerPrice!;
    if (repeatCount != null) data['repeat_count'] = repeatCount!;
    if (durationHours != null) data['duration_hours'] = durationHours!;
    if (totalCycles != null) data['total_cycles'] = totalCycles!;
    if (isInfinity != null) data['is_infinity'] = isInfinity!;
    if (isAutoGenerateInvoice != null) data['is_auto_generate_invoice'] = isAutoGenerateInvoice!;
    if (isSubscriptionAvailable != null) data['is_subscription_available'] = isSubscriptionAvailable!;
    if (description != null) data['description'] = description!;
    if (faqs != null) data['faqs'] = faqs!;
    if (paymentDuration != null) data['payment_duration'] = paymentDuration!;
    if (fakeEnrolledStudent != null) data['fake_enrolled_students'] = fakeEnrolledStudent!;
    if (totalClasses != null) data['total_classes'] = totalClasses!;
    if (totalNotes != null) data['total_notes'] = totalNotes!;
    if (totalExams != null) data['total_exams'] = totalExams!;
    if (videoType != null) data['video_type'] = videoType!;
    if (videoUrl != null) data['video_url'] = videoUrl!;
    if (sMethod != null) data['_method'] = sMethod!;

    return data;
  }

}
