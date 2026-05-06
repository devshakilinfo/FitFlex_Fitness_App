import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:fit_flex3/features/statistic/controller/static_controller.dart'
    show StaticController;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ThisWeek extends StatelessWidget {
  ThisWeek({super.key});
  final staticController = Get.put(StaticController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            'Runs : ${staticController.totalRuns.value}',
            style: globalTextStyle(color: AppColors.textColor),
          ),
        ),
        const SizedBox(height: 6),
        Obx(
          () => Text(
            'Running Time : ${staticController.totalDuration.value}',
            style: globalTextStyle(
              color: AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.25,
          child: Obx(() {
            if (staticController.dates.isEmpty ||
                staticController.distances.isEmpty) {
              EasyLoading.show(status: 'Loading...');
              return Container();
            }
            EasyLoading.dismiss();
            List<FlSpot> spots = List.generate(
              staticController.dates.length,
              (index) => FlSpot(
                index.toDouble(),
                staticController.distances[index] / 1000,
              ),
            );

            return LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 22,
                      interval: 1,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                minX: 0,
                maxX: staticController.dates.length.toDouble() - 1,
                maxY:
                    staticController.distances.isNotEmpty
                        ? (staticController.distances.reduce(
                              (a, b) => a > b ? a : b,
                            ) /
                            1000)
                        : 10,
                minY:
                    staticController.distances.isNotEmpty
                        ? (staticController.distances.reduce(
                              (a, b) => a < b ? a : b,
                            ) /
                            1000)
                        : 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(strokeWidth: 0);
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(strokeWidth: 0);
                  },
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.flchartColor.withValues(alpha: 0.2),
                    barWidth: 2,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.flchartColor.withValues(alpha: 0.0),
                          AppColors.flchartColor2.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    dotData: const FlDotData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchSpotThreshold: 20,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(2)} km',
                          globalTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 15),
        // Dynamic Row for first chart
        Obx(() {
          // Fallback to default days if graphData is empty
          final days =
              staticController.graphData.isNotEmpty
                  ? staticController.graphData
                      .map((data) => data.dayOfWeek.substring(0, 3) ?? '')
                      .toList()
                  : ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => Text(
                days.length > index ? days[index] : '',
                style: globalTextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
        Text(
          'LB Growth : ${staticController.getLBGrowthStatus()}',
          style: globalTextStyle(
            color: AppColors.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Obx(
          () => Text(
            'Average LB pos : ${staticController.avgLBPosition.value}',
            style: globalTextStyle(
              color: AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(top: 20, right: screenWidth * 0.40),
          child: SizedBox(
            height: screenHeight * 0.25,
            child: Obx(
              () => LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    show: false,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 2,
                  maxY: 5,
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(strokeWidth: 0);
                    },
                    drawVerticalLine: true,
                    getDrawingVerticalLine: (value) {
                      return const FlLine(strokeWidth: 0);
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots:
                          staticController.graphData.isEmpty
                              ? [
                                const FlSpot(0, 2.1),
                                const FlSpot(2, 2.1),
                                const FlSpot(4, 2.1),
                                const FlSpot(6, 2.1),
                                const FlSpot(8, 2.1),
                                const FlSpot(9, 2.1),
                                const FlSpot(11, 2.1),
                              ]
                              : List.generate(
                                staticController.graphData.length,
                                (index) {
                                  double lbPosition =
                                      (staticController
                                              .graphData[index]
                                              .lbPosition
                                              ?.toDouble() ??
                                          0.0) +
                                      2.1;
                                  return FlSpot(
                                    index.toDouble() * 1.8,
                                    lbPosition,
                                  );
                                },
                              ),
                      isCurved: true,
                      color: AppColors.flchartColor.withValues(alpha: 0.2),
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.flchartColor.withValues(alpha: 0.0),
                            AppColors.flchartColor2.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                      showingIndicators: [0, 1, 2, 3, 4, 5, 6],
                    ),
                  ],
                  lineTouchData: const LineTouchData(enabled: false),
                ),
              ),
            ),
          ),
        ),
        // Dynamic Row for second chart
        Obx(() {
          // Use the same days as the first chart
          final days =
              staticController.graphData.isNotEmpty
                  ? staticController.graphData
                      .map((data) => data.dayOfWeek.substring(0, 3) ?? '')
                      .toList()
                  : ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) => Text(
                days.length > index ? days[index] : '',
                style: globalTextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
