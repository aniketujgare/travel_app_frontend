import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/src/presentation/widgets/custom_destination_card.dart';

import '../../config/router/app_router_constants.dart';
import '../blocs/destination_bloc/destinations_bloc.dart';
import '../blocs/wishlist_bloc/wishlist_bloc.dart';
import '../widgets/custom_detail_appbar.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomDetailAppBar(
            title: 'Your Wishlist',
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                if (state is WishlistLoaded) {
                  var destinations = state.wishlistModel.destinations;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        var place = destinations[index];
                        return GestureDetector(
                          onTap: () {
                            var desModel =
                                context.read<DestinationsBloc>().destinations;
                            final desiredModel = desModel!.firstWhere(
                              (element) => element.id == place.id,
                            );

                            context.pushNamed(
                              AppRoutConstants.destinationDetails.name,
                              extra: desiredModel,
                            );
                          },
                          child: CustomDestinationCard(
                            imageUrl: place.images.first,
                            name: place.name,
                            shortDescription: place.shortDescription,
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
      ),
    );
  }
}
