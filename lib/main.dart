import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/employee_cubit.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_date_cubit.dart';
import 'package:flutter_employee_hive_bloc/constants/Strings.dart';
import 'package:flutter_employee_hive_bloc/models/new_employee_list.dart';
import 'package:flutter_employee_hive_bloc/bloc/cubit/select_to_date_cubit.dart';

import 'package:flutter_employee_hive_bloc/modules/employee_list.dart';
import 'package:flutter_employee_hive_bloc/repository/employee_repository.dart';
import 'package:flutter_employee_hive_bloc/utils/utility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

late PackageInfo packageInfo;

void main() async {
  try {
    await initPreAppServices();

    runApp(MyApp(employeeRepository: EmployeeRepository()));
  } catch (err) {
    AppUtility.log('Error occurred in main: ${err.toString()}', tag: 'error');
  }
}

Future<void> initPreAppServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();

  packageInfo = await PackageInfo.fromPlatform();

  AppUtility.log('Registering Hive Adapters');

  Hive.registerAdapter(EmployeeListAdapter());

  AppUtility.log('Opening Hive Boxes');

  await Hive.openBox<EmployeeList>(employeeLists);
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.employeeRepository});

   final EmployeeRepository employeeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: EmployeeRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => EmployeeListCubit(employeeRepository),
          ),
          BlocProvider(
            create: (_) => SelectDateCubit(),
          ),
          BlocProvider(
            create: (_) => SelectToDateCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
          home: const EmployeeListScreen(),
        ),
      ),
    );
  }
}
