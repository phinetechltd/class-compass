import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/landing_page/domain/models/about_us_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/banner_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/event_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/faq_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/gallery_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/mobile_app_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/policy_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/ready_to_join_us_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/teacher_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/testimonial_model.dart';
import 'package:class_compass/feature/landing_page/domain/models/why_choose_us_model.dart';
import 'package:class_compass/feature/landing_page/domain/repositories/landing_page_repository.dart';
import 'package:class_compass/feature/landing_page/presentation/enums.dart';
import 'package:class_compass/feature/landing_page/presentation/policy_enum.dart';

class LandingPageController extends GetxController implements GetxService {
  final LandingPageRepository landingPageRepository;
  LandingPageController({required this.landingPageRepository});
  List<String> menuList = ["Home", "About", "Admissions", "Academics", "Events", "Contact"];

  @override
  onInit() {
    getInstituteType();
    super.onInit();
  }

  BannerModel? bannerModel;
  Future<void> getBannerData() async {
    Response response = await landingPageRepository.getLandingPageData();
    if (response.statusCode == 200) {
      bannerModel = BannerModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  AboutUsModel? aboutUsModel;
  Future<void> getAboutData() async {
    Response response = await landingPageRepository.getAboutPageData();
    if (response.statusCode == 200) {
      aboutUsModel = AboutUsModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  WhyChooseUsModel? whyChooseUsModel;
  Future<void> getWhyChooseUsData() async {
    Response response = await landingPageRepository.getWhyChooseUSData();
    if (response.statusCode == 200) {
      whyChooseUsModel = WhyChooseUsModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  ReadyToJoinUsModel? admissionModel;
  Future<void> getAdmissionData() async {
    Response response = await landingPageRepository.getAdmissionPageData();
    if (response.statusCode == 200) {
      admissionModel = ReadyToJoinUsModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  TeacherModel? teacherModel;
  Future<void> getTeachersData() async {
    Response response = await landingPageRepository.getTeachersPageData();
    if (response.statusCode == 200) {
      teacherModel = TeacherModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  TestimonialModel? testimonialModel;
  Future<void> getTestimonialData() async {
    Response response = await landingPageRepository.getTestimonialPageData();
    if (response.statusCode == 200) {
      testimonialModel = TestimonialModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  MobileAppModel? mobileAppModel;
  Future<void> getMobileAppData() async {
    Response response = await landingPageRepository.getMobileAppPageData();
    if (response.statusCode == 200) {
      mobileAppModel = MobileAppModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  EventFrontEndModel? eventModel;
  Future<void> getEventInfoData() async {
    Response response = await landingPageRepository.getEventInfoPageData();
    if (response.statusCode == 200) {
      eventModel = EventFrontEndModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  FaqModel? faqModel;
  Future<void> getFaqData() async {
    Response response = await landingPageRepository.getFaqData();
    if (response.statusCode == 200) {
      faqModel = FaqModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }
  bool isLoading = false;
  Future<void> newsLetter(String email) async {
    isLoading = true;
    update();
    Response response = await landingPageRepository.newsLetter(email);
    if (response.statusCode == 200) {
      showCustomSnackBar("subscribed_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }


  PolicyModel? privacyPolicyModel;
  PolicyModel? termsPolicyModel;
  PolicyModel? cookiePolicyModel;

  Future<void> getPolicy(PolicyEnum type) async {
    Response response;
    if(type == PolicyEnum.privacyPolicy){
      response = await landingPageRepository.privacyPolicy();
    }else if(type == PolicyEnum.termsOfService){
      response = await landingPageRepository.termsAndCondition();
    }else{
      response = await landingPageRepository.cookiePolicy();
    }
    if (response.statusCode == 200) {
      if(type == PolicyEnum.privacyPolicy){
        privacyPolicyModel = PolicyModel.fromJson(response.body);
      }else if(type == PolicyEnum.termsOfService){
        termsPolicyModel = PolicyModel.fromJson(response.body);
      }else{
        cookiePolicyModel = PolicyModel.fromJson(response.body);
      }
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  InstituteEnum selected = InstituteEnum.genericSchool;
  void setInstitute(InstituteEnum institute){
    selected = institute;
    landingPageRepository.setInstituteType(institute.toString());
    update();
  }

  getInstituteType(){
    String type = landingPageRepository.getInstituteType();
    if(type == InstituteEnum.kindergarten.toString()){
      selected = InstituteEnum.kindergarten;
    }else{
      selected = InstituteEnum.genericSchool;
    }
    update();
  }


  final List<GlobalKey> sectionKeys = [
    GlobalKey(), // Banner
    GlobalKey(), // About Us
    GlobalKey(), // Why Choose Us
    GlobalKey(), // Course
    GlobalKey(), // Signature Creation
    GlobalKey(), // Main Menu
    GlobalKey(), // Chef
    GlobalKey(), // Table Reservation
    GlobalKey(), // Testimonial
    GlobalKey(), // Visit Us
    GlobalKey(), // Newsletter
    GlobalKey(), // Newsletter
  ];

  Future<void> scrollToSection(int index) async {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }


  GalleryModel? galleryModel;
  Future<void> getGalleryData() async {
    Response response = await landingPageRepository.getLandingPageGallery();
    if (response.statusCode == 200) {
      galleryModel = GalleryModel.fromJson(response.body);
    }else{
      //ApiChecker.checkApi(response);
    }
    update();
  }


}
