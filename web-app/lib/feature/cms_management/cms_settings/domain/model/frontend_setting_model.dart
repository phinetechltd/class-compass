class FrontendSettingModel {
  bool? status;
  String? message;
  Data? data;

  FrontendSettingModel({this.status, this.message, this.data});

  FrontendSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? schoolName;
  String? siteTitle;
  String? phone;
  String? email;
  String? language;
  String? googleMap;
  String? address;
  String? timezone;
  String? academicYear;
  String? currencySymbol;
  String? logo;
  String? copyrightText;
  String? facebookLink;
  String? googlePlusLink;
  String? youtubeLink;
  String? whatsAppLink;
  String? twitterLink;
  String? eiinCode;
  String? headerNotice;
  String? examResultStatus;
  String? admissionDisplayStatus;
  String? guidance;
  String? academicOffice;
  String? websiteLink;
  String? primaryColor;
  String? secondaryColor;
  String? primaryContainerColor;
  String? darkPrimaryColor;
  String? darkSecondaryColor;
  String? darkContainerColor;
  String? textColor;

  Data(
      {this.schoolName,
        this.siteTitle,
        this.phone,
        this.email,
        this.language,
        this.googleMap,
        this.address,
        this.timezone,
        this.academicYear,
        this.currencySymbol,
        this.logo,
        this.copyrightText,
        this.facebookLink,
        this.googlePlusLink,
        this.youtubeLink,
        this.whatsAppLink,
        this.twitterLink,
        this.eiinCode,
        this.headerNotice,
        this.examResultStatus,
        this.admissionDisplayStatus,
        this.guidance,
        this.academicOffice,
        this.websiteLink,
        this.primaryColor,
        this.secondaryColor,
        this.primaryContainerColor,
        this.darkPrimaryColor,
        this.darkSecondaryColor,
        this.darkContainerColor,
        this.textColor,
      });

  Data.fromJson(Map<String, dynamic> json) {
    schoolName = json['school_name'];
    siteTitle = json['site_title'];
    phone = json['phone'];
    email = json['email'];
    language = json['language'];
    googleMap = json['google_map'];
    address = json['address'];
    timezone = json['timezone'];
    academicYear = json['academic_year'];
    currencySymbol = json['currency_symbol'];
    logo = json['logo'];
    copyrightText = json['copyright_text'];
    facebookLink = json['facebook_link'];
    googlePlusLink = json['google_plus_link'];
    youtubeLink = json['youtube_link'];
    whatsAppLink = json['whats_app_link'];
    twitterLink = json['twitter_link'];
    eiinCode = json['eiin_code'];
    headerNotice = json['header_notice'];
    examResultStatus = json['exam_result_status'];
    admissionDisplayStatus = json['admission_display_status'];
    guidance = json['guidance'];
    academicOffice = json['academic_office'];
    websiteLink = json['website_link'];
    primaryColor = json['primary_color'];
    secondaryColor = json['secondary_color'];
    primaryContainerColor = json['primary_container_color'];
    darkPrimaryColor = json['dark_primary_color'];
    darkSecondaryColor = json['dark_secondary_color'];
    darkContainerColor = json['dark_container_color'];
    textColor = json['text_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['school_name'] = schoolName;
    data['site_title'] = siteTitle;
    data['phone'] = phone;
    data['email'] = email;
    data['language'] = language;
    data['google_map'] = googleMap;
    data['address'] = address;
    data['timezone'] = timezone;
    data['academic_year'] = academicYear;
    data['currency_symbol'] = currencySymbol;
    data['logo'] = logo;
    data['copyright_text'] = copyrightText;
    data['facebook_link'] = facebookLink;
    data['google_plus_link'] = googlePlusLink;
    data['youtube_link'] = youtubeLink;
    data['whats_app_link'] = whatsAppLink;
    data['twitter_link'] = twitterLink;
    data['eiin_code'] = eiinCode;
    data['header_notice'] = headerNotice;
    data['exam_result_status'] = examResultStatus;
    data['admission_display_status'] = admissionDisplayStatus;
    data['guidance'] = guidance;
    data['academic_office'] = academicOffice;
    data['website_link'] = websiteLink;
    data['primary_color'] = primaryColor;
    data['secondary_color'] = secondaryColor;
    data['primary_container_color'] = primaryContainerColor;
    data['dark_primary_color'] = darkPrimaryColor;
    data['dark_secondary_color'] = darkSecondaryColor;
    data['dark_container_color'] = darkContainerColor;
    data['text_color'] = textColor;
    return data;
  }
}
