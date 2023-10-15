import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/src/config/router/app_router_constants.dart';
import 'package:travel_app/src/data/datasources/api.dart';
import 'package:travel_app/src/data/repositories/auth_repository.dart';
import 'package:travel_app/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/src/presentation/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:travel_app/src/utils/constants/constants.dart';

import '../blocs/destination_bloc/destinations_bloc.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({super.key});

  @override
  Widget build(BuildContext context) {
    // getUser()async{
    //   return AuthRepository().checkAuthState();
    // }

    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoggedInState) {
            // print(state.userModel.userId);
            // kShowSnackBar(context, 'loggedin');
            context
                .read<WishlistBloc>()
                .add(LoadWishList(userId: state.userModel.userId));
          } else {
            print('unauth');
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: const Text('Travel Destinations'),
            actions: [
              IconButton(
                  onPressed: () =>
                      context.pushNamed(AppRoutConstants.wishlistView.name),
                  icon: Icon(Icons.book))
            ],
          ),
          body: BlocBuilder<DestinationsBloc, DestinationsState>(
            builder: (context, state) {
              if (state is DestinationsLoaded) {
                return GridView.builder(
                  itemCount: state.destinationList.length,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    var destination = state.destinationList[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                            AppRoutConstants.destinationDetails.name,
                            extra: destination);
                      },
                      child: Container(
                        // height: 300,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 1, color: Colors.deepPurpleAccent),
                        ),
                        child: Column(
                          children: [
                            Text(
                              destination.name,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Image.network(
                              destination.images.first,
                              fit: BoxFit.cover,
                              width: 150,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              destination.shortDescription,
                              maxLines: 2,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
