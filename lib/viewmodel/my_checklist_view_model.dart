import 'package:flutter/cupertino.dart';
import 'package:home_checklist/model/my_checklist.dart';
import 'package:home_checklist/repository/my_checklist_repository.dart';

class MyChecklistViewModel extends ChangeNotifier {
  final MyChecklistRepository _repository = MyChecklistRepository();
  List<MyChecklist> _myChecklists = [];
  List<MyChecklist> get myChecklists => _myChecklists;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 체크리스트 저장
  Future<bool> saveMyChecklist(MyChecklist myChecklist) async {
    bool result = await _repository.saveChecklist(myChecklist);
    return result;
  }

  // 저장된 체크리스트 목록 가져오기
  getChecklists(String email) async {
    _myChecklists = await _repository.getChecklists(email);
    _isLoading = true;

    notifyListeners();
  }

  // Stream<QuerySnapshot<MyChecklist>> getChatListStream(String email) {
  //   return _repository.getChecklistsRef(email);
  // }

  // 체크리스트 삭제하기
  deleteChecklist(String id) async {
    await _repository.deleteMyChecklist(id);

    notifyListeners();
  }

  getChecklist(String docId) async {
    await getChecklist(docId);

    notifyListeners();
  }
}