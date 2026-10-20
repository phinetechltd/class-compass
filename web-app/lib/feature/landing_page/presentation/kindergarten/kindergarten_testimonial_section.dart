import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/testimonial_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/testimonial/landing_page_testimonial_card.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/testimonial/testimonial_section_loading_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class KindergartenTestimonialSection extends StatefulWidget {
  const KindergartenTestimonialSection({super.key});

  @override
  State<KindergartenTestimonialSection> createState() =>
      _KindergartenTestimonialSectionState();
}

class _KindergartenTestimonialSectionState extends State<KindergartenTestimonialSection> {

  double getViewportFraction(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return 0.25;
    } else if (width >= 900) {
      return 0.33;
    } else if (width >= 600) {
      return 0.5;
    } else {
      return 0.9;
    }
  }

  List<List<TestimonialItem>> chunkList(List<TestimonialItem> list, int chunkSize) {
    List<List<TestimonialItem>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val) {
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.testimonialModel == null) {
          landingPageController.getTestimonialData();
        }
      },
      builder: (landingPageController) {
        TestimonialModel? testimonialModel = landingPageController.testimonialModel;

        if (testimonialModel == null) {
          return const TestimonialSectionLoadingWidget();
        }

        final data = testimonialModel.data ?? [];
        final chunkedData = chunkList(data, 2);

        return Container(width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeOver),
          child: Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: CarouselSlider.builder(
                options: CarouselOptions(autoPlay: true,
                  enlargeCenterPage: false,
                    viewportFraction: getViewportFraction(context),
                  enableInfiniteScroll: true,
                  height: 300),
                itemCount: chunkedData.length,
                itemBuilder: (context, index, _) {
                  final group = chunkedData[index];
                  return Column(children: group.map((item) {
                      return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: LandingTestimonialCard(item: item));
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

