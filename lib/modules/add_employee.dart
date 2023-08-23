import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/employee_cubit.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_date_cubit.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_to_date_cubit.dart';
import 'package:flutter_employee_hive_bloc/models/new_employee_list.dart';

import 'package:flutter_employee_hive_bloc/modules/date_picker.dart';
import 'package:flutter_employee_hive_bloc/repository/employee_repository.dart';
import 'package:flutter_employee_hive_bloc/widgets/button.dart';
import 'package:flutter_employee_hive_bloc/widgets/form_contailer.dart';
import 'package:flutter_employee_hive_bloc/widgets/loading_widget.dart';
import 'package:intl/src/intl/date_format.dart';

class AddEmployeePage extends StatefulWidget {
  final bool isEdit;
  final String? uid;
  AddEmployeePage({super.key, required this.isEdit, this.uid});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  DateTime? selectedDate;
  String role = 'Select role';
  DateTime? selectedToDate;
  TextEditingController _nameController = new TextEditingController();
  List<String> roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];
  EmployeeList? emp;

  Future<void> _showMyDialog(bool isFromDate) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(8),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          scrollable: true,
          content: SingleChildScrollView(
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * 1.4,
                  width: MediaQuery.of(context).size.width,
                  child: CustomDatePicker(
                    isFromDate: isFromDate,
                  ))),
        );
      },
    );
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext buildContext) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: roles.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    role = roles[index];
                  });
                  Navigator.of(context).pop();
                },
                title: Center(child: Text(roles[index])),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) getEmployee(widget.uid!);
  }

  getEmployee(String uid) async {
    emp = await EmployeeRepository().getEmployeeByID(uid);
    setState(() {
      _nameController.text = emp!.title;
      role = emp!.role!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.isEdit ? "Edit Employee Details" : "Add Employee Details"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormContainer(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Employee name',
                    ),
                  ),
                ),
                width: width),
            InkWell(
              onTap: () => _showBottomSheet(context),
              child: FormContainer(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.work_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(role)
                          ],
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  width: width),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<SelectDateCubit, SelectDateState>(
                  builder: (context, state) {
                    selectedDate = widget.isEdit && emp != null
                        ? emp!.fromDate
                        : state.selectedDate;
                    return InkWell(
                      onTap: () async => _showMyDialog(true),
                      //  Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => CustomDatePicker())),
                      child: FormContainer(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat.yMMMd().format(state.selectedDate),
                              )
                            ],
                          ),
                          width: width * 0.375),
                    );
                  },
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
                BlocBuilder<SelectToDateCubit, SelectToDateState>(
                  builder: (context, state) {
                    selectedToDate = widget.isEdit && emp != null
                        ? emp!.toDate
                        : state.selectedToDate;
                    return InkWell(
                      onTap: () async => _showMyDialog(false),
                      child: FormContainer(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat.yMMMd().format(state.selectedToDate),
                              )
                            ],
                          ),
                          width: width * 0.375),
                    );
                  },
                )
              ],
            ),
            Spacer(),
            Divider(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CancelSaveButton(
                  onTap: () => Navigator.of(context).pop(),
                  title: "Cancel",
                  buttonColor: Color(0xFFEDF8FF),
                  titleColor: Theme.of(context).primaryColor,
                  width: width * 0.2,
                ),
                CancelSaveButton(
                  onTap:() async{
                    if (widget.isEdit)
                      await BlocProvider.of<EmployeeListCubit>(context)
                          .updateEmployeeList(widget.uid!, _nameController.text,
                              role, selectedDate!, selectedToDate!)
                          .then((_) {
                        Navigator.pop(context, true);
                      });
                    else
                      await BlocProvider.of<EmployeeListCubit>(context)
                          .addEmployeeList(_nameController.text, role,
                              selectedDate!, selectedToDate)
                          .then((_) {
                        Navigator.pop(context, true);
                      });
                  },
                  title: "Save",
                  buttonColor: Theme.of(context).primaryColor,
                  titleColor: Colors.white,
                  width: width * 0.2,
                )
              ],
            )
          ],
        ));
  }
}
