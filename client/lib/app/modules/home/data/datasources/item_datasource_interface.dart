import 'package:client/app/modules/home/infra/models/item_modal.dart';

abstract class IItemDatasource {
  Stream<ItemModel> get();
}
