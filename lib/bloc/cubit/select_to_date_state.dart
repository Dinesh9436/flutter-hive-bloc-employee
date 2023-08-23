part of 'select_to_date_cubit.dart';

class SelectToDateState extends Equatable {
  final DateTime selectedToDate;
  SelectToDateState( this.selectedToDate);

  @override
  List<Object> get props => [this.selectedToDate];
}


