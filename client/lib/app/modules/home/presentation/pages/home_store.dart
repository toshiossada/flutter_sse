import 'package:client/app/modules/home/domain/entities/item_entity.dart';
import 'package:flutter/material.dart';

import '../viewmodel/item_viewmodel.dart';

class HomeStore extends ValueNotifier<ItemVieModel> {
  HomeStore() : super(ItemVieModel());

  void add(ItemEntity v) {
    var list = List<ItemEntity>.from(value.item);
    list.add(v);
    value = value.copyWith(item: list);
  }

  void clear() {
    value = value.copyWith(item: []);
  }

  void finish() {
    value = value.copyWith(finished: true);
  }

  void setLoading(bool v) {
    value = value.copyWith(loading: v);
  }
}
