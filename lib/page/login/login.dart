import 'package:flutter/material.dart';
import 'package:home_checklist/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _pwController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel = context.read<LoginViewModel>();

    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/login/home_checklist_logo.png'),),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '이메일을 입력하세요';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFE8E8E8), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'E-mail 을 입력해 주세요.',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _pwController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '비밀번호를 입력하세요';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFE8E8E8), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: '비밀번호를 입력해 주세요.',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '회원가입',
                  style: TextStyle(color: Colors.indigo),
                ),
                Text(
                  '비밀번호찾기',
                  style: TextStyle(color: Colors.indigo),
                ),
                SizedBox(width: 20.0,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('로그인'),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(child: Text('Google로 로그인', style: TextStyle(color: Colors.indigo),),
                onTap: () {
                  loginViewModel.login();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
