import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/add_new_button_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_search.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/common/widget/paginated_list_widget.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_bank_left_filter_menu.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/question_item_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/select_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/widgets/select_question_bank_subject_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/logic/question_bank_tag_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/widgets/select_question_bank_topic_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:responsive_grid/responsive_grid.dart';



class QuestionListWidget extends StatefulWidget {
  final ScrollController scrollController;
  final bool fromQuiz;
  const QuestionListWidget({super.key, required this.scrollController, required this.fromQuiz});

  @override
  State<QuestionListWidget> createState() => _QuestionListWidgetState();
}

class _QuestionListWidgetState extends State<QuestionListWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    if(Get.find<QuestionBankTypesController>().questionBankTypesModel == null) {
      Get.find<QuestionBankTypesController>().getQuestionBankTypes(1);}
    if(Get.find<QuestionBankLevelController>().questionBankLevelModel == null){
      Get.find<QuestionBankLevelController>().getQuestionBankLevel(1);
    }
    if(Get.find<QuestionBankTagController>().questionBankTagModel == null){
      Get.find<QuestionBankTagController>().getQuestionBankTag(1);
    }
    if(Get.find<QuestionBankSourcesController>().questionBankSourcesModel == null){
      Get.find<QuestionBankSourcesController>().getQuestionBankSources(1);
    }
    if(Get.find<QuestionBankSubSourcesController>().questionBankSubSourceModel == null){
      Get.find<QuestionBankSubSourcesController>().getQuestionBankSubSources(1);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      initState: (val) {
        if(Get.find<QuestionController>().questionModel == null){
          Get.find<QuestionController>().getQuestion(1);
        }
      },
        builder: (questionController)  {
          QuestionModel? questionModel = questionController.questionModel;
          var question = questionModel?.data;
          return Stack(
            children: [
              Column(children: [
                if(ResponsiveHelper.isDesktop(context))
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: CustomRoutePathWidget(title: "question_bank".tr,
                      subWidget: Row(children: [
                    PathItemWidget(title: "question_list".tr,color: Theme.of(context).secondaryHeaderColor),
                    AddNewButtonWidget(title: "add_new_question".tr,onTap: (){
                      Get.toNamed(RouteHelper.getAddNewQuestionRoute());
                    })

                  ])),
                ),

                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: CustomContainer(showShadow: false, borderRadius: 5,
                      child: Column(children: [

                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [

                              Expanded(
                                child: Column(children: [

                                  ResponsiveGridList(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      desiredItemWidth: 250,
                                      minSpacing: Dimensions.paddingSizeDefault,
                                      children: [
                                          const QuestionBankSelectSubjectWidget(filter: true),
                                          const QuestionBankSelectChapterWidget(filter: true),
                                          const QuestionBankSelectTopicWidget(filter: true),
                                        if(!ResponsiveHelper.isDesktop(context))
                                          const QuestionBankLeftFilterMenu(),
                                      ]
                                  ),
                                  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    child: QuestionBankLeftFilterMenu()),

                                  const SizedBox(height: Dimensions.paddingSizeSmall),



                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                                  CustomSearch(hintText: 'type_to_search'.tr, searchController: searchController,
                                      onSearch: (){
                                        questionController.questionFilter(search: searchController.text.trim());
                                      }),

                                  const SizedBox(height: Dimensions.paddingSizeDefault),


                                  questionModel != null? (questionModel.data != null && questionModel.data!.data!.isNotEmpty)?
                                  PaginatedListWidget(scrollController: widget.scrollController,
                                      onPaginate: (int? offset) async {
                                        await questionController.questionFilter(offset:offset??1);
                                      }, totalSize: question?.total??0,
                                      offset: question?.currentPage??0,
                                      itemView: ListView.builder(
                                          itemCount: question?.data?.length??0,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index){
                                            return QuestionItemWidget(index: index,
                                              fromQuiz: widget.fromQuiz,
                                              questionItem: question?.data?[index],);
                                          })):
                                  Padding(padding: ThemeShadow.getPadding(),
                                    child: const Center(child: NoDataFound()),
                                  ):
                                  Padding(padding:  ThemeShadow.getPadding(),
                                    child: const CircularProgressIndicator()),
                                ],),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ),
                ],
              ),
            ],
          );
        }
    );
  }
}
