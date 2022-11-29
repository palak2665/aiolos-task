import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/service.dart';
import '../model/responsemodel.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepo repo})
      : _repo = repo,
        super(LoginInitial()) {
    on<StatusChange>(_statusChange);
    on<LoginInit>(_loginInit);
    _repoSubscription = _repo.status.listen((status) {
      add(StatusChange(status));
    });
  }

  final LoginRepo _repo;
  late StreamSubscription _repoSubscription;

  _loginInit(LoginInit event, Emitter emit) {
    _repo.login(event.username, event.password);
  }

  _statusChange(StatusChange event, Emitter emit) {
    switch (event.status) {
      case LoginStatus.initial:
        log("LoginInitial");
        emit(LoginInitial());
        break;
      case LoginStatus.loading:
        log("LoginLoading");
        emit(LoginLoading());
        break;
      case LoginStatus.authenticated:
        log("LoginAuthenticated");
        emit(LoginAuthenticated(_repo.data));
        break;
      case LoginStatus.failure:
        log("LoginFailed");
        emit(LoginFailed(_repo.message));
        break;
      case LoginStatus.error:
        log("LoginError");
        emit(LoginError(_repo.error));
        break;
    }
  }
}
