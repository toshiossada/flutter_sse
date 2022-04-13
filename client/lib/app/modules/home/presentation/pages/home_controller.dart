import 'dart:async';

import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/get_item_usecase.dart';
import 'home_store.dart';

class HomeController {
  final IGetItemUsecase _getItemUsecase;
  final HomeStore store;

  HomeController({
    required IGetItemUsecase getItemUsecase,
    required this.store,
  }) : _getItemUsecase = getItemUsecase;

  load() {
    late StreamSubscription<ItemEntity> _streamSubscription;
    store.setLoading(true);
    store.clear();

    _streamSubscription = _getItemUsecase().listen((event) {
      if (event.finished) {
        _streamSubscription.cancel();
        store.finish();
        store.setLoading(false);
      }
      store.add(event);
    })
      ..onError((error) {
        _streamSubscription.cancel();
        //Set Error State
        store.setLoading(false);
      });
  }
}
