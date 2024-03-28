import 'package:flareline/themes/global_colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});

  ValueNotifier<int> selectedOption = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return _lineChart(context);
  }

  _lineChart(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 60,
              child: Row(children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                  color: gray,
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  MaterialButton(
                    color:Colors.white,
                    onPressed: () {},
                    child: const Text('Day'),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: const Text('Week'),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: const Text('Month'),
                  )
                ]),)
              ]),
            ),
            Expanded(
                child: ChangeNotifierProvider(
              create: (context) => _LineChartProvider(),
              builder: (ctx, child) => _buildDefaultLineChart(ctx),
            ))
          ],
        ));
  }

  SfCartesianChart _buildDefaultLineChart(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: ''),
      legend: const Legend(
          isVisible: true, position: LegendPosition.top),
      primaryXAxis: const NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: MajorGridLines(width: 1)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value}%',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(context),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries(
      BuildContext context) {
    List<_ChartData> chartData =
        context.watch<_LineChartProvider>().chartData ?? [];
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          name: 'Germany',
          // isVisibleInLegend: false,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          dataSource: chartData,
          name: 'England',
          // isVisibleInLegend: false,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}

class _LineChartProvider extends ChangeNotifier {
  List<_ChartData>? chartData = <_ChartData>[
    _ChartData(2005, 21, 28),
    _ChartData(2006, 24, 44),
    _ChartData(2007, 36, 48),
    _ChartData(2008, 38, 50),
    _ChartData(2009, 54, 66),
    _ChartData(2010, 57, 78),
    _ChartData(2011, 70, 84)
  ];

  void init() {}

  @override
  void dispose() {
    chartData?.clear();
    super.dispose();
  }
}
