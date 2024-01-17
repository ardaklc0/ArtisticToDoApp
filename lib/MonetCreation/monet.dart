import 'package:flutter/material.dart';
import 'package:pomodoro2/MonetCreation/monet_variables.dart';
import '../main.dart';
import '../image_container.dart';

class Monet extends StatefulWidget {
  const Monet({super.key, required this.title});
  final String title;

  @override
  State<Monet> createState() => _MonetState();
}

class _MonetState extends State<Monet> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageContainer(
              imageUrl: 'assets/images/Monet/1.jpg',
              imageAlignment: const Alignment(0, -1),
              scaleOfImage: deviceWidth * 0.009,
            ),
            Flexible(
                child: FutureBuilder<Widget>(
                  future: createTask(
                    MonetVariables.dateColor,
                    MonetVariables.taskColor,
                    MonetVariables.textColor,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container();
                    }
                  },
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MonetVariables.dateColor,
        child: const Icon(
            Icons.home_filled
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}