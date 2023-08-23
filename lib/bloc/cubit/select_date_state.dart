part of 'select_date_cubit.dart';

class SelectDateState extends Equatable {
   SelectDateState(this.selectedDate);

  final  DateTime selectedDate;

  

  @override
  List<Object> get props => [ this.selectedDate];
}

