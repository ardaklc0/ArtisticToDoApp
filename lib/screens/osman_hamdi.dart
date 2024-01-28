import 'package:flutter/material.dart';
import '../ui/helper/osman_hamdi_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
import '../main.dart';
class OsmanHamdi extends StatefulWidget {
  const OsmanHamdi({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<OsmanHamdi> createState() => _OsmanHamdiState();
}
class _OsmanHamdiState extends State<OsmanHamdi> {
  late Future<SingleChildScrollView> taskFuture;
  @override
  void initState(){
    super.initState();
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      OsmanHamdiVariables.dateColor,
      OsmanHamdiVariables.taskColor,
      OsmanHamdiVariables.textColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: OsmanHamdiVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: _body(deviceWidth, taskFuture, context),
      floatingActionButton: _floatingActionButton(context)
    );
  }
}
Widget _body(double deviceWidth, Future<SingleChildScrollView> taskFuture, BuildContext context) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const ImageContainer(
        imageUrl: 'assets/images/Osman Hamdi Bey/1.jpg',
        imageAlignment: Alignment(0, -1),
      ),
      Flexible(
          child: FutureBuilder<SingleChildScrollView>(
            future: taskFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
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
);
Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
  backgroundColor: OsmanHamdiVariables.dateColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);