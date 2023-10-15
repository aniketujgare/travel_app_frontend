import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/src/presentation/blocs/destination_bloc/destinations_bloc.dart';
import 'package:travel_app/src/presentation/blocs/wishlist_bloc/wishlist_bloc.dart';

import '../../config/router/app_router_constants.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoaded) {
                var destinations = state.wishlistModel.destinations;
                return Expanded(
                  child: GridView.builder(
                    itemCount: destinations.length,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      var place = destinations[index];
                      return GestureDetector(
                        onTap: () {
                          var desModel =
                              context.read<DestinationsBloc>().destinations;
                          final desiredModel = desModel!
                              .firstWhere((element) => element.id == place.id);
                          // print(desModel!.first.shortDescription);
                          context.pushNamed(
                              AppRoutConstants.destinationDetails.name,
                              extra: desiredModel);
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
                                place.name,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Image.network(
                                place.images.first,
                                fit: BoxFit.cover,
                                width: 150,
                              ),
                              const SizedBox(height: 7),
                              Text(
                                place.shortDescription,
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
                  ),
                );
              }
              return Center(
                  child: Image.network(
                'https://2.bp.blogspot.com/-QfSOClZc8r0/XNr6srFlzjI/AAAAAAAAGlA/lzs505eFFiEdyAytzKkMabdUTihKywcqwCLcBGAs/s1600/EXAM360%2B-%2BNo%2BWishlist.png',
              ));
            },
          ),
        ],
      )),
    );
  }
}
