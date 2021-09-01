import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_checklist/model/my_checklist.dart';
import 'package:home_checklist/repository/my_checklist_repository.dart';

void main() {
  group('my_checklist_repository', () {
    test('my checklist 저장하고 불러오기', () async {
      final _instance = FakeFirebaseFirestore();
      final _repository = MyChecklistRepository(firebaseFirestore: _instance);

      MyChecklist _myChecklist = MyChecklist('aaa@test.com', 'alias', 'housing',
          '', '', DateTime.now().millisecondsSinceEpoch);

      expect((await _repository.saveChecklist(_myChecklist)), true);

      // email 별로 저장된 체크리스트 값 불러오기
      expect((await _repository.getChecklists(_myChecklist.email ?? '')).length, 1);

      _myChecklist.alias = '2222';
      expect((await _repository.saveChecklist(_myChecklist)), true);

      expect((await _repository.getChecklists(_myChecklist.email ?? '')).length, 2);

//      List<MyChecklist> _list = _repository.getChecklists(_myChecklist.email ?? '');
    });


    test('my checklist 삭제', () async {
      final _instance = FakeFirebaseFirestore();
      final _repository = MyChecklistRepository(firebaseFirestore: _instance);
      MyChecklist _myChecklist = MyChecklist('aaa@test.com', 'alias', 'housing',
          '', '', DateTime.now().millisecondsSinceEpoch);
      _repository.saveChecklist(_myChecklist);


    });
      // await _repository.getChecklist(_myChecklist.id ?? '');
      // id 로 체크리스트 삭제
      //   Future<void> deleteMyChecklist(String id) async {
      //await _repository.deleteMyChecklist(_myChecklist.id ?? '');
  });
}
