import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formをkeyで管理する'),
      ),
      body: Column(children: const [
        SampleFormWidget(),
      ]),
    );
  }
}

/// nameとemailを入力するフォーム
///
/// このフォームは、[GlobalKey]を使って、値を管理
///
/// [GlobalKey]を使うことで、フォームの値を取得できる
///
/// 送信ボタンを押したときに、フォームの値をデバッグで出力する
class SampleFormWidget extends StatefulWidget {
  const SampleFormWidget({super.key});

  @override
  State<SampleFormWidget> createState() => _SampleFormWidgetState();
}

class _SampleFormWidgetState extends State<SampleFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _nameKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                key: _nameKey,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(), // 外枠付きデザイン
                  filled: true, // fillColorで指定した色で塗り潰し
                  fillColor: Colors.blue,
                  labelText: "User Name",
                  hintText: 'Enter your name',
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: _emailKey,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(), // 外枠付きデザイン
                  filled: true, // fillColorで指定した色で塗り潰し
                  fillColor: Colors.greenAccent,
                  labelText: "Email address form",
                  hintText: 'Enter your email',
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // 各Fieldのvalidatorを呼び出す
                  if (_formKey.currentState!.validate()) {
                    // 入力データが正常な場合の処理
                    _formKey.currentState!.save();
                  }
                  // ValueKeyで指定した値を出力する
                  debugPrint('email: ${_emailKey.currentState!.value}');
                  debugPrint('name: ${_nameKey.currentState!.value}');
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
