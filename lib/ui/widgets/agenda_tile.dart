import 'package:agenda_luthfi/bloc/agenda_bloc.dart';
import 'package:agenda_luthfi/data/models/agenda_model.dart';
import 'package:agenda_luthfi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AgendaTile extends StatelessWidget {
  final Agenda agenda;
  // final int index;

  const AgendaTile({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(agenda.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              print('Edit ${agenda.id}');
            },
            backgroundColor: kBackgroundColor,
            foregroundColor: kBlackColor,
            icon: Icons.edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {
              print('Delete ${agenda.id}');
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm'),
                    content: Text('Are you sure want to delete?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          context
                              .read<AgendaBloc>()
                              .add(DeleteAgenda(agenda.id!));
                          Navigator.of(context).pop();
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
            },
            backgroundColor: kBackgroundColor,
            foregroundColor: kBlackColor,
            icon: Icons.delete_outlined,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(18)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kAgendaContainerColor,
              ),
              child: Icon(
                Icons.edit_calendar_outlined,
                size: 17,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agenda.title,
                    overflow: TextOverflow.ellipsis,
                    style: blackTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    convertDate(agenda.datetime, 'EEEE, d MMM y'),
                    overflow: TextOverflow.ellipsis,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    convertDate(agenda.datetime, 'hh:mm a'),
                    overflow: TextOverflow.ellipsis,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  agenda.reminder != null
                      ? Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              agenda.reminder ?? '',
                              style: greyTextStyle.copyWith(
                                fontWeight: light,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Description',
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    agenda.description,
                    textAlign: TextAlign.justify,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: kAgendaContainerColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_file_outlined,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            agenda.attachment,
                            overflow: TextOverflow.ellipsis,
                            style: greyTextStyle.copyWith(
                              fontWeight: light,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
