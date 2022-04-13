import 'package:client/app/modules/home/domain/entities/item_entity.dart';

import '../../domain/repositories/item_repository_interface.dart';
import '../datasources/item_datasource_interface.dart';

class ItemRepository implements IItemRepository {
  final IItemDatasource _itemDatasource;

  ItemRepository({
    required IItemDatasource itemDatasource,
  }) : _itemDatasource = itemDatasource;

  @override
  Stream<ItemEntity> get() async* {
    var resultItems = _itemDatasource.get();
    final result = resultItems.asyncMap((data) {
      //Fazer Map do Model para Entity
      var result = ItemEntity(
        id: data.id,
        message: data.message,
        finished: data.finished,
      );

      return result;
    });

    yield* result;
  }
}
