import 'package:flutter/material.dart';

import '../../../helpers/common/constants.dart';
import '../../../helpers/models/vehicals/inspection/vehical_inspection_history_list.dart';
import '../../../screens/vehicals/vehical_inspection_screen.dart';
import '../../common/lable_value_wdget.dart';

class VehicalInspectionHistoryCardWidget extends StatelessWidget {
  final VehicalInspectionHistory _model;

  VehicalInspectionHistoryCardWidget(
    this._model,
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
                      _model.vehicalId,
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
                    "INSPECTION ID",
                    _model.inspectionId,
                  ),
                  LabelValueWidget(
                    "VEHICAL PLATE",
                    _model.plateNumber,
                  ),
                  LabelValueWidget(
                    "INSPECTED ON",
                    _model.inspectedOn.toString(),
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
