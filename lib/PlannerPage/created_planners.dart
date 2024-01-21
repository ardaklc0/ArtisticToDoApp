import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/PlannerPage/planner_common_functions.dart';
import '../CreationPage/planner_entity.dart';
import '../CreationPage/planner_service.dart';
import '../GustavKlimtCreation/gustav_klimt.dart';
import '../MonetCreation/monet.dart';
import '../OsmanHamdiCreation/osman_hamdi.dart';
import '../PicassoCreation/picasso.dart';
import '../SalvadorDaliCreation/salvador_dali.dart';
import '../VanGoghCreation/van_gogh.dart';
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.black,
);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: deviceWidth * 0.7,
                height: deviceHeight * 0.3,
                child: FutureBuilder<List<ElevatedButton>>(
                  future: fetchPlanners(context),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          color: Colors.white,
          Icons.home_filled
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}