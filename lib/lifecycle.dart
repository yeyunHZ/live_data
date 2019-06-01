///生命周期

class Lifecycle {
  ///初始状态
  static LifecycleState STARTED = LifecycleState(state: "STARTED");

  ///销毁状态
  static LifecycleState DESTROYED = LifecycleState(state: "DESTROYED");

  ///当前生命周期状态
  LifecycleState currentState;

  Lifecycle() {
    currentState = STARTED;
  }
}

///生命周期状态值
class LifecycleState {
  final String state;

  const LifecycleState({this.state});
}
