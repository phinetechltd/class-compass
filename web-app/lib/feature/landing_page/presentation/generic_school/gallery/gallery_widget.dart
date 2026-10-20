
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/feature/landing_page/domain/models/gallery_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/gallery/gallery_image_title.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(initState: (val) {
          if(Get.find<LandingPageController>().galleryModel == null) {
            Get.find<LandingPageController>().getGalleryData();
          }
        },

        builder: (galleryController) {
          GalleryModel ? galleryModel = galleryController.galleryModel;

          return (galleryModel != null && galleryModel.data != null )?
          (galleryModel.data?.academicImages != null && galleryModel.data!.academicImages!.isNotEmpty)?
          Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(mainAxisSize: MainAxisSize.min, children: [

                  LandingSectionHeader(subtitle: "gallery".tr, title: "explore_life".tr),

                    MasonryGridView.count(
                      itemCount: galleryModel.data?.academicImages?.length?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: MediaQuery.sizeOf(context).width >= 1000 ? 4 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        final imageUrl = "${AppConstants.baseUrl}/storage/academic_images/"
                            "${galleryModel.data?.academicImages?[index].image}";
                        return GalleryImageTile(imageUrl: imageUrl, index: index,
                          images: galleryModel.data!.academicImages!.map((e) =>
                          "${AppConstants.baseUrl}/storage/academic_images/${e.image}").toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ): const Center(child: NoDataFound()): const Center(child: CircularProgressIndicator());
        }
    );
  }
}

