import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/employee_cubit.dart';
import 'package:flutter_employee_hive_bloc/models/new_employee_list.dart';
import 'package:flutter_employee_hive_bloc/modules/add_employee.dart';
import 'package:flutter_employee_hive_bloc/utils/utility.dart';
import 'package:flutter_employee_hive_bloc/widgets/loading_widget.dart';
import 'package:intl/src/intl/date_format.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget buildListTile(BuildContext ctx, EmployeeList emp) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddEmployeePage(isEdit: true, uid: emp.id))),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          emp.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(emp.role!),
          ),
          Text("From " + DateFormat.yMMMd().format(emp.fromDate)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: BlocConsumer<EmployeeListCubit, EmployeeListState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.status.isFailure) {
            AppUtility.showSnackBar(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case EmployeeListStatus.initial:
              return Text("");
            case EmployeeListStatus.loading:
              return const LoadingWidget();
            case EmployeeListStatus.success:
            case EmployeeListStatus.failure:
              if (state.employeeLists.isEmpty) {
                return Text("No records found");
                ;
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text(
                        "Current Employees",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.employeeLists.length,
                      itemBuilder: (context, index) {
                        final employee = state.employeeLists[index];
                        return Dismissible(
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          key: Key(state.employeeLists[index].id),
                          onDismissed: (direction) async {
                            await BlocProvider.of<EmployeeListCubit>(context)
                                .deleteEmployeeList(
                                    state.employeeLists[index].id)
                                .then((value) => AppUtility.showSnackBar(
                                    context: context,
                                    message: "Employee data has been deleted"));
                          },
                          child: Column(
                            children: [
                              buildListTile(context, employee),
                              Divider()
                            ],
                          ),
                        );
                      }),
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEmployeePage(
                      isEdit: false,
                    ))),
        tooltip: 'Add',
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
    );
  }
}
