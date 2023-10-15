import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/data/repositories/auth_repository.dart';
import 'package:travel_app/src/domain/models/destination_model.dart';
import 'package:travel_app/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/src/presentation/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:travel_app/src/utils/constants/constants.dart';

import '../../domain/models/wishlist_model.dart';

class DestinationDetailsView extends StatelessWidget {
  final DestinationModel destination;
  const DestinationDetailsView({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    // var authBloc = context.read<AuthBloc>();
    bool isbookmarked(List<Destination> destinations) {
      return destinations.any((element) => element.id == destination.id);
    }

    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is LoggedInState) {
            print('loged in and adding');
            context.read<WishlistBloc>().add(AddToWishlistEvent(
                userId: authState.userModel.userId,
                destinationId: destination.id));
          }
        },
        child: Scaffold(
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
                        context.read<WishlistBloc>().add(
                            RemoveFromWishlistEvent(
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
              print(state.runtimeType);
              return FloatingActionButton(
                onPressed: () async {
                  await _showAlertDialog(context);
                },
                child: const Icon(Icons.bookmark_outline),
              );
            },
          ),
          appBar: AppBar(
            title: const Text('Destinations Details'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 25),
              Text(
                destination.name,
                style: const TextStyle(fontSize: 28),
              ),
              Image.network(
                destination.images.first,
                fit: BoxFit.cover,
                width: 150,
              ),
              const SizedBox(height: 7),
              Text(
                destination.shortDescription,
                // maxLines: 2,
                style: const TextStyle(
                    // overflow: TextOverflow.ellipsis,
                    ),
              ),
              TextButton(
                  onPressed: () {
                    AuthRepository().getStorage();
                    // print(v!.email);
                  },
                  child: const Text('check auth'))
            ],
          ),
        ),
      ),
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
              Navigator.of(newcontext).pop();
            },
          ),
          TextButton(
            child: const Text('Login'),
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