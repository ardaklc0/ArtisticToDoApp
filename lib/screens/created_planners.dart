import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';
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
  void setStateWhenDelete(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: homePageColor,
      body: _body(deviceWidth, deviceHeight, context, setStateWhenDelete),
    );
  }


}

Widget _body(double deviceWidth, double deviceHeight,BuildContext context, Function setStateWhenDelete) => Stack(
  children: [
    FutureBuilder<List<Dismissible>>(
      future: fetchPlanners(context, deviceHeight, setStateWhenDelete),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(3, 2),
                const QuiltedGridTile(2, 2),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return snapshot.data![index];
            },
              childCount: snapshot.data?.length ?? 0,
            ),
          );
        }
      },
    ),
  ],
);