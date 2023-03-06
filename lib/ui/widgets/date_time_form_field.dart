import 'package:agenda_luthfi/shared/theme.dart';
import 'package:flutter/material.dart';

class DateTimeFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final VoidCallback onTap;
  const DateTimeFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 6,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 18,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                border: Border.all(
                  color: kGreyColor,
                ),
              ),
              child: Text(
                hintText,
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 16,
                ),
              ),

              // BlocBuilder<DateTimeAgendaBloc, DateTimeAgendaState>(
              //   builder: (context, state) {
              //     return Text(
              //       state is DateTimeAgendaChanged
              //           ? convertDate(state.dateTime.toIso8601String(),
              //               'yyyy-MM-dd hh:mm')
              //           : 'Date & Time',
              //       style: TextStyle(
              //         color: kGreyTextColor,
              //         fontSize: 16,
              //       ),
              //     );
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
