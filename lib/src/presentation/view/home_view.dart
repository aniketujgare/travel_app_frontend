import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/app_router_constants.dart';
import '../../domain/models/destination_model.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/destination_bloc/destinations_bloc.dart';
import '../blocs/wishlist_bloc/wishlist_bloc.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/destination_tile.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoggedInState) {
            context
                .read<WishlistBloc>()
                .add(LoadWishList(userId: state.userModel.userId));
          } else {
            debugPrint('unauth');
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xfff7f8f9),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: CustomAppBar(
                  title: 'Popular Places',
                  action: () =>
                      context.pushNamed(AppRoutConstants.wishlistView.name))),
          body: BlocBuilder<DestinationsBloc, DestinationsState>(
            builder: (context, state) {
              if (state is DestinationsLoaded) {
                return GridView.builder(
                  itemCount: state.destinationList.length,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: width / height * 1.5),
                  itemBuilder: (context, index) {
                    var destination = state.destinationList[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                            AppRoutConstants.destinationDetails.name,
                            extra: destination);
                      },
                      child: DestinationTile(
                        destination: destination,
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

class DestinationOld extends StatelessWidget {
  const DestinationOld({
    super.key,
    required this.destination,
  });

  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Colors.deepPurpleAccent),
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
    );
  }
}
