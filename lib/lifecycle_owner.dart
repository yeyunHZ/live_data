import 'package:live_data/Lifecycle_bound_observer.dart';
import 'package:live_data/lifecycle.dart';
import 'package:live_data/unique.dart';

///生命周期持有者
abstract class LifecycleOwner {
  ///生命周期
  Lifecycle _lifecycle;

  Lifecycle get lifecycle => _lifecycle;

  ///初始化生命周期
  void start() {
    if (_lifecycle == null) {
      _lifecycle = Lifecycle();
    } else {
      _lifecycle.currentState = Lifecycle.STARTED;
    }
    callObservers();
  }

  ///结束生命周期
  void destroy() {
    if (_lifecycle == null) {
      _lifecycle = Lifecycle();
    }
    _lifecycle.currentState = Lifecycle.STARTED;
    callObservers();
  }

  ///生命周期观察者
  Map<String, LifecycleBoundObserver> _observerMap = new Map();

  ///添加观察者
  void addObserver(LifecycleBoundObserver observer) {
    String unique = Unique.create();
    _observerMap[unique] = observer;
    observer.unique = unique;
  }

  ///移除观察者
  void removeObserver(LifecycleBoundObserver observer) {
    _observerMap.remove(observer.unique);
  }

  ///通知观察者状态改变
  void callObservers() {
    for (String key in _observerMap.keys) {
      _observerMap[key].onStateChanged(this);
    }
  }
}
