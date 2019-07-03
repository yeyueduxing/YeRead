import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum ReduActions {
  Boy,
  Girl,
}

/// 这个类用来管理登录状态
class RoleState {
  bool isBoy; //是否登录
  RoleState({this.isBoy: false});

  @override
  String toString() {
    return "{isBoy:$isBoy}";
  }
}

/// 定义所有action的基类
class RoleSuccessAction {
  final bool isBoy;

  RoleSuccessAction({this.isBoy});
}

/// 应用程序状态
class AppState {
  RoleState role; //角色状态

  AppState({this.role});

  @override
  String toString() {
    return "{auth:$role}";
  }
}

AppState mainReducer(AppState state, dynamic action) {
  print("state charge :$action ");

  if(action is RoleSuccessAction){
    state.role.isBoy = action.isBoy;
  }
  print("state changed:$state");

  return state;
}

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');

  next(action);
}
