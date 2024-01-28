import 'package:flutter/material.dart';
import '../main.dart';
import '../ui/helper/salvador_dali_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/image_container.dart';
class SalvadorDali extends StatefulWidget{
  const SalvadorDali({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<SalvadorDali> createState() => _SalvadorDaliState();
}
class _SalvadorDaliState extends State<SalvadorDali> {
  late Future<SingleChildScrollView> taskFuture;
  @override
  void initState(){
    super.initState();
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      SalvadorDaliVariables.dateColor,
      SalvadorDaliVariables.taskColor,
      SalvadorDaliVariables.textColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SalvadorDaliVariables.taskColor,
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
        imageUrl: 'assets/images/Dali/6.jpg',
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
  backgroundColor: SalvadorDaliVariables.dateColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);