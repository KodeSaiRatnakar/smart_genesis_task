import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/bloc/productevent.dart';
import 'package:practice_app/bloc/productstate.dart';

import '../apicall.dart';



class ProductBloc extends Bloc<LoadProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState()) {
    on<LoadEvent>((event, emit) async {
      emit(ProductLoadingState());

      try {
        final list = await ApiCall.getProductsFromApi();


        emit(ProductLoadedState(list: list));
      } catch (e) {
        emit(ProductErrorState());
      }
    });
  }
}
