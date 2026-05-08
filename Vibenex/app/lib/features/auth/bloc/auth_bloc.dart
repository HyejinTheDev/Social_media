import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/error_mapper.dart';
import '../domain/models/auth_models.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthForgotPasswordRequested>(_onForgotPassword);
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.tryAutoLogin();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.login(
        LoginRequest(email: event.email, password: event.password),
      );
      emit(AuthAuthenticated(user: response.user));
    } catch (e) {
      emit(AuthError(message: ErrorMapper.map(e)));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.register(
        RegisterRequest(
          name: event.name,
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );
      emit(AuthAuthenticated(user: response.user));
    } catch (e) {
      emit(AuthError(message: ErrorMapper.map(e)));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onForgotPassword(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.forgotPassword(event.email);
      emit(AuthForgotPasswordSent());
    } catch (e) {
      emit(AuthError(message: ErrorMapper.map(e)));
    }
  }
}
