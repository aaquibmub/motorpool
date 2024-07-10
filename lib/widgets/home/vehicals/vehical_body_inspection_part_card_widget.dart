import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/utility.dart';

import '../../../helpers/models/vehicals/inspection/vehical_inspection_body_part_item_model.dart';

class VehicalBodyInspectionPartCardWidget extends StatelessWidget {
  final VehicalInspectionBodyPartItemModel _model;
  final Function onRemove;

  VehicalBodyInspectionPartCardWidget(
    this._model,
    this.onRemove,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(
          //   _model.xaxis.toStringAsFixed(2) +
          //       'x' +
          //       _model.yaxis.toStringAsFixed(2),
          // ),
          Container(
            margin: new EdgeInsets.only(
              left: 16,
            ),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                color: Utility.getColorFromHex(
              _model.hexColor,
            )),
          ),
          Text(
            _model.scraches.toString(),
          ),
          Text(
            _model.damages.toString(),
          ),
          Text(
            _model.dents.toString(),
          ),
          Center(
            child: InkWell(
              onTap: onRemove,
              child: Text('x'),
            ),
          ),
        ],
      ),
    );
  }
}
