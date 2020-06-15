import 'package:curso_1/layout.dart';
import 'package:curso_1/pages/ItemsLista.dart';
import 'package:curso_1/pages/config_page.dart';
import 'package:curso_1/pages/sobre.dart';
import 'package:flutter/material.dart';
import 'package:curso_1/pages/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder> {
    HomePage.tag: (context) => HomePage(),
    SobrePage.tag: (context) => SobrePage(),
    ConfigPage.tag: (context) => ConfigPage(),
    ItemsLista.tag: (context) => ItemsLista(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicativo teste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Layout.secondary(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        title: TextStyle(
          fontSize: 24.0,
          fontStyle: FontStyle.italic,
          color: Layout.primary()
        )
        ),
        
      ),
      
      
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomePage(),
      routes: routes,      
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
