import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChar extends StatelessWidget {
  final int projectEstimate;
  final int totalTask;
  const ProjectPieChar(
      {required this.projectEstimate, required this.totalTask, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final residual = projectEstimate - totalTask;
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                    value: totalTask.toDouble(),
                    color: Theme.of(context).primaryColor,
                    title: '${totalTask}h',
                    showTitle: true,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                PieChartSectionData(
                  value: residual.toDouble(),
                  color: Theme.of(context).primaryColorLight,
                  title: '${residual}h',
                  showTitle: true,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
