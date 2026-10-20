import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/testimonial_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/testimonial/landing_page_testimonial_card.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/testimonial/testimonial_section_loading_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => TestimonialSectionState();
}

class TestimonialSectionState extends State<TestimonialSection> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  bool _isHover = false;

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

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeOver),
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,

              /// ✅ Hover detection here
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHover = true),
                onExit: (_) => setState(() => _isHover = false),

                child: CarouselSlider.builder(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    autoPlay: !_isHover, // ✅ pause on hover
                    enlargeCenterPage: false,
                    viewportFraction: getViewportFraction(context),
                    enableInfiniteScroll: true,
                    height: 300,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeOutCubic,
                  ),
                  itemCount: chunkedData.length,
                  itemBuilder: (context, index, _) {
                    final group = chunkedData[index];
                    return Column(
                      children: group.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: LandingTestimonialCard(item: item),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
