import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/models/vehicals/vehical_history.dart';
import 'package:motorpool/screens/vehicals/vehical_inspection_screen.dart';
import 'package:motorpool/widgets/common/lable_value_wdget.dart';

class VehicalHistoryCardWidget extends StatelessWidget {
  final VehicalHistory _vehicalHistory;

  VehicalHistoryCardWidget(
    this._vehicalHistory,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicalInspectionScreen(
                      _vehicalHistory.vehicalId,
                    )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: new EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Constants.colorCardBorder,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabelValueWidget(
                    "VEHICAL PLATE",
                    _vehicalHistory.plateNumber,
                  ),
                  LabelValueWidget(
                    "MAKE/MODEL",
                    _vehicalHistory.make +
                        "-" +
                        _vehicalHistory.model +
                        " " +
                        _vehicalHistory.modelYear.toString(),
                  ),
                  LabelValueWidget(
                    "ASSIGNED ON",
                    _vehicalHistory.assignedOn.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
