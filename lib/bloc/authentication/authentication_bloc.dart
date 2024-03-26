import 'package:bloc/bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitial()) {
    on<SignInWithEmail>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.signInWithEmail(event.user);
        emit(AuthenticationSuccess(userExist: true));
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<SignUpWithEmail>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.signUpWithEmail(event.user);
        if (supabaseUser != null) {
          await Future.delayed(const Duration(seconds: 1), await authenticationService.createTableEntry());
          emit(AuthenticationSuccess(userExist: false));
        }
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      authenticationService.logOut();
      emit(AuthenticationInitial());
    });

    on<GoogleLogin>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.signInWithGoogle();
        bool response = await authenticationService.getUser();
        print(response);
        if (response) {
          emit(AuthenticationSuccess(userExist: true));
        } else {
          if (supabaseSession != null) {
            await Future.delayed(const Duration(seconds: 1), await authenticationService.createTableEntry());
            emit(AuthenticationSuccess(userExist: false));
          }
        }
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<FacebookLogin>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.signInWithFacebook();
        bool response = await authenticationService.getUser();
        if (response) {
          emit(AuthenticationSuccess(userExist: true));
        } else {
          if (supabaseUser != null) {
            await Future.delayed(const Duration(seconds: 1), await authenticationService.createTableEntry());
          }
          emit(AuthenticationSuccess(userExist: false));
        }
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<TwitterLogin>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.signInWithTwitter();
        bool response = await authenticationService.getUser();
        if (response) {
          emit(AuthenticationSuccess(userExist: true));
        } else {
          if (supabaseUser != null) {
            await Future.delayed(const Duration(seconds: 1), await authenticationService.createTableEntry());
          }
          emit(AuthenticationSuccess(userExist: false));
        }
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(AuthenticationLoading());

      try {
        await authenticationService.deleteUser();
        emit(AuthenticationSuccess());
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });
  }

  AuthenticationService authenticationService;
}
