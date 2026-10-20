
import 'package:class_compass/localization/domain/model/language_model.dart';
import 'package:class_compass/util/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
