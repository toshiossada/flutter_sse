import '../../domain/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required int id,
    required String message,
    required bool finished,
  }) : super(
          id: id,
          message: message,
          finished: finished,
        );

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      message: json['message'],
      finished: json['finished'],
    );
  }
}
