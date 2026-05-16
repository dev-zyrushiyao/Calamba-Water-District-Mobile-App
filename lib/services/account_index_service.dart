import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/data-class/user_account.dart';

class AccountIndexService {
  @Deprecated(
    'This method is no longer available: the method is prone to RangeError (index): Index out of range: no indices are valid: 0'
    'The Parallel List approach List<SlidableController> creating a value for List<double> slidingValue to be used on Slidable List<WaterAccount>\n'
    'is risky for an to [index] get out of sync when the page rebuilds\n'
    'please use _slidableController[index].animation.value directly for the AnimatedRotation (turn property) instead',
  )
  void addSliderInitialValue(
    List<SlidableController> slidableController,
    UserAccount loggedUser,
    List<double> slidingValue,
  ) {
    //invoked during initState
    //Add initial values of Sliders
    //to prevent RangeError (index): Index out of range: no indices are valid: 0
    if (slidableController.isNotEmpty) {
      for (var i = 0; i < loggedUser.linkedAccounts.length; i++) {
        slidingValue.add(0.0);
      }
    }
  }

  @Deprecated(
    'This method is no longer available: the method is prone to RangeError (index): Index out of range: no indices are valid: 0'
    'The Parallel List approach List<SlidableController> creating a value for List<double> slidingValue to be used on Slidable List<WaterAccount>\n'
    'is risky for an to [index] get out of sync when the page rebuilds\n'
    'please use _slidableController[index].animation.value directly for the AnimatedRotation (turn property) instead',
  )
  void getTheSlidingValue(
    List<SlidableController> slidableController,
    UserAccount loggedUser,
    List<double> slidingValue,
    StateSetter setState,
  ) {
    //invoked during initState
    //The _slidingValue list have a default value of 0.0
    //when a sliding animation happens it overrite the default value of Slidable controller animation value
    if (slidableController.isNotEmpty) {
      for (var i = 0; i < loggedUser.linkedAccounts.length; i++) {
        slidableController[i].animation.addListener(() {
          setState(() {
            slidingValue[i] = slidableController[i].animation.value;
          });
        });
      }
    }
  }
}
