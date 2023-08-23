import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_to_date_state.dart';

class SelectToDateCubit extends Cubit<SelectToDateState> {
  SelectToDateCubit() : super(SelectToDateState(DateTime.now()));

  Future<void> selectToDate(DateTime toDate) async {
    emit(SelectToDateState(toDate));
  }
}
