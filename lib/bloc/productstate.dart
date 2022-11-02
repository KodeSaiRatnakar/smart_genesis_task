
import 'package:equatable/equatable.dart';

import '../modelclass.dart';

abstract class ProductState extends Equatable {}


class ProductLoadingState extends ProductState{
  @override
  List<Object?> get props =>[];
}


class ProductLoadedState extends ProductState{
  final List<Product> list;

  ProductLoadedState({required this.list});

  @override
  List<Product> get props => list;
}

class ProductErrorState extends ProductState{

  @override
  List<Object?> get props => [];

}