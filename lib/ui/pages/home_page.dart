import 'package:agenda_luthfi/bloc/agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/user_bloc.dart';
import 'package:agenda_luthfi/shared/theme.dart';
import 'package:agenda_luthfi/ui/widgets/agenda_tile.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_airplane/cubit/auth_cubit.dart';
// import 'package:flutter_airplane/cubit/destination_cubit.dart';
// import 'package:flutter_airplane/models/destination_model.dart';
// import 'package:flutter_airplane/ui/widgets/destination_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AgendaBloc>().add(FetchAgendas());
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Howdy,\nDadang',
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Have a nice day!',
                    style:
                        greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTapDown: (details) async {
                await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    MediaQuery.of(context).size.width - 100,
                    kToolbarHeight,
                    0,
                    0,
                  ),
                  items: <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: Text('Profile'),
                      value: 'profile',
                    ),
                    const PopupMenuItem(
                      child: Text('Logout'),
                      value: 'logout',
                    ),
                  ],
                ).then(
                  (value) {
                    if (value == 'profile') {
                      Navigator.pushNamed(context, '/profile');
                    } else {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: Text('Are you sure want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  context.read<UserBloc>().add(UserInit());
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/sign-in', (route) => false);
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/image_profile.png'))),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.only(
            top: 30, left: defaultMargin, right: defaultMargin, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Agendas',
              style:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            BlocBuilder<AgendaBloc, AgendaState>(
              builder: (context, state) {
                if (state is AgendaLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AgendaHasData) {
                  return ListView.builder(
                    itemCount: state.result.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AgendaTile(
                        agenda: state.result[index],
                      );
                    },
                  );
                } else if (state is AgendaError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else if (state is AgendaEmpty) {
                  return const Center(
                    child: Text('No Agenda.'),
                  );
                } else {
                  return const Center(child: Text('Failed'));
                }
              },
            ),
            // Column(
            //   children: destinations.map((DestinationModel destination) {
            //     return AgendaTile();
            //   }).toList(),
            // )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-agenda');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_outlined),
      ),
    );

    // return BlocConsumer<DestinationCubit, DestinationState>(
    //   listener: (context, state) {
    //     if (state is DestinationFailed) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(backgroundColor: kRedColor, content: Text(state.error)));
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is DestinationSuccess) {
    //       return ListView(
    //         children: [
    //           header(),
    //           newDestinations(state.destinations),
    //         ],
    //       );
    //     }

    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }
}
