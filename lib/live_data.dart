import 'package:live_data/Lifecycle_bound_observer.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/unique.dart';

abstract class LiveData<T> {
  ///观察者
  Map<String, LiveDataObserver<T>> _observerMap = new Map();

  Map<String, LiveDataObserver<T>> get observerMap => _observerMap;

  ///设置value
  void setValue(T value);

  ///生命周期改变
  void onLifecycleStateChange(LifecycleOwner lifecycleOwner);

  ///添加观察者
  void addObserver(LifecycleOwner owner, LiveDataObserver<T> observer) {
    String unique = Unique.create();
    _observerMap[unique] = observer;
    observer.unique = unique;
    LifecycleBoundObserver lifecycleBoundObserver =
        LifecycleBoundObserver(observer, this);
    owner.addObserver(lifecycleBoundObserver);
  }

  ///移除观察者
  void removeObserver(LiveDataObserver<T> observer) {
    _observerMap.remove(observer.unique);
  }
}

///liveData观察者
abstract class LiveDataObserver<T> {
  ///标识
  String unique;

  void onValueChange(T value);
}
