简介
===

一个类似Android LiveData的框架，提供MVVM模式的数据和生命周期绑定。

LiveData采用了观察者模式设计，其中LiveData是被观察者，当数据发生变化时会通知观察者进行数据更新，从而确保数据和界面的实时性。


LiveData能够感知组件的生命周期，所以可以通过设置LiveData组件的生命周期状态，来触发数据更新，从而更新UI。

使用
===
1、创建viewmodel，并创建livedata。

viewmodel内置了livedata的缓存方法，方便多个观察者能观察到同一个数据来源，
```Dart
class HomeViewModel extends ViewModel {
  MutableLiveData<List<CoolingModel>> mutableLiveData;

  MutableLiveData<List<CoolingModel>> getCoolingModel() {
    if (take("mutableLiveData") == null) {
      mutableLiveData = MutableLiveData<List<CoolingModel>>();
      putLiveData("mutableLiveData", mutableLiveData);
    } else {
      mutableLiveData = take("mutableLiveData");
    }
    return mutableLiveData;
  }
}
```

2、让你的组件继承LifecycleOwner，给Livedata提供生命周期来源

LifecycleOwner默认提供了STARTED和DESTROYED两个生命周期

你也可以通过LifecycleState来定义你自己的生命周期

```Dart
class HomeCooling extends StatefulWidget with LifecycleOwner {

}
```
```Dart
LifecycleState state = LifecycleState(state:"stop");
```


3、让你的组件继承LiveDataObserver，并通过泛型确认viewmodel提供的数据的类型。
LiveData会在数据变化后通过 onValueChange方法把改变后的数据通知给组件
```Dart
class HomeCoolingState extends State<HomeCooling>
    with LiveDataObserver<List<CoolingModel>> {
  List<CoolingModel> models = new List();
  
  @override
  void onValueChange(List<CoolingModel> value) {
    models = value;
    setState(() {});
  }
}
```

4、向viewmodel中添加observer
```Dart
homeModel = HomeViewModel().getCoolingModel();
homeModel.addObserver(this, homeCoolingState);
```


5、MutableLiveData是LiveData的默认实现，提供了setValue方法，通过调用setvalue方法就可以改变数据并通知所有的观察者。
也可以通过自定义LiveData来实现更多功能
```Dart
void getValue() async {
    List<CoolingModel> list = await CoolingModel.getModels();
    homeModel.setValue(list);
  }
```

