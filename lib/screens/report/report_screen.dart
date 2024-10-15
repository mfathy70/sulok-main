import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/app_colors.dart';
import 'package:sulok/helper/custom/default_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../helper/custom/custom_drop_down.dart';
import '../../helper/local_storage_helper.dart';
import '../login/model/login_teacher_respone.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<ReportScreen> {
  List<Color> gradientColors = [
    AppColors.greenMain,
    AppColors.greenMain,
  ];
  List<Color> gradientColors2 = [
    AppColors.amberSecond,
    AppColors.amberSecond,
  ];

  bool showAvg = false;
  List<Item> data = [];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    var teacherData = await LocalStorageHelper.getTeacherData();
    teacherData.report?.reportData?.forEach((key, value) {
      data.add(Item(name: key, id: value));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      title: 'التقارير',
      onTapBack: () {
        Get.back();
      },
      child: SafeArea(
        child: Column(
          children: [
            // AspectRatio(
            //   aspectRatio: 2,
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //       right: 0,
            //       left: 0,
            //       top: 24,
            //       bottom: 12,
            //     ),
            //     child: SizedBox(
            //       width: Get.width,
            //       height: 150,
            //       child: Stack(
            //         children: [
            //           LineChart(
            //             mainData(),
            //           ),
            //           IgnorePointer(
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: Container(
            //                 height: 200,
            //                 width: 100,
            //                 decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                     begin: Alignment.centerLeft,
            //                     end: Alignment.centerRight,
            //                     colors: [
            //                       AppColors.whiteGrey,
            //                       AppColors.whiteGrey.withOpacity(0.9),
            //                       AppColors.whiteGrey.withOpacity(0.8),
            //                       AppColors.whiteGrey.withOpacity(0.7),
            //                       AppColors.whiteGrey.withOpacity(0.6),
            //                       AppColors.whiteGrey.withOpacity(0.5),
            //                       AppColors.whiteGrey.withOpacity(0.4),
            //                       AppColors.whiteGrey.withOpacity(0.3),
            //                       AppColors.whiteGrey.withOpacity(0.2),
            //                       AppColors.whiteGrey.withOpacity(0.1),
            //                       AppColors.whiteGrey.withOpacity(0.02),
            //                       AppColors.whiteGrey.withOpacity(0.0),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           IgnorePointer(
            //             child: Align(
            //               alignment: Alignment.centerRight,
            //               child: Container(
            //                 height: 200,
            //                 width: 100,
            //                 decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                     begin: Alignment.centerRight,
            //                     end: Alignment.centerLeft,
            //                     colors: [
            //                       AppColors.whiteGrey,
            //                       AppColors.whiteGrey.withOpacity(0.9),
            //                       AppColors.whiteGrey.withOpacity(0.8),
            //                       AppColors.whiteGrey.withOpacity(0.7),
            //                       AppColors.whiteGrey.withOpacity(0.6),
            //                       AppColors.whiteGrey.withOpacity(0.5),
            //                       AppColors.whiteGrey.withOpacity(0.4),
            //                       AppColors.whiteGrey.withOpacity(0.3),
            //                       AppColors.whiteGrey.withOpacity(0.2),
            //                       AppColors.whiteGrey.withOpacity(0.1),
            //                       AppColors.whiteGrey.withOpacity(0.02),
            //                       AppColors.whiteGrey.withOpacity(0.0),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // FutureBuilder(
            //     future: LocalStorageHelper.getTeacherData(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<LoginTeacherResponse> snapshot) {
            //       return Text(
            //           snapshot.data?.report?.reportData.toString() ?? "");
            //     }),

            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                borderWidth: 8,
                palette: const [AppColors.amberSecond],
                // Chart title
                title: ChartTitle(text: 'تقرير المهام اليومية'),
                // Enable legend
                legend: Legend(isVisible: false),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Item, String>>[
                  LineSeries<Item, String>(
                      dataSource: data,
                      xValueMapper: (Item sales, _) => sales.name,
                      yValueMapper: (Item sales, _) => int.parse(sales.id!),
                      name: '',
                      xAxisName: '',
                      width: 2,
                      enableTooltip: true,
                      // dataLabelMapper:(Item sales, _) =>sales.name ,
                      markerSettings: const MarkerSettings(
                          width: 20,
                          height: 20,
                          color: AppColors.greenMain,
                          borderWidth: 4,
                          borderColor: AppColors.white,
                          isVisible: true),
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(
                          isVisible: false,
                          builder: (dyn1, dyn2, dyn3, int in1, int in2) {
                            return Container(
                              height: 20,
                              width: 30,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(55),
                                  color: AppColors.white),
                              child: Center(child: Text(in1.toString())),
                            );
                          }))
                ]),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text = Text('$value', style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        drawHorizontalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 3),
            FlSpot(2, 2),
            FlSpot(3, 6),
            FlSpot(4, 2),
            FlSpot(5, 3),
            FlSpot(6, 2),
            FlSpot(7, 3),
            FlSpot(8, 3),
            FlSpot(9, 4),
            FlSpot(10, 3),
            FlSpot(11, 7),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors2,
          ),
          barWidth: 0,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors2
                  .map((color) => color.withOpacity(0.9))
                  .toList(),
            ),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 2),
            FlSpot(2, 6),
            FlSpot(3, 3),
            FlSpot(4, 4),
            FlSpot(5, 2),
            FlSpot(6, 2),
            FlSpot(7, 5),
            FlSpot(8, 3),
            FlSpot(9, 2),
            FlSpot(10, 3),
            FlSpot(11, 7),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 0,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.4))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class LineChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Size size;

  LineChart({required this.data, required this.labels, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: LineChartPainter(data, labels),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;

  LineChartPainter(this.data, this.labels);

  @override
  void paint(Canvas canvas, Size size) {
    final double paddingTop = 20;
    final double paddingBottom = 40;
    final double paddingLeft = 40;
    final double paddingRight = 20;

    final double chartWidth = size.width - paddingLeft - paddingRight;
    final double chartHeight = size.height - paddingTop - paddingBottom;

    // Draw x-axis
    canvas.drawLine(
      Offset(paddingLeft, size.height - paddingBottom),
      Offset(size.width - paddingRight, size.height - paddingBottom),
      Paint()..color = Colors.black,
    );

    // Draw y-axis
    canvas.drawLine(
      Offset(paddingLeft, paddingTop),
      Offset(paddingLeft, size.height - paddingBottom),
      Paint()..color = Colors.black,
    );

    final double xInterval = chartWidth / (labels.length - 1);

    // Plot data points and connect with lines
    Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < data.length; i++) {
      double x = paddingLeft + i * xInterval;
      double y =
          size.height - paddingBottom - (data[i] / _maxData() * chartHeight);

      if (i < data.length - 1) {
        double nextX = paddingLeft + (i + 1) * xInterval;
        double nextY = size.height -
            paddingBottom -
            (data[i + 1] / _maxData() * chartHeight);
        canvas.drawLine(Offset(x, y), Offset(nextX, nextY), linePaint);
      }

      // Draw data point circles
      canvas.drawCircle(Offset(x, y), 4, linePaint);

      // Draw labels on x-axis
      TextPainter(
        text: TextSpan(text: labels[i], style: TextStyle(fontSize: 12)),
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: xInterval)
        ..paint(
            canvas, Offset(x - xInterval / 2, size.height - paddingBottom + 5));

      // Draw values on y-axis
      TextPainter(
        text: TextSpan(text: '${data[i]}%', style: TextStyle(fontSize: 12)),
        textDirection: TextDirection.ltr,
      )
        ..layout()
        ..paint(canvas, Offset(paddingLeft - 30, y - 8));
    }
  }

  double _maxData() {
    return data.reduce((max, element) => element > max ? element : max);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
