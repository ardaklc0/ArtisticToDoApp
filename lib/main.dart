import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  final Color? textColor = Colors.white70;

  //TODO 01: Make the all height, width... variable.

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Image.asset(
                'assets/images/Gustav Klimt/1.jpg',
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(216, 162, 75, 1)
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              "Test",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              "Test",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.300,
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(241, 197, 80, 1)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Test",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(216, 162, 75, 1)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding:const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(
                                "Test",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                "Test",
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.300,
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(241, 197, 80, 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Test",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
