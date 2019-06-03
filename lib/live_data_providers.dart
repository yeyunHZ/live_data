import 'package:live_data/live_data.dart';

class LiveDataProviders {
  ///单例
  static LiveDataProviders _instance;
  Map<String, LiveData> _liveDataMap;

  static LiveDataProviders _getInstance() {
    if (_instance == null) {
      _instance = new LiveDataProviders._internal();
    }
    return _instance;
  }

  LiveDataProviders._internal() {
    _liveDataMap = Map();
  }

  factory LiveDataProviders() => _getInstance();

  ///缓存liveData
  void put(String key, LiveData liveData) {
    _liveDataMap[key] = liveData;
  }

  ///在缓存中取livedata
  LiveData take(String key) {
    return _liveDataMap[key];
  }
}
