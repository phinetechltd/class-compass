
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/abroad_letter_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/attendence_certificate_widgt.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/bonafide_certificate_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/certificate_and_letter_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/character_certificate_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/hsc_recommendation_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/migration_certification_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/recommendation_letter_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/study_certificate_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/testimonial_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/widgets/transfer_certificate_widget.dart';

class LayoutAndCertificateScreen extends StatefulWidget {
  final CertificateTypeEnum type;
  const LayoutAndCertificateScreen({super.key, required this.type});

  @override
  State<LayoutAndCertificateScreen> createState() => _LayoutAndCertificateScreenState();
}

class _LayoutAndCertificateScreenState extends State<LayoutAndCertificateScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "certificate".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: GetBuilder<LayoutAndCertificateController>(
          builder: (controller) {
            return Column(children: [
                GeneralRecommendationLetter(type: widget.type,),
                if(controller.layoutAndCertificateModel != null)
                  if(widget.type == CertificateTypeEnum.recommendation)...[
                    const RecommendationLetterPreviewPage(),
                  ]else if(widget.type == CertificateTypeEnum.testimonial)...[
                    const TestimonialWidget(),
                  ]else if(widget.type == CertificateTypeEnum.attendanceCertificate)...[
                    const AttendanceCertificateWidget(),
                  ]else if(widget.type == CertificateTypeEnum.hscRecommendationLetter)...[
                    const HscRecommendationLetterWidget()
                  ]else if(widget.type == CertificateTypeEnum.abroadLetter)...[
                    const AbroadLetterWidget()
                  ]else if(widget.type == CertificateTypeEnum.transferCertificate)...[
                    const TransferCertificateView()
                  ]else if(widget.type == CertificateTypeEnum.characterCertificate)...[
                    const CharacterCertificateView()
                  ]else if(widget.type == CertificateTypeEnum.studyCertificate)...[
                    const StudyCertificatePreviewWidget()
                  ]else if(widget.type == CertificateTypeEnum.bonafideCertificate)...[
                    const BonafideCertificateWidget()
                  ]else if(widget.type == CertificateTypeEnum.migrationCertificate)...[
                    const MigrationCertificateWidget()]
              ],
            );
          }
        ))
      ],),
    );
  }
}



