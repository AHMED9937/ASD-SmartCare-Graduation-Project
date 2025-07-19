import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/childProgress/child_progress_cubit.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/controller/childProgress/child_progress_state.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/model/GetAllSession.dart';
import 'package:asdsmartcare/presentation/ParentLayout/progressLayout/screens/SessionDeatile.dart';
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
List ButtonesNames = [ "Sessions Done", "Upcoming sessions"];
List Comments = [
  {
    "Header": [],
    "Discrption": [],
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

late SessionData curSession;class _ChildProgressScreenState extends State<ChildProgressScreen> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Left: progress description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.auto_awesome, size: 32, color: Color(0xFF133E87)),
                          const SizedBox(height: 8),
                          TextUtils.textHeader('Autism Progress', fontSize: 16),
                          const SizedBox(height: 4),
                          TextUtils.textDescription(
                            'Growth in skills and behavior',
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right: circular level indicator
                    Column(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1 / 2, // dynamic fraction
                                strokeWidth: 1,
                                color: Color(0xFF133E87),
                                backgroundColor: Colors.grey.shade300,
                              ),
                              TextUtils.textHeader('1/2', fontSize: 16),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextUtils.textDescription('Autism Level', fontSize: 14),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
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
                    create: (context) =>
                        ChildProgressCubit()..GetAllDoctorsBookedaSpecificParent(),
                    child: BlocConsumer<ChildProgressCubit, ChildProgressState>(
                      listener: (context, state) {
                        if (state is GetParentBookedDoctorsLoaded){
                           final cubit = ChildProgressCubit.get(context);
      // assume you already have at least one doctor loaded
      if( cubit.myDoctorList!.isNotEmpty){
      final firstDoctorId = cubit.myDoctorList!.first.id ?? "";
      // ButtonIndex==0 → done sessions; ==1 → upcoming
      cubit.GetAllCommingSessionsBookedaSpecificParent(
        firstDoctorId,
        ButtonIndex == 1,
      );}
                        }
                      },
                      builder: (context, state) {
                        final cubit = ChildProgressCubit.get(context);
                        final doctors = cubit.myDoctorList;
                        final currentDoctor = (doctors != null && doctors.isNotEmpty)
                            ? doctors[cubit.current]
                            : null;

                        return ConditionalBuilder(
                          // show spinner while loading doctors
                          condition: state is! GetParentBookedDoctorsLoading,
                          builder: (context) => currentDoctor != null
                              ? Column(
                                  children: [
                                    BeforeDoctors(),
                                    const SizedBox(height: 16),
                                    // Buttons
                                    SizedBox(
                                      height: 300,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: ButtonesNames.length,
                                        itemBuilder: (context, index) {
                                          final isSelected = ButtonIndex == index;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(11),
                                                color: isSelected
                                                    ? const Color(0xFF133E87)
                                                    : const Color(0xFF8FADE1),
                                              ),
                                              child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    ButtonIndex = index;
                                                  });
                                                  cubit.GetAllCommingSessionsBookedaSpecificParent(
                                                    currentDoctor!.id ?? "",
                                                    index == 1,
                                                  );
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
                                      child: state is GetAllBookedSessionsByStatusLoading
                                          // show spinner while loading sessions
                                          ? const Center(child: CircularProgressIndicator())
                                          : state is GetAllBookedSessionsByStatusError
                                              // show error UI
                                              ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.error_outline,
                                                        size: 64, color: Colors.redAccent),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      'Failed to load sessions',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.redAccent,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Please check your connection and try again.',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey[700]),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton.icon(
                                                      icon: const Icon(Icons.refresh,
                                                          color: Colors.white),
                                                      label: const Text('Retry',
                                                          style:
                                                              TextStyle(color: Colors.white)),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Color(0xFF133E87),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(8)),
                                                      ),
                                                      onPressed: () => cubit
                                                          .GetAllCommingSessionsBookedaSpecificParent(
                                                            currentDoctor!.id ?? "",
                                                            ButtonIndex == 1,
                                                          ),
                                                    ),
                                                  ],
                                                )
                                              : (cubit.Sessions == null ||
                                                      cubit.Sessions!.isEmpty)
                                                  // show no-sessions UI
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.calendar_today_outlined,
                                                            size: 64, color: Colors.grey),
                                                        const SizedBox(height: 16),
                                                        Text(
                                                          'No Sessions Yet',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.grey[800],
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          'You haven’t had any sessions so far.',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.grey[600]),
                                                        ),
                                                      ],
                                                    )
                                                  // show sessions list
                                                  : ListView.builder(
                                                      itemCount: cubit.Sessions!.length,
                                                      itemBuilder: (context, index) {
                                                        final session = cubit.Sessions![index];
                                                        curSession = session;
                                                        final header =
                                                            'Session ${session.sessionNumber ?? ''}';
                                                        final desc =
                                                            session.comments?.join('\n') ?? '';
                                                        return _buildCommentCard(
                                                            header, desc, session, context);
                                                      },
                                                    ),
                                    ),
                                  ],
                                )
                              : Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Failed to load Sessions ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('Retry', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF133E87),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final cubit = ChildProgressCubit.get(context);
                cubit.GetAllDoctorsBookedaSpecificParent();
              },
            ),
          ])),
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
      onTap: () => NavgatTO(context, SessionDetail(session: session ,)),
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
              color: Colors.grey,
              size: 33,
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
              color: Colors.grey,
              size:33,
            ))
      ],
    );
  }
}
