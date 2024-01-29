import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/slider_provider.dart';
import '../../../provider/time_provider.dart';

class TimeandRoundWidget extends StatelessWidget {
  const TimeandRoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<SliderProvider>(context);
    return Column(
      children: [
        DurationWidget(
          title: 'Study Duration',
          sliderValue: SliderProvider.studyDurationSliderValue,
          max: 240,
          min: 1,
          updateValue: (newValue) {
            sliderProvider.updateWorkDurationSliderValue(newValue);
          },

          minText: 'min',
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DurationWidget extends StatelessWidget {
  DurationWidget({
    super.key,
    required this.title,
    required this.sliderValue,
    required this.max,
    required this.min,
    required this.updateValue,
    required this.minText,
  });
  final String title;
  final double max;
  final double min;
  int sliderValue;
  String minText;
  void Function(int newValue) updateValue;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final timerProvider = Provider.of<TimerProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 245, 234, 1),
            borderRadius: BorderRadius.circular(0.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 2.0,
                spreadRadius: 0.05,
              ),
            ],
          ),
          child: SizedBox(
            height: deviceHeight * 0.08,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: deviceWidth * 0.04,
                    ),
                  ),
                ),
                Slider(
                  activeColor: Colors.white,
                  label: "$sliderValue",
                  max: max,
                  min: min,
                  value: (sliderValue.toDouble() >= min && sliderValue.toDouble() <= max)
                      ? sliderValue.toDouble()
                      : min, // Set the initial value to min if it's outside the valid range
                  onChanged: (value) {
                    if (value >= min && value <= max) {
                      sliderValue = value.toInt();
                      updateValue(sliderValue);
                      timerProvider.resetTimer();
                    }
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Text('$sliderValue / ${max.toInt()} $minText')
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class TextWithPadding extends StatelessWidget {
  const TextWithPadding({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}