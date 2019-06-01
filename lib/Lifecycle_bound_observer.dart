import 'package:live_data/lifecycle.dart';
import 'package:live_data/lifecycle_owner.dart';
import 'package:live_data/live_data.dart';

///生命周期观察者
class LifecycleBoundObserver {
  LiveDataObserver _liveDataObserver;
  LiveData _liveData;

  LifecycleBoundObserver(this._liveDataObserver, this._liveData);

  ///标识
  String unique;

  ///生命周期改变
  void onStateChanged(LifecycleOwner lifecycleOwner) {
    if (lifecycleOwner.lifecycle.currentState == Lifecycle.DESTROYED) {
      lifecycleOwner.removeObserver(this);
      _liveData.removeObserver(_liveDataObserver);
      _liveData = null;
      _liveDataObserver = null;
    } else {
      _liveData.onLifecycleStateChange(lifecycleOwner);
    }
  }
}
