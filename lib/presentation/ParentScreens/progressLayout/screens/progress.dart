import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/childProgress/child_progress_cubit.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/controller/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/ParentScreens/progressLayout/screens/SessionDeatile.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/http.dart';

class ChildProgressScreen extends StatefulWidget {
  @override
  _ChildProgressScreenState createState() => _ChildProgressScreenState();
}

int ButtonIndex = 0;
List ButtonesNames = ["Last notes", "Sessions Done", "Upcoming sessions"];
List Comments = [
  {
    "Header": ["Doc 1", "Doc 2", "Doc 3"],
    "Discrption": ["1", "2 ", "3"],
  },
  {
    "Header": [],
    "Discrption": [],
  },
  {
    "Header": [],
    "Discrption": [],
  }
];
late SessionData curSession;

class _ChildProgressScreenState extends State<ChildProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarOpacity: 0,
        backgroundColor: Colors.white,
        title: TextUtils.textHeader("Child Progress", fontSize: 20),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: const SizedBox(
                  width: 300, // Adjust the height to fit two lines of text
                  child: Text(
                    'Autism progress is growth in skills and behavior',
                    textAlign: TextAlign.center,
                    maxLines: 2, // Limiting the text to 2 lines
                    overflow: TextOverflow
                        .ellipsis, // Handles text overflow if it exceeds the 2 lines
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 66, // Set width to a specific value
                    height: 66, // Set height equal to width
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // This makes the container circular
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF000FAF),
                          Color(0xFF000649),
                        ], // Your gradient colors
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(
                          3), // Adjust this to control the border thickness
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Inner circle background color
                      ),
                      child: Center(
                        child: TextUtils.textHeader("1", fontSize: 33),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextUtils.textHeader(
                    'Your Autism Level',
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextUtils.textHeader('Child Profiles', fontSize: 20),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF133E87),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius:
                          30, // Increase the radius to make the CircleAvatar larger
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils.textHeader("Ali Hassan",
                                headerTextColor: Colors.white),
                            TextUtils.textDescription("8yo",
                                disTextColor: Colors.white, fontSize: 15),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextUtils.textDescription("Male",
                                disTextColor: Colors.white, fontSize: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCCDFFF),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextUtils.textHeader(
                              "Sara",
                              headerTextColor: Color(0xFF133E87),
                            ),
                            TextUtils.textDescription("12yo",
                                disTextColor: Color(0xFF133E87), fontSize: 15),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextUtils.textDescription("Female",
                                disTextColor: Color(0xFF133E87), fontSize: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BlocProvider(
                    create: (context) => ChildProgressCubit()
                      ..GetAllDoctorsBookedaSpecificParent(),
                    child: BlocBuilder<ChildProgressCubit, ChildProgressState>(
                      builder: (context, state) {
                        final cubit = ChildProgressCubit.get(context);

                        final doctors = cubit.myDoctorList;
                        final currentDoctor =
                            doctors != null && doctors.isNotEmpty
                                ? doctors[cubit.current]
                                : null;

                        return ConditionalBuilder(
                          condition: state is! GetParentBookedDoctorsLoading &&
                              currentDoctor != null,
                          builder: (context) => Column(
                            children: [
                              BeforeDoctors(),
                              const SizedBox(height: 16),

                              // Buttons
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: ButtonesNames.length,
                                  itemBuilder: (context, index) {
                                    final isSelected = ButtonIndex == index;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          color: isSelected
                                              ? const Color(0xFF133E87)
                                              : const Color(0xFF8FADE1),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              ButtonIndex = index;
                                            });

                                            if (index == 2 || index == 1) {
                                              cubit
                                                  .GetAllCommingSessionsBookedaSpecificParent(
                                                currentDoctor!.id ?? "",
                                                index == 2 ? true : false,
                                              );
                                            }
                                          },
                                          title: TextUtils.textHeader(
                                            ButtonesNames[index],
                                            headerTextColor: Colors.white,
                                          ),
                                          titleAlignment:
                                              ListTileTitleAlignment.center,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 20),

                              SizedBox(
                                height: 350,
                                child: state
                                        is GetAllBookedSessionsByStatusLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : state is GetAllBookedSessionsByStatusError
                                        ? const Center(
                                            child:
                                                Text('Error loading sessions'))
                                        : (cubit.Sessions == null ||
                                                cubit.Sessions.isEmpty)
                                            ? const Center(
                                                child: Text(
                                                    'No previous doctor sessions'))
                                            : ListView.builder(
                                                itemCount:
                                                    cubit.Sessions!.length,
                                                itemBuilder: (context, index) {
                                                  final session =
                                                      cubit.Sessions![index];
                                                  curSession = session;
                                                  final header =
                                                      'Session ${session.sessionNumber ?? ''}';
                                                  final desc = session.comments
                                                          ?.join('\n') ??
                                                      '';
                                                  return _buildCommentCard(
                                                      header,
                                                      desc,
                                                      session,
                                                      context);
                                                },
                                              ),
                              ),
                            ],
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCommentCard(
    String header, String desc, SessionData session, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    child: GestureDetector(
      onTap: () => NavgatTO(context, SessionDeatile(session: session ,)),
      child: Container(
        height: 93,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF8FADE1),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtils.textHeader(
              header,
              headerTextColor: Colors.white,
              fontSize: 16,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                desc,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class BeforeDoctors extends StatefulWidget {
  @override
  _BeforeDoctorsState createState() => _BeforeDoctorsState();
}

class _BeforeDoctorsState extends State<BeforeDoctors> {
  @override
  Widget build(BuildContext context) {
    final DocLis = ChildProgressCubit.get(context).myDoctorList;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              if (ChildProgressCubit.get(context).current > 0) {
                setState(() {
                  ChildProgressCubit.get(context).current -= 1;
                });
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        TextUtils.textHeader(
            DocLis![ChildProgressCubit.get(context).current].parent!.userName ??
                ""),
        IconButton(
            onPressed: () {
              if (ChildProgressCubit.get(context).current < DocLis.length - 1) {
                setState(() {
                  ChildProgressCubit.get(context).current += 1;
                });
              }
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ))
      ],
    );
  }
}
