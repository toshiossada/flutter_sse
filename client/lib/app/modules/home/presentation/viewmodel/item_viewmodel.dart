import 'package:client/app/modules/home/domain/entities/item_entity.dart';

class ItemVieModel {
  final List<ItemEntity> item;
  final bool finished;
  final bool loading;

  ItemVieModel({
    this.item = const [],
    this.finished = false,
    this.loading = false,
  });

  ItemVieModel copyWith({
    List<ItemEntity>? item,
    bool? finished,
    bool? loading,
  }) {
    return ItemVieModel(
      item: item ?? this.item,
      finished: finished ?? this.finished,
      loading: loading ?? this.loading,
    );
  }
}
