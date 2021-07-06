import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: Home()));

// 비니지스 로직 클래스를 만들고, 모든 변수, 함수, 컨트롤러를 포함
// .obs는 간단히 모든 변수를 observable로 만들 수 있음
class Controller extends GetxController {
  var count = 1.obs;
  increment() => count++;
}

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller c = Get.put(Controller());

    return Scaffold(
        // count가 변경 될 때마다 Obx(()=> 를 사용하여 Text()에 업데이트합니다.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
        body: Center(
          child: ElevatedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other())),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 업데이트된 count 변수에 연결
    return Scaffold(
      appBar: AppBar(
        title: Text("just first other page"),
      ),
      body: Center(
        //Obx(() => Text()) 요렇게 가면 계속 업데이트가 된다.
        child: Column(
          children: [
            Obx(() => Text("${c.count}")),
            ElevatedButton(
              onPressed: () => Get.to(Other2()),
              child: Text("Go to one more"),
            )
          ],
          /*Obx(
            () => Text("${c.count}"),
          ),*/
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment),
    );
  }
}

class Other2 extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 업데이트된 count 변수에 연결
    return Scaffold(
      appBar: AppBar(
        title: Text("just second other page"),
      ),
      body: Center(
        //Obx(() => Text()) 요렇게 가면 계속 업데이트가 된다.
        child: Column(
          children: [
            Obx(() => Text("${c.count}")),
            ElevatedButton(
              onPressed: () => Get.to(Other()),
              child: Text("Go to one more"),
            )
          ],
          /*Obx(
            () => Text("${c.count}"),
          ),*/
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment),
    );
  }
}

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
