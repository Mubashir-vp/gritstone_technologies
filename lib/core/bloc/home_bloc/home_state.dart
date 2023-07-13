part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeFailed extends HomeState {
  final String errorMessage;
  const HomeFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class DataLoaded extends HomeState {
  final List<LocalProduct> products;

  const DataLoaded({
    required this.products,
  });
  @override
  List<Object> get props => [
        products,
      ];
}
