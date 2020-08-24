import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const yearTextStyle = TextStyle(
        fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 0),
                  FlSpot(1, 1),
                  FlSpot(2, 3),
                  FlSpot(3, 3),
                  FlSpot(4, 5),
                ],
                isCurved: false,
                barWidth: 1,
                colors: [
                  Colors.black,
                ],
                belowBarData: BarAreaData(
                  show: true,
                  colors: [Color(0xff63E2E0).withOpacity(0.4)],
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  colors: [Colors.red.withOpacity(0.6)],
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 6,
                  textStyle: yearTextStyle,
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return '2015';
                      case 1:
                        return '2016';
                      case 2:
                        return '2017';
                      case 3:
                        return '2018';
                      case 4:
                        return '2019';
                      default:
                        return '';
                    }
                  }),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '\₹ ${value * 2000}';
                },
              ),
            ),
            axisTitleData: FlAxisTitleData(
                leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: '',
                  margin: 10,
                  textStyle: yearTextStyle,
                ),
                bottomTitle: AxisTitle(
                    showTitle: true,
                    margin: 10,
                    titleText: '',
                    textStyle: yearTextStyle,
                    textAlign: TextAlign.center)),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 2 || value == 3 || value == 4;
              },
            ),
          ),
        ),
      ),
    );
  }
}
