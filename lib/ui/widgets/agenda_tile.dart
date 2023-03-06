import 'package:agenda_luthfi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AgendaTile extends StatelessWidget {
  // final DestinationModel destination;
  final int index;

  const AgendaTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              print('Edit $index');
            },
            backgroundColor: kBackgroundColor,
            foregroundColor: kBlackColor,
            icon: Icons.edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {
              print('Delete ${index}');
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
                    'Travelling',
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
                    'Saturday, 14 Nov 2023',
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
                    '02 : 00 PM',
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
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
                            'dokumen.pdf',
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
