import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localregistration/home/services/authentication.dart';
import 'package:localregistration/home/services/todo.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginEvent>(
      (event, emit) async {
        final user =
            await _auth.authenticateUser(event.username, event.password);
        if (user != null) {
          emit(SuccessfulLoginState(user));
          emit(HomeInitial());
        }
      },
    );

    on<RegisterServicesEvent>(
        (event, emit) async{
          await _auth.init();
          await _todo.init();
          emit(HomeInitial());
        }
    );
  }
}
