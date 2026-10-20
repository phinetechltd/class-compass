

import 'package:class_compass/helper/price_converter.dart';

class QuestionBankBoardItem {
  int? id;
  String? board;
  String? shortName;
  int? status;
  bool? isSelected;

  QuestionBankBoardItem(
      {this.id,
        this.board,
        this.shortName,
        this.status,
        this.isSelected
      });

  QuestionBankBoardItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    board = json['board'];
    shortName = json['short_name'];
    status = PriceConverter.parseInt(json['status']);
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['board'] = board;
    data['short_name'] = shortName;
    data['status'] = status;
    data['isSelected'] = isSelected;
    return data;
  }
}

