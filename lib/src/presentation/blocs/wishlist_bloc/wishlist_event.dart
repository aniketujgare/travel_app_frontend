part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class LoadWishList extends WishlistEvent {
  final String userId;

  const LoadWishList({required this.userId});
  @override
  List<Object> get props => [userId];
}

final class AddToWishlistEvent extends WishlistEvent {
  final String destinationId;
  final String userId;

  const AddToWishlistEvent({required this.userId, required this.destinationId});
  @override
  List<Object> get props => [destinationId, userId];
}

final class RemoveFromWishlistEvent extends WishlistEvent {
  final String destinationId;
  final String userId;

  const RemoveFromWishlistEvent(
      {required this.userId, required this.destinationId});
  @override
  List<Object> get props => [destinationId, userId];
}
