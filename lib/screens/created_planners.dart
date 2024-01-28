import 'package:flutter/material.dart';
import 'package:pomodoro2/ui/helper/common_functions_planner.dart';
import '../ui/helper/common_variables.dart';
import 'package:pomodoro2/ui/widgets/common_widgets.dart';
import '../ui/helper/created_planner_variables.dart';
class CreatedPlanners extends StatefulWidget {
  const CreatedPlanners({super.key});
  @override
  State<CreatedPlanners> createState() => _CreatedPlannersState();
}
class _CreatedPlannersState extends State<CreatedPlanners> {
  late Future<List<ElevatedButton>> addCreatedPlanners;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: homePageColor,
      body: _body(deviceWidth, deviceHeight, context),
      floatingActionButton: _floatingActionButton(context)
    );
  }
}

Widget _body(double deviceWidth, double deviceHeight,BuildContext context) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SingleChildScrollView(
        child: SizedBox(
          width: deviceWidth,
          height: deviceHeight * 0.8,
          child: FutureBuilder<List<Container>>(
            future: fetchPlanners(context, deviceHeight),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return snapshot.data![index];
                  },
                );
              }
            },
          ),
        ),
      ),
    ],
  ),
);
Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
  backgroundColor: floatingActionButtonBackgroundColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);