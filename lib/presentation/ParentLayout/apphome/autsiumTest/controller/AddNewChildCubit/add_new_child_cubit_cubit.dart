import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_new_child_cubit_state.dart';

/// Cubit to manage adding and selecting children for the autism test
class AddNewChildCubit extends Cubit<AddNewChildStates> {
  AddNewChildCubit() : super(AddNewChildinitialState());

  /// Helper to access the cubit via context
  static AddNewChildCubit get(BuildContext context) =>
    BlocProvider.of<AddNewChildCubit>(context);

  /// List of children, each entry contains name, birthday, gender, and age
  final List<Map<String, String>> children = [
    {
      'name': 'Ahmed',
      'birthday': '11/11/11',
      'gender': 'Male',
      'age': '11',
    },
  ];

  /// Index of the currently selected child, or -1 if none
  int selectedIndex = 0;

  /// Form controllers for adding a new child
  final TextEditingController childName    = TextEditingController();
  final TextEditingController birthday     = TextEditingController();
  final TextEditingController gender       = TextEditingController();
  final TextEditingController age          = TextEditingController();

  /// Adds a new child from the form, clears inputs, and emits state
  void addChild() {
    final nameValue     = childName.text.trim();
    final birthdayValue = birthday.text.trim();
    final genderValue   = gender.text.trim();
    final ageValue      = age.text.trim();

    // Basic validation
    if (nameValue.isEmpty || birthdayValue.isEmpty || genderValue.isEmpty || ageValue.isEmpty) {
      return;
    }

    // Append to list
    children.add({
      'name':     nameValue,
      'birthday': birthdayValue,
      'gender':   genderValue,
      'age':      ageValue,
    });

    // Clear form
    _clearForm();

    // Notify UI
    emit(AddNewChildAddedState());
  }

  /// Marks a child as selected by index and emits state
  void selectChild(int index) {
    if (index < 0 || index >= children.length) return;
    selectedIndex = index;
    emit(AddNewChildSelectedState());
  }

  /// Clears all text controllers
  void _clearForm() {
    childName.clear();
    birthday.clear();
    gender.clear();
    age.clear();
  }
}
