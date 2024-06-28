import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:ui/models/data.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class DataCubit extends Cubit<DataState> {
  static DataCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<DataCubit>(context, listen: listen);

  DataCubit() : super(DataDefault());

  final repo = DataRepository();

  Future<void> fetch() async {
    emit(const DataFetchLoading());
    try {
      final data = await repo.fetch();

      emit(DataFetchSuccess(data: data));
    } catch (e) {
      emit(DataFetchFailed(message: e.toString()));
    }
  }
}
