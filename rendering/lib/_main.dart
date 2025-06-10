import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Render performance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _secondCounter = ValueNotifier(0);

  void _incrementSecondCounter() {
    _secondCounter.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Render performance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 20),
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
            const ContainerOne(),

            // Dynamic section
            // Container 2: consider this a part that changes frequently
            ValueListenableBuilder(
              valueListenable: _secondCounter,
              builder: (_, count, __) => Container(
                color: count % 2 == 0 ? Colors.red : Colors.green,
                padding: const EdgeInsets.all(30),
                child: RepaintBoundary(
                  child: ContainerTwo(
                    count,
                    _incrementSecondCounter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerOne extends StatefulWidget {
  const ContainerOne({super.key});

  @override
  State<ContainerOne> createState() => _ContainerOne();
}

class _ContainerOne extends State<ContainerOne> {
  int _firstCounter = 0;

  void _incrementFirstCounter() {
    setState(() {
      _firstCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          const Text(
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
          RepaintBoundary(
            child: Column(
              children: <Widget>[
                const ExpensiveWidget(1),
                const ExpensiveWidget(2),
                const ExpensiveWidget(3),
                const ExpensiveWidget(4),
                const ExpensiveWidget(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
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
}

class ContainerTwo extends StatelessWidget {
  const ContainerTwo(
    this._count,
    this._incrementSecondCounter, {
    super.key,
  });

  final int _count;
  final Function() _incrementSecondCounter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'This widget updates frequently',
          style: TextStyle(fontSize: 24),
        ),
        ElevatedButton(
          onPressed: _incrementSecondCounter,
          child: Text('Increment Counter'),
        ),
        Text(
          'Counter: $_count',
          style: TextStyle(fontSize: 20),
        ),
        StaticListView(),
      ],
    );
  }
}

class StaticListView extends StatelessWidget {
  const StaticListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(title: Text('Item $index'));
      },
    );
  }
}
