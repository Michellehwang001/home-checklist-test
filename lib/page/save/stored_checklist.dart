import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_checklist/model/checklist_model.dart';
import 'package:home_checklist/viewmodel/checklist_view_model.dart';
import 'package:provider/provider.dart';

class StoredChecklist extends StatefulWidget {
  StoredChecklist({Key? key, required this.myChecklist, this.housing}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> myChecklist;
  final housing;

  @override
  _StoredChecklistState createState() => _StoredChecklistState();
}

class _StoredChecklistState extends State<StoredChecklist> {
  List<int> _selectedSubValues = [];
  List<int> _selectedValues = [];
  // Set<int> _selectedValues = Set<int>();
  // Set<int> _selectedSubValues = Set<int>();

  @override
  void initState() {
    super.initState();
    // housing 별 체크리스트를 가져온다.
    context.read<ChecklistViewModel>().getCategory(widget.housing);

    // print('--> ${widget.myChecklist.data()['mainChecked']}');

    if (widget.myChecklist.data()['mainChecked'].toString().isNotEmpty == true) {
      _selectedValues = widget.myChecklist.data()['mainChecked'].toString().split(',').map((e) => int.parse(e)).toList();
    }
    if ( widget.myChecklist.data()['subChecked'].toString().isNotEmpty == true) {
      _selectedSubValues = widget.myChecklist.data()['subChecked'].toString().split(',').map((e) => int.parse(e)).toList();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text('$message'),
      action: SnackBarAction(
        label: '취소',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {

    // appBarTitle 만들기
    String appBarTitle = widget.myChecklist['housing'] == 'C01'
        ? '원룸'
        : widget.myChecklist['housing'] == 'C02'
            ? '오피스텔'
            :  widget.myChecklist['housing'] == 'C03'
                ? '아파트'
                : '빌라/투룸';
    appBarTitle = appBarTitle + '- ${widget.myChecklist['alias']}';

    // provider 정보 가져와서 main 체크리스트와 sub 체크리스트 만들기
    final _checklistViewModel = context.watch<ChecklistViewModel>();
    final _mainChecklist = _checklistViewModel.checklist
        .where((e) => e.article == 'main')
        .toList();
    final _subChecklist =
        _checklistViewModel.checklist.where((e) => e.article == 'sub').toList();
    // print('_mainChecklist ${_mainChecklist.length}');

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(appBarTitle),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 75,
              child: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      CupertinoIcons.doc_checkmark,
                      size: 30,
                    ),
                    text: '상태체크',
                  ),
                  Tab(
                    icon: Icon(
                      CupertinoIcons.checkmark_square,
                      size: 30,
                    ),
                    text: '시설체크',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // checkList 시작
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: _mainChecklist.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index)=>
                                _buildItem(_mainChecklist[index], 'main'),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // checkList 시작
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: _subChecklist.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                _buildItem(_subChecklist[index], 'sub'),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // checkbox ListTile 만들기
  Widget _buildItem(ChecklistModel item, String tabIndex) {
    bool checked = false;

    // print('item.index --> ${item.index}');
    // print('_selectedValues--> $_selectedValues, _selectedSubValues--> $_selectedSubValues');

    if (tabIndex == 'main') {
      checked = _selectedValues.contains(item.index);
    }
    // 시설체크
    if (tabIndex == 'sub') {
      checked = _selectedSubValues.contains(item.index);
    }

    return ListTile(
      tileColor: checked == true
          ? (tabIndex == 'main')
              ? Color(0xFFDBEDFD)
              : Color(0xFFFCEFCA)
          : null,
      leading: Checkbox(
        activeColor: tabIndex == 'sub' ? Colors.orange : null,
        onChanged: (value) =>
            _onItemCheckedChange(item.index, value!, tabIndex),
        value: checked,
      ),
      title: Text('${item.title}'),
      onTap: () {
        _onItemCheckedChange(item.index, !checked, tabIndex);
      },
    );
  }

  // CheckBox 값 변경
  void _onItemCheckedChange(int? itemValue, bool checked, String tabIndex) {
    setState(() {
      if (checked) {
        if (tabIndex == 'main') {
          _selectedValues.add(itemValue ?? 0);
        } else {
          _selectedSubValues.add(itemValue ?? 0);
        }
      } else {
        if (tabIndex == 'main') {
          _selectedValues.remove(itemValue);
        } else {
          _selectedSubValues.remove(itemValue);
        }
      }
    });
    if (tabIndex == 'main') {
      print('_selectedValues--> $_selectedValues');
    } else {
      print('_selectedSubValues--> $_selectedSubValues');
    }
  }
}
