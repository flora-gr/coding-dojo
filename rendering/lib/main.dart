import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Render performance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _firstCounter = 0;
  int _secondCounter = 0;

  void _incrementFirstCounter() {
    setState(() {
      _firstCounter++;
    });
  }

  void _incrementSecondCounter() {
    setState(() {
      _secondCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Render performance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Center(
                child: Text(
                  'Everything rebuilds\non every button click!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // Expensive static section
            // Container 1: consider this a part that does not change often
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    'This part does not change often',
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: _incrementFirstCounter,
                    child: Text('Increment Counter'),
                  ),
                  Text(
                    'Counter: $_firstCounter',
                    style: TextStyle(fontSize: 20),
                  ),
                  Column(
                    children: List.generate(
                      5,
                      (index) => _buildExpensiveWidget(index),
                    ),
                  ),
                ],
              ),
            ),

            // Dynamic section
            // Container 2: consider this a part that changes frequently
            Container(
              color: _secondCounter % 2 == 0 ? Colors.red : Colors.green,
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Text(
                    'This widget updates frequently',
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: _incrementSecondCounter,
                    child: Text('Increment Counter'),
                  ),
                  Text(
                    'Counter: $_secondCounter',
                    style: TextStyle(fontSize: 20),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      print('List item $index rebuilt');
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildExpensiveWidget(int index) {
  // Simulate CPU work
  for (int i = 0; i < 1000000; i++) {
    // do nothing
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    height: 60,
    color: Colors.orange[100],
    child: Center(child: Text('Expensive Widget $index')),
  );
}
