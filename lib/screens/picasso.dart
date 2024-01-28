import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/picasso_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class Picasso extends StatefulWidget {
  const Picasso({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;

  @override
  State<Picasso> createState() => _PicassoState();
}
class _PicassoState extends State<Picasso> {
  late Future<SingleChildScrollView> taskFuture;
  @override
  void initState(){
    super.initState();
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      PicassoVariables.dateColor,
      PicassoVariables.taskColor,
      PicassoVariables.textColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: PicassoVariables.taskColor,
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
        imageUrl: 'assets/images/Picasso/2.jpg',
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
  backgroundColor: PicassoVariables.dateColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);