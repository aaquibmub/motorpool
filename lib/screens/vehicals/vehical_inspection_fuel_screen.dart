import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/routes.dart';
import '../../providers/vehical_provider.dart';

class VehicalInspectionFuelScreen extends StatefulWidget {
  final VehicalInspectionModel _model;

  VehicalInspectionFuelScreen(
    this._model,
  );
  @override
  State<VehicalInspectionFuelScreen> createState() =>
      _VehicalInspectionFuelScreenState();
}

class _VehicalInspectionFuelScreenState
    extends State<VehicalInspectionFuelScreen> {
  /// Value changing call back for first quarter slider.
  void handleValueChangingForFirstQuarterSlider(ValueChangingArgs args) {
    if (args.value.toInt() < 0) {
      args.cancel = true;
    }
  }

  /// Value changed call back for first quarter slider.
  void handleValueChangedForFirstQuarterSlider(double value) {
    setState(() {
      widget._model.fuelLevel = value.roundToDouble();
      // _markerValueForFirstQuarterSlider = value.roundToDouble();
      _annotationValue4 = value.round().toStringAsFixed(0);
    });
  }

  double _size = 150;
  double width, height;
  // double _markerValueForFirstQuarterSlider = 60;
  double _markerSize = 25;
  String _annotationValue4 = '0';
  double _annotationFontSize = 25;

  @override
  void initState() {
    _annotationValue4 = widget._model.fuelLevel != null
        ? widget._model.fuelLevel.toString()
        : '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSlider() {
      return SizedBox(
        height: _size,
        width: _size,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              radiusFactor: 0.9,
              axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color.fromRGBO(88, 194, 143, 0.3),
                  thickness: 0.1,
                  thicknessUnit: GaugeSizeUnit.factor),
              showLabels: false,
              showTicks: false,
              startAngle: 180,
              endAngle: 0,
              pointers: <GaugePointer>[
                RangePointer(
                    width: 0.1,
                    value: widget._model.fuelLevel != null
                        ? double.parse(widget._model.fuelLevel.toString())
                        : 0,
                    cornerStyle: CornerStyle.bothCurve,
                    color: const Color.fromRGBO(88, 194, 143, 1),
                    sizeUnit: GaugeSizeUnit.factor),
                MarkerPointer(
                  value: widget._model.fuelLevel != null
                      ? double.parse(widget._model.fuelLevel.toString())
                      : 0,
                  // elevation: 5,
                  color: const Color.fromRGBO(88, 194, 143, 1),
                  // model.currentThemeData.brightness == Brightness.light
                  //     ? Colors.white
                  //     : Colors.black,
                  // borderWidth: 4,
                  onValueChanged: handleValueChangedForFirstQuarterSlider,
                  onValueChangeEnd: handleValueChangedForFirstQuarterSlider,
                  onValueChanging: handleValueChangingForFirstQuarterSlider,
                  enableDragging: true,
                  // borderColor:
                  //     model.currentThemeData.brightness == Brightness.light
                  //         ? Colors.black
                  //         : Colors.white,
                  markerHeight: _markerSize,
                  markerWidth: _markerSize,
                  markerType: MarkerType.circle,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text(
                      '$_annotationValue4' '%',
                      style: TextStyle(
                        fontSize: _annotationFontSize,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    positionFactor: 0.13,
                    angle: 0)
              ]),
        ]),
      );
    }

    return Column(
      children: [
        Expanded(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text('Fuel Level'),
            ),
            Container(
              child: _buildSlider(),
            ),
            Container(
              child: Text('Kilometers Reading'),
            ),
            Container(
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: widget._model.odoMeter?.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter reading';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please eneter more than zero';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget._model.odoMeter = int.tryParse(value) ?? 0;
                },
              ),
            ),
            Container(
              child: Text('Comments'),
            ),
            Container(
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: widget._model.comments,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter comments';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget._model.comments = value;
                },
              ),
            ),
          ],
        )),
        Container(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Constants.colorGreen)),
            onPressed: () async {
              if (widget._model.odoMeter == null) {
                Utility.showErrorDialogue(context, 'Enter ODO Meter Reading');
                return;
              }

              var response =
                  await Provider.of<VehicalProvider>(context, listen: false)
                      .submitInspection(
                widget._model,
              );

              if (response.hasError == null || response.hasError) {
                Utility.showErrorDialogue(
                  context,
                  response.msg,
                );
                return;
              }

              Navigator.of(context).pushReplacementNamed(Routes.vehicalsScreen);
            },
            child: Text(
              'SUBMIT',
              style: Theme.of(context).primaryTextTheme.labelLarge,
            ),
          ),
        )
      ],
    );
  }
}
