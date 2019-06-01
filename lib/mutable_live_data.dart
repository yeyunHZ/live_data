import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/live_data.dart';

class MutableLiveData<T> extends LiveData<T> {
  @override
  void onLifecycleStateChange(LifecycleOwner lifecycleOwner) {}

  @override
  void setValue(T value) {
    _callObserver(value);
  }

  ///通知观察者数据改变了
  void _callObserver(T value) {
    for (String key in observerMap.keys) {
      observerMap[key].onValueChange(value);
    }
  }
}
