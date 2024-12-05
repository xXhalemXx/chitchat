import 'package:bloc/bloc.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/massages_logic.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.massagesLogic}) : super(HomeInitial());
  final MassagesLogic massagesLogic;

  Future<void> getAllUsers() async {
    await massagesLogic.getAllUsers();
  }
}
