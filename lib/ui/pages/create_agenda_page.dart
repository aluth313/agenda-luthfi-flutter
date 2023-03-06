import 'dart:io';

import 'package:agenda_luthfi/bloc/date_time_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/reminder_bloc.dart';
import 'package:agenda_luthfi/bloc/switch_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/upload_file_bloc.dart';
import 'package:agenda_luthfi/ui/widgets/custom_button.dart';
import 'package:agenda_luthfi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_airplane/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class CreateAgendaPage extends StatefulWidget {
  CreateAgendaPage({Key? key}) : super(key: key);

  @override
  State<CreateAgendaPage> createState() => _CreateAgendaPageState();
}

class _CreateAgendaPageState extends State<CreateAgendaPage> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    context.read<DateTimeAgendaBloc>().add(DateTimeInit());
    context.read<ReminderBloc>().add(ReminderInit());
    context.read<SwitchAgendaBloc>().add(IsActivate(false));
    context.read<UploadFileBloc>().add(UploadFileInit());
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kGreyColor,
                  ),
                ),
                child: const Icon(Icons.arrow_back_outlined),
              ),
            ),
            Expanded(
              child: Text(
                'Create Agenda',
                style:
                    blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget titleInput() {
        return CustomTextFormField(
            controller: emailController, title: 'Title', hintText: 'Title');
      }

      Widget descriptionInput() {
        return CustomTextFormField(
          controller: passwordController,
          title: 'Description',
          hintText: 'Description',
          // obsecure: true,
        );
      }

      Widget dateTimeInput() {
        return Container(
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date & Time'),
              SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onConfirm: (date) {
                    context.read<DateTimeAgendaBloc>().add(IsChange(date));
                  }, currentTime: DateTime.now());
                },
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
                  child: BlocBuilder<DateTimeAgendaBloc, DateTimeAgendaState>(
                    builder: (context, state) {
                      return Text(
                        state is DateTimeAgendaChanged
                            ? convertDate(state.dateTime.toIso8601String(),
                                'yyyy-MM-dd hh:mm')
                            : 'Date & Time',
                        style: TextStyle(
                          color: kGreyTextColor,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget reminderSwitch() {
        return Row(
          children: [
            Expanded(
              child: Text('Reminder'),
            ),
            BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
              builder: (context, state) {
                return Switch(
                  value: state is IsActive ? true : false,
                  activeColor: kPrimaryColor,
                  onChanged: (bool value) {
                    context.read<SwitchAgendaBloc>().add(IsActivate(value));
                  },
                );
              },
            )
          ],
        );
      }

      Widget reminderInput() {
        return Container(
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reminder'),
              SizedBox(
                height: 6,
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  border: Border.all(
                    color: kGreyColor,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state is ReminderChanged
                            ? state.reminder
                            : '1 hour before',
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        onChanged: (String? value) {
                          context
                              .read<ReminderBloc>()
                              .add(IsChangeReminder(value!));
                        },
                        items: [
                          '1 hour before',
                          '3 hour before',
                          '1 day before'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget attachmentInput() {
        return Container(
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Attachment'),
              SizedBox(
                height: 6,
              ),
              BlocBuilder<UploadFileBloc, UploadFileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            border: Border.all(
                              color: kGreyColor,
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  state is UploadFileChanged
                                      ? state.path
                                      : 'No Attachment',
                                  style: TextStyle(
                                    color: kGreyTextColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            print(result.files.single.path);
                            context.read<UploadFileBloc>().add(
                                IsChangeAttachment(result.files.single.name));
                          } else {
                            // User canceled the picker
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          minimumSize: const Size(0, 60),
                          // maximumSize: const Size(122, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                        child: const Icon(
                          Icons.upload_file,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('or'),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          print(photo!.path);
                          context
                              .read<UploadFileBloc>()
                              .add(IsChangeAttachment(photo.name));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          minimumSize: const Size(0, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                        ),
                        child: const Icon(
                          Icons.photo_camera_outlined,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }

      Widget submitButton() {
        return CustomButtom(
          title: 'Create',
          onPressed: () {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/home', (route) => false);
            // context.read<AuthCubit>().signIn(
            //     email: emailController.text,
            //     password: passwordController.text);
          },
        );

        // return BlocConsumer<AuthCubit, AuthState>(
        //   listener: (context, state) {
        //     // if (state is AuthSuccess) {
        //     //   Navigator.pushNamedAndRemoveUntil(
        //     //       context, '/main', (route) => false);
        //     // } else if (state is AuthFailed) {
        //     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     //       backgroundColor: kRedColor, content: Text(state.error)));
        //     // }
        //   },
        //   builder: (context, state) {
        //     // if (state is AuthLoading) {
        //     //   return Center(
        //     //     child: CircularProgressIndicator(),
        //     //   );
        //     // }

        //     return CustomButtom(
        //       title: 'Sign In',
        //       onPressed: () {
        //         // context.read<AuthCubit>().signIn(
        //         //     email: emailController.text,
        //         //     password: passwordController.text);
        //       },
        //     );
        //   },
        // );
      }

      return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            titleInput(),
            descriptionInput(),
            dateTimeInput(),
            attachmentInput(),
            reminderSwitch(),
            BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
              builder: (context, state) {
                if (state is IsActive) {
                  return reminderInput();
                } else {
                  return SizedBox();
                }
              },
            ),
            submitButton(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            title(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
