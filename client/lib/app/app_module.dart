import 'package:client/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';


import '../commons/adapter/sse/implementations/eventsource_sse_adapter_impl.dart';
import '../commons/adapter/sse/implementations/mock_sse_adapter_impl.dart';
import '../commons/adapter/sse/sse_adapter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<SseAdapter>((i) => MockSseAdapterImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
      ];
}
