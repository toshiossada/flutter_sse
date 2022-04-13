import 'package:client/app/modules/home/data/datasources/item_datasource_interface.dart';
import 'package:client/app/modules/home/domain/usecases/get_item_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/item_repository.dart';
import 'domain/repositories/item_repository_interface.dart';
import 'infra/datasources/remote/item_datasource.dart';
import 'presentation/pages/home_controller.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/home_store.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeStore()),
        Bind.factory((i) => HomeController(
              getItemUsecase: i(),
              store: i(),
            )),
        Bind.factory<IItemRepository>((i) => ItemRepository(
              itemDatasource: i(),
            )),
        Bind.factory<IItemDatasource>((i) => ItemDatasource(
              sseAdapter: i(),
            )),
        Bind.factory<IGetItemUsecase>((i) => GetItemUsecase(
              itemRepository: i(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
      ];
}
