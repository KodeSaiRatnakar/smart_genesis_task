import 'package:equatable/equatable.dart';

import '../modelclass.dart';




abstract class LoadProductEvent extends Equatable {}


class LoadEvent extends LoadProductEvent{
  @override
  List<Product> get props =>[];
}
