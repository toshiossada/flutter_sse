import 'package:client/app/modules/home/domain/entities/item_entity.dart';
import 'package:client/app/modules/home/domain/repositories/item_repository_interface.dart';

abstract class IGetItemUsecase {
  Stream<ItemEntity> call();
}

class GetItemUsecase implements IGetItemUsecase {
  final IItemRepository _itemRepository;

  GetItemUsecase({required IItemRepository itemRepository})
      : _itemRepository = itemRepository;

  @override
  Stream<ItemEntity> call() async* {
    yield* _itemRepository.get();
  }
}
