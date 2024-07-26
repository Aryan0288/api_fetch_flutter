import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class StateProvider extends ChangeNotifier {
  final List<int> count = [1, 2, 3, 4];
  var sliderValue = 10.0;
  void add() {
    int last = count.last;
    count.add(last + 1);

    notifyListeners();
  }

  void sub() {
    count.remove(count.last);
    notifyListeners();
  }

  void sliderOnChanged(double val) {
    sliderValue = val;
    notifyListeners();
  }

}
