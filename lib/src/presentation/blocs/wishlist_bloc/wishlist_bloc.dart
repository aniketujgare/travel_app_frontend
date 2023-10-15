import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/src/data/datasources/api.dart';
import 'package:travel_app/src/data/repositories/auth_repository.dart';
import 'package:travel_app/src/domain/models/wishlist_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistModel? wishlist;
  WishlistBloc() : super(WishlistInitial()) {
    on<LoadWishList>((event, emit) async {
      emit(WishlistLoading());
      try {
        var wl = await ApiService().getWishlistOfUser(event.userId);
        if (wl == null) {
          debugPrint('User doesn\t have wishlist created');
        } else {
          debugPrint('User have wishlist created');
          wishlist = wl;
          emit(WishlistLoaded(wishlistModel: wl));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<AddToWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      try {
        wishlist = await ApiService().getWishlistOfUser(event.userId);
        if (wishlist == null) {
          debugPrint('User doesn\t have wishlist created');
          await ApiService().addDestinationToWishlist(
              userId: event.userId, destinationId: event.destinationId);
        } else {
          await ApiService().addDestinationToWishlist(
              userId: event.userId, destinationId: event.destinationId);
          // wishlist = await ApiService().getWishlistOfUser(event.userId);
          // emit(WishlistLoaded(wishlistModel: wishlist!));
        }
        add(LoadWishList(userId: event.userId));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<RemoveFromWishlistEvent>((event, emit) async {
      try {
        emit(WishlistLoading());
        var result = await ApiService().removeDestinationFromWishlist(
            userId: event.userId, destinationId: event.destinationId);
        if (result) {
          print('destination removed from wishlist');
          wishlist!.destinations
              .removeWhere((element) => element.id == event.destinationId);
          emit(WishlistLoaded(wishlistModel: wishlist!));
        } else {
          print('Error in deleting the destination');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
