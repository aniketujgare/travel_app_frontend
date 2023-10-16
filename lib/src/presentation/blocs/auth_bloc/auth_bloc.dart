import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/src/data/datasources/api.dart';
import 'package:travel_app/src/data/repositories/auth_repository.dart';
import 'package:travel_app/src/domain/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthInitializeEvent>((event, emit) async {
      try {
        var user = await authRepository.checkAuthState();
        if (user != null) {
          emit(LoggedInState(userModel: user));
          debugPrint('auth');
        } else {
          emit(UnAuthenticatedState());
          debugPrint('unauth');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<RegisterUserEvent>((event, emit) async {
      try {
        // var isAuthenticated = await authRepository.registerUser();
        var isAuthenticated = await ApiService()
            .signupUser(email: event.email, password: event.password);
        if (isAuthenticated) {
          add(SignInUserEvent(email: event.email, password: event.password));
          debugPrint('auth');
        } else {
          emit(UnAuthenticatedState());
          debugPrint('unauth');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<SignInUserEvent>((event, emit) async {
      try {
        // var isAuthenticated = await authRepository.registerUser();
        var isAuthenticated = await ApiService()
            .logInUser(email: event.email, password: event.password);
        if (isAuthenticated) {
          add(AuthInitializeEvent());
          // emit(LoggedInState(userModel: null));
          debugPrint('auth');
        } else {
          emit(UnAuthenticatedState());
          debugPrint('unauth');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
