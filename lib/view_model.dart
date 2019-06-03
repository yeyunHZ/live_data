import 'package:live_data/live_data.dart';
import 'package:live_data/live_data_providers.dart';

///viewmodel
class ViewModel {
  ///缓存livedata
  void putLiveData(String key, LiveData liveData) {
    LiveDataProviders liveDataProviders = LiveDataProviders();
    liveDataProviders.put(key, liveData);
  }

  ///从缓存中取livedata
  LiveData take(String key) {
    LiveDataProviders liveDataProviders = LiveDataProviders();
    return liveDataProviders.take(key);
  }
}
