// import 'package:asdsmartcare/presentation/ParentScreens/DoctorLayout/DoctorBooking/Model/GetAutisumTestHistory.dart';

abstract class GetTestHistoryStates {}

class GetTestHistoryinitialStates extends GetTestHistoryStates{}
class GetAutisumTestHistoryLoadingStates extends GetTestHistoryStates{}
class GetAutisumTestHistorySuccsessStates extends GetTestHistoryStates{
}
class GetAutisumTestHistoryFailedStates extends GetTestHistoryStates{}


class GetAutisumLevelTestHistoryLoadingStates extends GetTestHistoryStates{}
class GetAutisumLevelTestHistorySuccsessStates extends GetTestHistoryStates{
}
class GetAutisumLevelTestHistoryFailedStates extends GetTestHistoryStates{}