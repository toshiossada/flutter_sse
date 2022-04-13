import 'package:client/app/modules/home/domain/entities/item_entity.dart';

abstract class IItemRepository {
  Stream<ItemEntity> get();
}
