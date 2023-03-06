import 'package:agenda_luthfi/bloc/date_time_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/gender_bloc.dart';
import 'package:agenda_luthfi/bloc/reminder_bloc.dart';
import 'package:agenda_luthfi/bloc/switch_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/upload_file_bloc.dart';
import 'package:agenda_luthfi/ui/pages/create_agenda_page.dart';
import 'package:agenda_luthfi/ui/pages/home_page.dart';
import 'package:agenda_luthfi/ui/pages/profile_page.dart';
import 'package:agenda_luthfi/ui/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwitchAgendaBloc(),
        ),
        BlocProvider(
          create: (_) => DateTimeAgendaBloc(),
        ),
        BlocProvider(
          create: (_) => ReminderBloc(),
        ),
        BlocProvider(
          create: (_) => UploadFileBloc(),
        ),
        BlocProvider(
          create: (_) => GenderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/sign-in',
        routes: {
          '/sign-in': (context) => SignInPage(),
          '/home': (context) => HomePage(),
          '/create-agenda': (context) => CreateAgendaPage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
