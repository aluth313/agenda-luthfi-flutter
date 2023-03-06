import 'dart:io';

import 'package:agenda_luthfi/bloc/date_time_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/gender_bloc.dart';
import 'package:agenda_luthfi/bloc/switch_agenda_bloc.dart';
import 'package:agenda_luthfi/bloc/upload_file_bloc.dart';
import 'package:agenda_luthfi/ui/widgets/custom_button.dart';
import 'package:agenda_luthfi/ui/widgets/custom_text_form_field.dart';
import 'package:agenda_luthfi/ui/widgets/date_time_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_airplane/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../shared/theme.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    context.read<DateTimeAgendaBloc>().add(DateTimeInit());
    context.read<GenderBloc>().add(IsChangeGender('male'));
    context.read<UploadFileBloc>().add(UploadFileInit());
    context.read<SwitchAgendaBloc>().add(IsActivate(false));
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
                'My Profile',
                style:
                    blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputSection() {
      Widget firstNameInput() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (context, state) {
            return CustomTextFormField(
                controller: emailController,
                title: 'First Name',
                readOnly: state is IsActive ? false : true,
                hintText: 'First Name');
          },
        );
      }

      Widget lastNameInput() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (context, state) {
            return CustomTextFormField(
                controller: emailController,
                title: 'Last Name',
                readOnly: state is IsActive ? false : true,
                hintText: 'Last Name');
          },
        );
      }

      Widget emailInput() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (context, state) {
            return CustomTextFormField(
                controller: emailController,
                title: 'Email Address',
                readOnly: state is IsActive ? false : true,
                hintText: 'Your Email');
          },
        );
      }

      Widget birthDateInput() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (contextSwitch, stateSwitch) {
            return BlocBuilder<DateTimeAgendaBloc, DateTimeAgendaState>(
              builder: (context, state) {
                return DateTimeFormField(
                  title: 'Birth Date',
                  hintText: state is DateTimeAgendaChanged
                      ? convertDate(
                          state.dateTime.toIso8601String(), 'yyyy-MM-dd')
                      : 'Birth Date',
                  onTap: () {
                    if (stateSwitch is IsActive) {
                      DatePicker.showDatePicker(context, showTitleActions: true,
                          onConfirm: (date) {
                        context.read<DateTimeAgendaBloc>().add(IsChange(date));
                      }, currentTime: DateTime.now());
                    }
                  },
                );
              },
            );
          },
        );
      }

      Widget passwordInput() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (context, state) {
            return CustomTextFormField(
              controller: passwordController,
              title: 'Password',
              hintText: 'Your Password',
              readOnly: state is IsActive ? false : true,
              obsecure: true,
            );
          },
        );
      }

      Widget photoInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: BlocBuilder<GenderBloc, GenderState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Photo Profile'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      BlocBuilder<UploadFileBloc, UploadFileState>(
                        builder: (context, state) {
                          return Expanded(
                            child: state is UploadFileChanged
                                ? Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                FileImage(File(state.path)))),
                                  )
                                : Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(state
                                                    is UploadFileChanged
                                                ? state.path
                                                : 'assets/image_profile.png'))),
                                  ),
                          );
                        },
                      ),
                      BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
                        builder: (context, state) {
                          return Container(
                            height: 55,
                            margin: EdgeInsets.only(
                              left: 5,
                            ),
                            child: TextButton(
                              onPressed: () async {
                                if (state is IsActive) {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    File file = File(result.files.single.path!);
                                    print(result.files.single.path);
                                    context.read<UploadFileBloc>().add(
                                        IsChangeAttachment(
                                            result.files.single.path!));
                                  } else {}
                                }
                              },
                              child: Text(
                                'Change\nPhoto',
                                textAlign: TextAlign.center,
                                style:
                                    whiteTextStyle.copyWith(fontWeight: medium),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: state is IsActive
                                      ? kPrimaryColor
                                      : kGreyColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          defaultRadius))),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }

      Widget genderInput() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
            builder: (contextSwitch, stateSwitch) {
              return BlocBuilder<GenderBloc, GenderState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender'),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text('Male'),
                              value: 'male',
                              groupValue: state is GenderChanged
                                  ? state.gender
                                  : 'male',
                              activeColor: kPrimaryColor,
                              onChanged: stateSwitch is IsNotActive
                                  ? null
                                  : (value) {
                                      context.read<GenderBloc>().add(
                                          IsChangeGender(value.toString()));
                                    },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text('Female'),
                              value: 'female',
                              groupValue: state is GenderChanged
                                  ? state.gender
                                  : 'male',
                              activeColor: kPrimaryColor,
                              onChanged: stateSwitch is IsNotActive
                                  ? null
                                  : (value) {
                                      context.read<GenderBloc>().add(
                                          IsChangeGender(value.toString()));
                                    },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      }

      Widget submitButton() {
        return BlocBuilder<SwitchAgendaBloc, SwitchAgendaState>(
          builder: (context, state) {
            return CustomButtom(
              title: state is IsActive ? 'Update' : 'Edit',
              onPressed: () {
                state is IsActive
                    ? context.read<SwitchAgendaBloc>().add(IsActivate(false))
                    : context.read<SwitchAgendaBloc>().add(IsActivate(true));
                ;
              },
              colorButton: state is IsActive ? kPrimaryColor : kGreenColor,
            );
          },
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            firstNameInput(),
            lastNameInput(),
            emailInput(),
            birthDateInput(),
            genderInput(),
            passwordInput(),
            photoInput(),
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
