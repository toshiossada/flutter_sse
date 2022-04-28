import 'package:client/app/modules/home/presentation/pages/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../viewmodel/item_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<ItemVieModel>(
          valueListenable: controller.store,
          builder: (context, value, _) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: value.loading ? null : controller.load,
                  child: const Text('CARREGAR'),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: value.loading,
                  child: const CircularProgressIndicator(),
                ),
                Expanded(
                  child: value.item.isEmpty
                      ? Container()
                      : ListView.builder(
                          itemCount: value.item.length,
                          itemBuilder: (_, index) {
                            final item = value.item[index];
                            return ListTile(
                              title: Text('Item ${item.message}'),
                            );
                          },
                        ),
                ),
              ],
            );
          }),
    );
  }
}
