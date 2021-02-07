import 'package:flutter/material.dart';
import 'package:gharpay/models/active_work_model.dart';
import 'package:timelines/timelines.dart';

class StatusStepper extends StatelessWidget {
  List<Step> steps = [
    Step(
      title: Text("ACCEPTED"),
      content: Text("Your work is accepted"),
      isActive: true,
    ),
    Step(
      title: Text("STARTED"),
      content: Text("Your work is started"),
      isActive: true,
    ),
    Step(
      title: Text("COMPLETED"),
      content: Text("Your work has been completed\n Payment Required."),
      isActive: true,
    ),
    Step(
      title: Text("FINISHED"),
      content: Text("Your work has finished."),
      isActive: true,
    ),
  ];

  final ActiveWork activeWork;

  StatusStepper({this.activeWork});

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      scrollDirection: Axis.horizontal,
      builder: TimelineTileBuilder.fromStyle(
        contentsAlign: ContentsAlign.alternating,
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Timeline Event $index'),
        ),
        itemCount: 5,
      ),
    );
  }
}
