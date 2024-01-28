import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/monet_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class Monet extends StatefulWidget {
  const Monet({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;

  @override
  State<Monet> createState() => _MonetState();
}
class _MonetState extends State<Monet> {
  late Future<SingleChildScrollView> taskFuture;
  @override
  void initState(){
    super.initState();
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      MonetVariables.dateColor,
      MonetVariables.taskColor,
      MonetVariables.textColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MonetVariables.taskColor,
      resizeToAvoidBottomInset: true,
      body: _body(deviceWidth, taskFuture, context),
      floatingActionButton: _floatingActionButton(context)
    );
  }
}
Widget _body(double deviceWidth, Future<SingleChildScrollView> taskFuture, BuildContext context) =>Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const ImageContainer(
        imageUrl: 'assets/images/Monet/1.jpg',
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
  backgroundColor: MonetVariables.dateColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);