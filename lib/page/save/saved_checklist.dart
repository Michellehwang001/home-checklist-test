import 'package:flutter/material.dart';
import 'package:home_checklist/model/checklist_model.dart';
import 'package:home_checklist/model/my_checklist.dart';
import 'package:home_checklist/viewmodel/checklist_view_model.dart';
import 'package:provider/provider.dart';

class SavedChecklist extends StatefulWidget {
  SavedChecklist({Key? key, required this.myChecklist}) : super(key: key);
  final MyChecklist myChecklist;

  @override
  _SavedChecklistState createState() => _SavedChecklistState(myChecklist: myChecklist);
}

class _SavedChecklistState extends State<SavedChecklist> {
  _SavedChecklistState({required this.myChecklist});
  final MyChecklist myChecklist;

  // myChecklist.mainChecked / subChecked
  List<String> mainChecked = [];
  List<String> subChecked = [];

  @override
  void initState() {
    // 카테고리에 따른 checklist 가져온다.
    super.initState();
    context
        .read<ChecklistViewModel>()
        .getCategory(myChecklist.housing ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final _checklistViewModel = context.watch<ChecklistViewModel>();
    final isLoading = _checklistViewModel.isloading;

    if (isLoading == false) {
      mainChecked = myChecklist.mainChecked!.split(",");
      subChecked = myChecklist.subChecked!.split(",");
      print(mainChecked);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.myChecklist.alias}'),
        elevation: 0,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('상태 체크', style: TextStyle(fontSize: 20,),),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _checklistViewModel.checklist.length,
                  itemBuilder: (_, index) {
                    // mainChecked 리스트에 포함된 체크리스트가 있으면 즉. 내가 체크한 것
                    if (_checklistViewModel.checklist[index].article == 'main' && mainChecked.contains(_checklistViewModel.checklist[index].index.toString())) {
                       return _buildListTile(_checklistViewModel.checklist[index]);
                    }
                    return Center();
                  },
              ),
            ),
            Text('시설 체크', style: TextStyle(fontSize: 20,),),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _checklistViewModel.checklist.length,
                itemBuilder: (_, index) {
                  // mainChecked 리스트에 포함된 체크리스트가 있으면 즉. 내가 체크한 것
                  if (_checklistViewModel.checklist[index].article == 'sub' && subChecked.contains(_checklistViewModel.checklist[index].index.toString())) {
                    return _buildListTile(_checklistViewModel.checklist[index]);
                  }
                  return Center();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(ChecklistModel checklist) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            onChanged: null,
            value: true,
          ),
          title: Text(checklist.title ?? ''),
        ),
        Divider(),
      ],
    );
  }
}
