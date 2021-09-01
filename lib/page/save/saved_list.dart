import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_checklist/page/save/stored_checklist.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:home_checklist/viewmodel/my_checklist_view_model.dart';
import 'package:provider/provider.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  bool alive = true;

  @override
  void initState() {
    super.initState();

    // // 내 체크리스트 목록 가져오기
    // final _email = context.read<LoginViewModel>().user!.email;
    //
    // // My Checklist 가져오기
    // if (_email.isNotEmpty) {
    //   context.read<MyChecklistViewModel>().getChecklists(_email);
    // }
  }

  @override
  Widget build(BuildContext context) {
    //final _myChecklistViewModel = context.watch<MyChecklistViewModel>();
    final _email = context.read<LoginViewModel>().user!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home CheckList',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('my_checklist')
                      .where('email', isEqualTo: _email)
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      print('snapshot Data 가 없습니다.');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var _items = snapshot.data?.docs ?? [];

                    return ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _items.length,
                      itemBuilder: (context, index) => _buildItem(context, _items[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, QueryDocumentSnapshot<Map<String, dynamic>> item) {

    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red[100],
          icon: Icons.delete,
          onTap: () {
            context.read<MyChecklistViewModel>().deleteChecklist(item['id'] ?? '');
          },
        ),
      ],
      child: ListTile(
        leading: Container(
          width: 80,
          child: Text(
            '${item['housing'] == 'C01' ? '원룸' : item['housing'] == 'C02' ? '오피스텔' : item['housing'] == 'C03' ? '아파트' : item['housing'] == 'C04' ? '빌라 / 투룸' : ''}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          '${item['alias']}',
          style: TextStyle(fontSize: 17.0),
        ),
        onTap: () {
          // MyChecklist _myCheckList = MyChecklist(item['id'], item[''], );
          //checklist
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoredChecklist(
                myChecklist: item,
                housing: item['housing'],
              ),
            ),
          );
        },
      ),
    );
  }
}
