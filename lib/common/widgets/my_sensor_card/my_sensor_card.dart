import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class MySensorCard extends StatelessWidget {
  const MySensorCard(
      {super.key,
      required this.value,
      required this.name,
      this.assetImage,
      required this.unit,
      required this.trendData,
      required this.linePoint});

  final double value;
  final String name;
  final String unit;
  final List<double> trendData;
  final Color linePoint;
  final AssetImage? assetImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(width: 2),
      ),
      // shadowColor: Colors.white,
      // elevation: 24,
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$name $value$unit',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Sparkline(
                  data: trendData,
                  lineWidth: 3.0,
                  lineColor: Colors.white60,
                  fillColor: Colors.transparent,
                  averageLine: true,
                  averageLineColor: Colors.white,
                  fillMode: FillMode.above,
                  sharpCorners: false,
                  pointsMode: PointsMode.last,
                  pointSize: 20,
                  pointColor: linePoint,
                  useCubicSmoothing: true,
                  lineGradient: LinearGradient(colors: [Colors.white, linePoint]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
