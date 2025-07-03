import 'package:asdsmartcare/presentation/Doctor/Clinic/model/GetDoctorAvailability.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// States
abstract class AvailabilityState extends Equatable {
  const AvailabilityState();

  @override
  List<Object?> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilitySuccess extends AvailabilityState {
  final String message;
  const AvailabilitySuccess({this.message = 'Availability saved successfully.'});

  @override
  List<Object?> get props => [message];
}

class AvailabilityError extends AvailabilityState {
  final String error;
  const AvailabilityError(this.error);

  @override
  List<Object?> get props => [error];
}



class GetDoctorAvailabilityLoading extends AvailabilityState {}

class GetDoctorAvailabilitySuccess extends AvailabilityState {
  final GetDoctorAvailability model;
  const GetDoctorAvailabilitySuccess({required this.model});

}

class GetDoctorAvailabilityError extends AvailabilityState {
  final String error;
  const GetDoctorAvailabilityError(this.error);

  @override
  List<Object?> get props => [error];
}