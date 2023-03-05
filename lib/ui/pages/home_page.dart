import 'package:agenda_luthfi/shared/theme.dart';
import 'package:agenda_luthfi/ui/widgets/agenda_card.dart';
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
    // context.read<DestinationCubit>().fetchDestinations();
    super.initState();
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
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/image_profile.png'))),
            )
          ],
        ),
      );

      // return BlocBuilder<AuthCubit, AuthState>(
      //   builder: (context, state) {
      //     if (state is AuthSuccess) {
      //       return Container(
      //         margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Howdy,\n${state.user.name}',
      //                     style: blackTextStyle.copyWith(
      //                         fontSize: 24, fontWeight: semiBold),
      //                   ),
      //                   SizedBox(
      //                     height: 6,
      //                   ),
      //                   Text(
      //                     'Where to fly today?',
      //                     style: greyTextStyle.copyWith(
      //                         fontSize: 16, fontWeight: light),
      //                   )
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               width: 60,
      //               height: 60,
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   image: DecorationImage(
      //                       image: AssetImage('assets/image_profile.png'))),
      //             )
      //           ],
      //         ),
      //       );
      //     } else {
      //       return SizedBox();
      //     }
      //   },
      // );
    }

    Widget newDestinations() {
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
            ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AgendaTile();
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
          newDestinations(),
        ],
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