import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_checklist/model/checklist_model.dart';
import 'package:home_checklist/repository/checklist_repository.dart';

void main() {
  group('checklist_repository', () {
    test('firesotre checklist 테스트', () async {
      final instance = FakeFirebaseFirestore();

      final repository = ChecklistRepository(firebaseFirestore: instance);

      expect((await repository.getAll()).length, 0);

      ChecklistModel item = ChecklistModel(100, 'test', 'aaa', 'aaa');
      repository.add(item);

      expect((await repository.getAll()).length, 1);

      expect((await repository.getCategory('aaa')).length, 1);
    });
  });
}