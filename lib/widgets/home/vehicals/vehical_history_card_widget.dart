import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorpool/helpers/common/constants.dart';
import 'package:motorpool/helpers/common/utility.dart';
import 'package:motorpool/helpers/models/vehicals/vehical_history.dart';
import 'package:motorpool/widgets/common/lable_value_wdget.dart';

import '../../../helpers/models/user.dart';
import '../../../screens/vehicals/vehical_inspection_screen.dart';

class VehicalHistoryCardWidget extends StatefulWidget {
  final VehicalHistory _model;
  final User _currentUser;
  final Function _updateState;

  VehicalHistoryCardWidget(
    this._model,
    this._currentUser,
    this._updateState,
  );

  @override
  State<VehicalHistoryCardWidget> createState() =>
      _VehicalHistoryCardWidgetState();
}

class _VehicalHistoryCardWidgetState extends State<VehicalHistoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    bool vehicalIsAssigned = widget._model.assignedToUser;
    return Container(
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
                  widget._model.plateNumber,
                ),
                LabelValueWidget(
                  "MAKE/MODEL",
                  widget._model.make +
                      "-" +
                      widget._model.model +
                      " " +
                      widget._model.modelYear.toString(),
                ),
                LabelValueWidget(
                  widget._model.allocated ? "ASSIGNED ON" : "DEALLOCATED ON",
                  DateFormat('yyyy-MM-dd – kk:mm')
                      .format(widget._model.assignedOn),
                ),
                if ((widget._model.odoMeter == null ||
                    widget._model.odoMeter == ''))
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Utility.showMeterReadingDialogue(
                          context,
                          widget._model.id,
                          widget._model.plateNumber,
                        ).then((value) {
                          widget._updateState();
                        });
                      },
                      child: Text('Meter Reading'),
                    ),
                  ),
                if (widget._model.allocated &&
                    vehicalIsAssigned &&
                    !widget._model.inspectionCompleted)
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicalInspectionScreen(
                                widget._model.vehicalId),
                          ),
                        );
                      },
                      child: Text('Inspection'),
                    ),
                  ),
                if (widget._model.allocated && vehicalIsAssigned)
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Utility.showMeterReadingAndDeallocateDialogue(
                          context,
                          widget._currentUser.id,
                          widget._model.vehicalId,
                          widget._model.plateNumber,
                        ).then((value) {
                          widget._updateState();
                        });
                      },
                      child: Text('Deallocate'),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
