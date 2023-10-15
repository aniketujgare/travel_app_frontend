import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/src/data/repositories/auth_repository.dart';
import 'package:travel_app/src/domain/models/destination_model.dart';
import 'package:travel_app/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:travel_app/src/presentation/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:travel_app/src/presentation/view/destination_details_view.dart';
import 'package:travel_app/src/presentation/view/wishlist_screen.dart';

import '../../presentation/blocs/destination_bloc/destinations_bloc.dart';
import '../../presentation/view/home_view.dart';
import 'app_router_constants.dart';

final authRepository = AuthRepository();
final authBloc = AuthBloc(authRepository: authRepository)
  ..add(AuthInitializeEvent());
final destinationBloc = DestinationsBloc()..add(GetDestinationsEvent());
final wishlistBloc = WishlistBloc();

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: AppRoutConstants.home.name,
        path: AppRoutConstants.home.path,
        pageBuilder: (context, state) => MaterialPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: destinationBloc,
              ),
              BlocProvider.value(
                value: authBloc,
              ),
              BlocProvider.value(
                value: wishlistBloc,
              ),
            ],
            child: const DestinationView(),
          ),
        ),
      ),
      GoRoute(
          name: AppRoutConstants.destinationDetails.name,
          path: AppRoutConstants.destinationDetails.path,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: authBloc,
                  ),
                  BlocProvider.value(
                    value: wishlistBloc,
                  ),
                ],
                child: DestinationDetailsView(
                    destination: state.extra as DestinationModel),
              ),
            );
          }),
      GoRoute(
          name: AppRoutConstants.wishlistView.name,
          path: AppRoutConstants.wishlistView.path,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: authBloc,
                  ),
                  BlocProvider.value(
                    value: wishlistBloc,
                  ),
                  BlocProvider.value(
                    value: destinationBloc,
                  ),
                ],
                child: const WishlistView(),
              ),
            );
          }),
    ],
  );
}
