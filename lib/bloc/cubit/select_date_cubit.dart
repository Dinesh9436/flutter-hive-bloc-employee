import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_date_state.dart';

class SelectDateCubit extends Cubit<SelectDateState> {
  SelectDateCubit() : super(SelectDateState(DateTime.now()));

  Future<void> selectDate(DateTime date) async{
    emit(SelectDateState(date));
  }
}
