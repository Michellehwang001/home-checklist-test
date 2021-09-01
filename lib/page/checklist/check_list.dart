import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_checklist/model/checklist_model.dart';
import 'package:home_checklist/model/my_checklist.dart';
import 'package:home_checklist/page/save/saved_list.dart';
import 'package:home_checklist/viewmodel/checklist_view_model.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:home_checklist/viewmodel/my_checklist_view_model.dart';
import 'package:provider/provider.dart';

class CheckList extends StatefulWidget {
  CheckList({Key? key, required this.pageIndex, required this.currentCategory})
      : super(key: key);
  final int pageIndex;
  final String? currentCategory;

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  MyChecklistViewModel _myChecklistViewModel = MyChecklistViewModel();
  String _stringList = '';
  String _subStringList = '';
  List<ChecklistModel> _mainChecklist = [];
  List<ChecklistModel> _subChecklist = [];

  late TextEditingController _aliasController;
  late TextEditingController _positionController;

  // final Set<int> initialSelectedValues;
  final Set<int> _selectedValues = Set<int>();
  final Set<int> _selectedSubValues = Set<int>();

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController();
    _positionController = TextEditingController();
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _positionController.dispose();
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
    String appBarTitle = widget.currentCategory == 'C01'
        ? '원룸'
        : widget.currentCategory == 'C02'
            ? '오피스텔'
            : widget.currentCategory == 'C03'
                ? '아파트'
                : '빌라/투룸';

    // provider 정보 가져오기
    final _loginViewModel = context.read<LoginViewModel>();
    final _checklistViewModel = context.read<ChecklistViewModel>();

    _mainChecklist = _checklistViewModel.checklist
        .where((e) => e.article == 'main')
        .toList();
    _subChecklist =
        _checklistViewModel.checklist.where((e) => e.article == 'sub').toList();

    return DefaultTabController(
      initialIndex: widget.pageIndex,
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // 데이터 체크하기
            if (_aliasController.text.trim() == '') {
              showSnackBar('별칭을 입력해 주세요 ^^');
            } else {
              if (_selectedValues.length > 0) {
                // 1,2,3 String 형태로 변환
                _stringList = _selectedValues.join(",");
              }
              if (_selectedSubValues.length > 0) {
                // 1,2,3 String 형태로 변환
                _subStringList = _selectedSubValues.join(",");
              }
              // MyChecklist 만들기
              MyChecklist _myChecklist = MyChecklist(
                  _loginViewModel.user!.email,
                  _aliasController.text,
                  widget.currentCategory,
                  _stringList,
                  _subStringList,
                  DateTime.now().millisecondsSinceEpoch);

              bool _result = await _myChecklistViewModel.saveMyChecklist(_myChecklist);
              if (_result == true) {
                showSnackBar('체크리스트가 저장 되었습니다.');
              }
              else {
                showSnackBar('체크리스트 저장 실패하였습니다.');
              }


              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SavedList()),
              );
            }
          },
          child: Icon(Icons.save),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: TextField(
                controller: _aliasController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lightbulb_outline),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFE8E8E8), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: '저장할 별칭을 입력해주세요.',
                ),
              ),
            ),
            // 주소는 다음 버전에~
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
            //   child: TextField(
            //     controller: _positionController,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.map_outlined),
            //       border: OutlineInputBorder(
            //           borderSide: const BorderSide(
            //               color: Color(0xFFE8E8E8), width: 1.0),
            //           borderRadius: BorderRadius.circular(10.0)),
            //       hintText: '주소를 남기시겠습니까?',
            //     ),
            //   ),
            // ),
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
                            itemBuilder: (BuildContext context, int index) =>
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
    // tabIndex : main / sub
    var checked = _selectedValues.contains(item.index);

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
          _selectedValues.add(itemValue!);
        } else {
          _selectedSubValues.add(itemValue!);
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
