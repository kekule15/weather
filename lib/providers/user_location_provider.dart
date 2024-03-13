import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/viewmodel/user_location_vm.dart';

final userLocationViewModelProvider = ChangeNotifierProvider<UserLocationViewModel>(
    (ref) => UserLocationViewModel(ref));

