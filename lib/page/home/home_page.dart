import 'package:flutter/material.dart';
import 'package:home_checklist/page/checklist/check_list.dart';
import 'package:home_checklist/viewmodel/checklist_view_model.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends  StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery
        .of(context)
        .size;
    final _loginViewModel = context.watch<LoginViewModel>();
    final _checklistViewModel = context.read<ChecklistViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home CheckList',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: () {
            _loginViewModel.logout();
          }, icon: Icon(Icons.exit_to_app)),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      '${_loginViewModel.user?.profileUrl ??
                          'https://pbs.twimg.com/media/EfwsgQlUEAAwpvV.jpg'}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_loginViewModel.user?.name ?? 'Guest'}님 환영합니다!',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '어디를 둘러보실까요?',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    // checkList 한번 가져오기
                    if(await _checklistViewModel.getCategory('C01')) {
                      print('데이터 가져옴.');
                    }
                    // check list 페이지로 이동 housing 'C01' 원룸
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckList(pageIndex: 0, currentCategory: 'C01',)),
                    );
                  },
                  child: Container(
                    width: mediaSize.width / 2 - 30.0,
                    height: 230.0,
                    color: Color(0xFFFCEBE9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.home_outlined,
                                  size: 38.0,
                                  color: Colors.red,
                                ),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0.0),
                          child: Text(
                            '원룸',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              15.0, 10.0, 0, 10.0),
                          child: Text(
                            '원룸 볼때 옵션들을 \n체크하세요.',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFF09692),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // checkList 한번 가져오기
                    if(await _checklistViewModel.getCategory('C02')) {
                      print('데이터 가져옴.');
                    }
                    // check list 페이지로 이동 housing 'C01' 원룸
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckList(pageIndex: 0, currentCategory: 'C02',)),
                    );
                  },
                  child: Container(
                    width: mediaSize.width / 2 - 30.0,
                    height: 230.0,
                    color: Color(0xFFEBE4FD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.house_outlined,
                                  size: 38.0,
                                  color: Colors.deepPurple,
                                ),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0.0),
                          child: Text(
                            '오피스텔',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 10.0),
                          child: Text(
                            '오피스텔 볼때 \n이거 확인하셨나요?',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFAE91E9),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    // checkList 한번 가져오기
                    if(await _checklistViewModel.getCategory('C03')) {
                      print('데이터 가져옴.');
                    }
                    // check list 페이지로 이동 housing 'C01' 원룸
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckList(pageIndex: 0, currentCategory: 'C03',)),
                    );
                  },
                  child: Container(
                    width: mediaSize.width / 2 - 30.0,
                    height: 230.0,
                    color: Color(0xFFE7FEF0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.apartment_outlined,
                                  size: 38.0,
                                  color: Colors.green,
                                ),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0.0),
                          child: Text(
                            '아파트',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 10.0),
                          child: Text(
                            '아파트 볼 땐 \n여기~.',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF95BEA5),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // checkList 한번 가져오기
                    if(await _checklistViewModel.getCategory('C04')) {
                      print('데이터 가져옴.');
                    }
                    // check list 페이지로 이동 housing 'C01' 원룸
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckList(pageIndex: 0, currentCategory: 'C04',)),
                    );
                  },
                  child: Container(
                    width: mediaSize.width / 2 - 30.0,
                    height: 230.0,
                    color: Color(0xFFE5ECFD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.real_estate_agent_outlined,
                                  size: 38.0,
                                  color: Colors.blue,
                                ),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0.0),
                          child: Text(
                            '빌라/투룸',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 10.0),
                          child: Text(
                            '빌라/투룸/쓰리룸은 \n여기서 확인하세요.',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFB9ABEE),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
