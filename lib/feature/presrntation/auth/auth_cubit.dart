import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/domain/repositories/auth_rep.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(Loading());

  Future<void> signUp({required String email, required String password}) async {
    emit(Initial());
    try {
      emit(Loading());
      await authRepository.signUp(email, password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(Initial());
    try {
      emit(Loading());
      await authRepository.signIn(email, password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  Future<void> signOut() async {
    emit(Initial());
    await authRepository.signOut();
    emit(UnAuthenticated());
  }
}

abstract class AuthState extends Equatable {}

class Initial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

