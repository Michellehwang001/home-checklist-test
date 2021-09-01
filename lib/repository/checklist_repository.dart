import 'package:home_checklist/model/checklist_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistRepository {
  final CollectionReference<ChecklistModel> _checklistRef;

  ChecklistRepository({FirebaseFirestore? firebaseFirestore})
      : _checklistRef = (firebaseFirestore ?? FirebaseFirestore.instance).collection('checklist').withConverter(fromFirestore: (snapshot, _) => ChecklistModel.fromJson(snapshot.data()!),
      toFirestore: (list, _) => list.toJson());

  // final checklistRef =
  // FirebaseFirestore.instance.collection('checklist').orderBy("index").withConverter(
  //   fromFirestore: (snapshot, _) => ChecklistModel.fromJson(snapshot.data()!),
  //   toFirestore: (list, _) => list.toJson(),
  // );

  Future<List<ChecklistModel>> getAll() async {
    final checkLists = await _checklistRef.orderBy('index').get();

    return checkLists.docs.map((e) => e.data()).toList();
  }

  Future<List<ChecklistModel>> getCategory(String category) async {
    final checkLists = await _checklistRef.orderBy('index').get();

    return checkLists.docs.where((e) => e.data().housing == category).map((e) => e.data()).toList();
  }

  Future add(ChecklistModel item) async {
    await _checklistRef.add(item);
  }
}