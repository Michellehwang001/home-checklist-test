import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_checklist/model/my_checklist.dart';

class MyChecklistRepository {
  final CollectionReference<MyChecklist> _checklistRef;

  MyChecklistRepository({FirebaseFirestore? firebaseFirestore})
      : _checklistRef = (firebaseFirestore ?? FirebaseFirestore.instance)
            .collection('my_checklist')
            .withConverter(
                fromFirestore: (snapshot, _) =>
                    MyChecklist.fromJson(snapshot.data()),
                toFirestore: (myChecklist, _) => myChecklist.toJson());

  // my_checklist 저장하기
  Future<bool> saveChecklist(MyChecklist myChecklist) async {
    try {
      var resultDoc = await _checklistRef.add(myChecklist);
      // id update
      _checklistRef.doc(resultDoc.id).update({'id': resultDoc.id}).then((value) => print("id update 완료"));
    } catch (e) {
      print('Error : $e');
      return false;
    }

    return true;
  }

  // my_checklist 이메일별로 읽어오기
  Future<List<MyChecklist>> getChecklists(String email) async {
    // time 내림차순으로 수정하니 firebase 색인 생성..
    final checkLists = await _checklistRef
        .where('email', isEqualTo: email)
        .orderBy('time', descending: true)
        .get();

    return checkLists.docs.map((e) => e.data()).toList();
  }

  // my_checklist ID로 읽어오기
  Future<MyChecklist?> getChecklist(String id) async {
    var getChecklist = await _checklistRef.doc(id).get();
    if (getChecklist.data()!.id!.isNotEmpty) {
      return getChecklist.data();
    }
    // final checkList = await _checklistRef.get();
    // return checkList.docs
    //     .where((e) => e.id == id)
    //     .map((e) => e.data())
    //     .toList();
  }

  // id 로 체크리스트 삭제
  // 가져와서 id 비교하므로 가져올 때 같은 email 로 가져오게끔 수정하든지. 처음부터 doc_id를 id 값으로 넣던지..
  Future<void> deleteMyChecklist(String docId) async {
    return _checklistRef
      .doc(docId)
      .delete()
      .then((value) => print("Checklist Deleted"))
      .catchError((error) => print("Failed to delete my checklist : $error"));
  }
}
