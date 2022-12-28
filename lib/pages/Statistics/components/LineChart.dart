import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final List<int> data;
  const LineChartSample2({super.key, required this.data});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff00B4DB),
    const Color(0xff0083B0),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: LineChart(
        mainData(),
      ),
    );
  }

  final monthLabel = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  final weekLabel = [
    "W1",
    "W2",
    "W3",
    "W4",
  ];
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text = Text('', style: style);
    if (value.toInt() < widget.data.length && value.toInt() % 2 == 0) {
      text = Text(monthLabel[value.toInt()], style: style);
    }
    if (value.toInt() < widget.data.length && widget.data.length == 4) {
      text = Text(weekLabel[value.toInt()], style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      // case 7:
      //   text = '7';
      //   break;
      case 14:
        text = '14';
        break;
      // case 21:
      //   text = '21';
      //   break;
      case 31:
        text = '31';
        break;
      default:
        // text = '50k';
        text = '';
    }
    if (widget.data.length == 4) {
      switch (value.toInt()) {
        case 0:
          text = '0';
          break;
        case 7:
          text = '7';
          break;
        case 3:
          text = '3';
          break;
      }
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    final int maxY = widget.data.length == 4 ? 8 : 32;
    final int maxX = widget.data.length - 1;
    final int minX = 0;
    final int minY = 0;
    final List<FlSpot> spots = widget.data
        .asMap()
        .keys
        .map((e) => FlSpot(e.toDouble(), widget.data[e].toDouble()))
        .toList();
    return LineChartData(
      gridData: FlGridData(
          show: true,
          horizontalInterval: widget.data.length == 4 ? 1 : 7,
          drawVerticalLine: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 26,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.transparent),
      ),
      minX: minX.toDouble(),
      maxX: maxX.toDouble(),
      minY: minY.toDouble(),
      maxY: maxY.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          // barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .asMap()
                  .entries
                  .map((element) => element.value.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
