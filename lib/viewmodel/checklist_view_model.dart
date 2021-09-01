import 'package:flutter/material.dart';
import 'package:home_checklist/model/checklist_model.dart';
import 'package:home_checklist/repository/checklist_repository.dart';

class ChecklistViewModel extends ChangeNotifier{
  final ChecklistRepository repository;
  ChecklistViewModel(this.repository);

  List<ChecklistModel> _checklist = [];
  List<ChecklistModel> get checklist => _checklist;

  bool _isDone = false;
  bool get isDone => _isDone;

  bool _isLoading = false;
  bool get isloading => _isLoading;

  // String _currentHousing;
  // String get currnetHousing => _currentHousing;

  // 카테고리별로 데이터 가져오기
  Future<bool> getCategory(String category) async {
    _isLoading = true;

    _checklist = await repository.getCategory(category);
    _isDone = true;
    _isLoading = false;
    notifyListeners();

    return true;
  }

  // 모든 데이터 가져오기
  Future<bool> fetch() async {
    _isLoading = true;
    notifyListeners();

    _checklist = await repository.getAll();
    _isDone = true;
    _isLoading = false;
    notifyListeners();

    return true;
  }
}