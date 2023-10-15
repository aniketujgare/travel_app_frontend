part of 'destinations_bloc.dart';

sealed class DestinationsState extends Equatable {
  const DestinationsState();

  @override
  List<Object> get props => [];
}

final class DestinationsInitial extends DestinationsState {}

final class DestinationsLoading extends DestinationsState {}

final class DestinationsLoaded extends DestinationsState {
  final List<DestinationModel> destinationList;

  const DestinationsLoaded({required this.destinationList});
}
