import 'package:flutter/material.dart';
import 'package:pomodoro2/MonetCreation/monet_variables.dart';
import 'package:pomodoro2/SalvadorDaliCreation/salvador_dali_variables.dart';
import '../main.dart';
import '../image_container.dart';

class SalvadorDali extends StatefulWidget {
  const SalvadorDali({super.key, required this.title});
  final String title;

  @override
  State<SalvadorDali> createState() => _SalvadorDaliState();
}

class _SalvadorDaliState extends State<SalvadorDali> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SalvadorDaliVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ImageContainer(
              imageUrl: 'assets/images/Dali/6.jpg',
              imageAlignment: Alignment(0, -1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SalvadorDaliVariables.dateColor,
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
