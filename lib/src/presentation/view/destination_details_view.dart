import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/data/datasources/api.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/models/destination_model.dart';
import '../../domain/models/wishlist_model.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/wishlist_bloc/wishlist_bloc.dart';
import '../widgets/custom_detail_appbar.dart';

class DestinationDetailsView extends StatelessWidget {
  final DestinationModel destination;
  const DestinationDetailsView({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    bool isbookmarked(List<Destination> destinations) {
      return destinations.any((element) => element.id == destination.id);
    }

    return SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is LoggedInState) {
          print('auth logged in');
          context.read<WishlistBloc>().add(AddToWishlistEvent(
              userId: authState.userModel.userId,
              destinationId: destination.id));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const CircularProgressIndicator();
            }
            if (state is WishlistLoaded) {
              return FloatingActionButton(
                onPressed: () async {
                  if (state is WishlistInitial) {
                    await _showAlertDialog(context);
                  }
                  // ignore: use_build_context_synchronously
                  var currAuthState = context.read<AuthBloc>().state;
                  if (isbookmarked(state.wishlistModel.destinations)) {
                    //remove from list
                    if (currAuthState is LoggedInState) {
                      // ignore: use_build_context_synchronously
                      context.read<WishlistBloc>().add(RemoveFromWishlistEvent(
                          userId: currAuthState.userModel.userId,
                          destinationId: destination.id));
                    }
                  } else {
                    //add in list
                    if (currAuthState is LoggedInState) {
                      // ignore: use_build_context_synchronously
                      context.read<WishlistBloc>().add(AddToWishlistEvent(
                          userId: currAuthState.userModel.userId,
                          destinationId: destination.id));
                    }
                  }
                },
                child: isbookmarked(state.wishlistModel.destinations)
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline),
              );
            }
            debugPrint(state.runtimeType.toString());
            return FloatingActionButton(
              onPressed: () async {
                await _showAlertDialog(context);
              },
              child: const Icon(Icons.bookmark_outline),
            );
          },
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: NetworkImage(destination.images.first),
              fit: BoxFit.cover,
            ),
          ),
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomDetailAppBar(
            title: 'Details Page',
          ),
        ),
        bottomSheet: Container(
          height: MediaQuery.of(context).size.height / 1.7,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const BoxDecoration(
            color: Color(0xffedf2f6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          destination.name,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              '4.7',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Text(
                      destination.shortDescription,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 125,
                      child: ListView.builder(
                        itemCount: destination.images.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              destination.images[index],
                              fit: BoxFit.cover,
                              width: 120,
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Key Attractions:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ListView.separated(
                  itemCount: destination.keyAttractions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Text(
                      destination.keyAttractions[index],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  AuthRepository().getStorage();
                  // debugPrint(v!.email);
                },
                child: const Text('check auth'),
              ),
              TextButton(
                onPressed: () async {
                  var v = await ApiService()
                      .logInUser(email: 'test@mail.com', password: 'test');
                  debugPrint(v.toString());
                },
                child: const Text('check auth'),
              ),
            ],
          ),
        ),
      ),
    )

        //  BlocListener<AuthBloc, AuthState>(
        //   listener: (context, authState) {
        //     if (authState is LoggedInState) {
        //       debugPrint('loged in and adding');
        //       context.read<WishlistBloc>().add(AddToWishlistEvent(
        //           userId: authState.userModel.userId,
        //           destinationId: destination.id));
        //     }
        //   },
        //   child: Scaffold(
        //     floatingActionButton: BlocBuilder<WishlistBloc, WishlistState>(
        //       builder: (context, state) {
        //         if (state is WishlistLoading) {
        //           return const CircularProgressIndicator();
        //         }
        //         if (state is WishlistLoaded) {
        //           return FloatingActionButton(
        //             onPressed: () async {
        //               if (state is WishlistInitial) {
        //                 await _showAlertDialog(context);
        //               }
        //               // ignore: use_build_context_synchronously
        //               var currAuthState = context.read<AuthBloc>().state;
        //               if (isbookmarked(state.wishlistModel.destinations)) {
        //                 //remove from list
        //                 if (currAuthState is LoggedInState) {
        //                   // ignore: use_build_context_synchronously
        //                   context.read<WishlistBloc>().add(
        //                       RemoveFromWishlistEvent(
        //                           userId: currAuthState.userModel.userId,
        //                           destinationId: destination.id));
        //                 }
        //               } else {
        //                 //add in list
        //                 if (currAuthState is LoggedInState) {
        //                   // ignore: use_build_context_synchronously
        //                   context.read<WishlistBloc>().add(AddToWishlistEvent(
        //                       userId: currAuthState.userModel.userId,
        //                       destinationId: destination.id));
        //                 }
        //               }
        //             },
        //             child: isbookmarked(state.wishlistModel.destinations)
        //                 ? const Icon(Icons.bookmark)
        //                 : const Icon(Icons.bookmark_outline),
        //           );
        //         }
        //         debugPrint(state.runtimeType);
        //         return FloatingActionButton(
        //           onPressed: () async {
        //             await _showAlertDialog(context);
        //           },
        //           child: const Icon(Icons.bookmark_outline),
        //         );
        //       },
        //     ),
        //     appBar: AppBar(
        //       title: const Text('Destinations Details'),
        //     ),
        //     body: Column(
        //       children: [
        //         const SizedBox(height: 25),
        //         Text(
        //           destination.name,
        //           style: const TextStyle(fontSize: 28),
        //         ),
        //         Image.network(
        //           destination.images.first,
        //           fit: BoxFit.cover,
        //           width: 150,
        //         ),
        //         const SizedBox(height: 7),
        //         Text(
        //           destination.shortDescription,
        //           // maxLines: 2,
        //           style: const TextStyle(
        //               // overflow: TextOverflow.ellipsis,
        //               ),
        //         ),
        //         TextButton(
        //             onPressed: () {
        //               AuthRepository().getStorage();
        //               // debugPrint(v!.email);
        //             },
        //             child: const Text('check auth'))
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

Future<void> _showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext newcontext) {
      return AlertDialog(
        // <-- SEE HERE
        title: const Text('You are not LoggedIn'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Login to bookmark the location'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Register'),
            onPressed: () async {
              await _showRegisterAlertDialog(context);
              // ignore: use_build_context_synchronously
              Navigator.of(newcontext).pop();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(newcontext).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showRegisterAlertDialog(BuildContext context) async {
  String email = '';
  String password = '';
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext newcontext) {
      return AlertDialog(
        title: const Text("Sign Up"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              onChanged: (value) => password = value,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(newcontext).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle sign up here using emailController.text and passwordController.text
              // You can call the signup function here
              // Example: signUp(emailController.text, passwordController.text);
              // context.read<AuthBloc>().add(RegisterUserEvent(email, password));
              BlocProvider.of<AuthBloc>(context)
                  .add(RegisterUserEvent(email, password));
              Navigator.of(newcontext).pop(); // Close the dialog
            },
            child: const Text('Sign Up'),
          ),
        ],
      );
    },
  );
}
// // --- Button Widget --- //
// ElevatedButton(
//   onPressed: _showAlertDialog,
//   child: const Text(
//     'Show Alert Dialog',
//     style: TextStyle(fontSize: 24),
//   ),
// ),