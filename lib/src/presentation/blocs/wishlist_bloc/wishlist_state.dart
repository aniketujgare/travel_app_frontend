part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final WishlistModel wishlistModel;

  const WishlistLoaded({required this.wishlistModel});
  @override
  List<Object> get props => [wishlistModel];
}
