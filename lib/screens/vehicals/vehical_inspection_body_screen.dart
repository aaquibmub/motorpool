import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_map/flutter_image_map.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_part_item_model.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_body_side_item_model.dart';
import 'package:motorpool/helpers/models/vehicals/inspection/vehical_inspection_model.dart';
import 'package:provider/provider.dart';

import '../../helpers/common/constants.dart';
import '../../helpers/common/utility.dart';
import '../../helpers/models/common/dropdown_item.dart';
import '../../providers/vehical_provider.dart';

class VehicalInspectionBodyScreen extends StatefulWidget {
  final VehicalInspectionModel _model;

  VehicalInspectionBodyScreen(
    this._model,
  );
  @override
  State<VehicalInspectionBodyScreen> createState() =>
      _VehicalInspectionBodyScreenState();
}

class _VehicalInspectionBodyScreenState
    extends State<VehicalInspectionBodyScreen> {
  VehicalInspectionBodyPartItemModel _selectedSidePart;
  List<DropdownItem<int>> damageLevelList = Utility.getDamageLevelList();

  // @override
  // void initState() {
  //   groupedItems =
  //       Utility.myGroupBy<VehicalInspectionBodyItemModel, DropdownItem<String>>(
  //           widget._model.bodyInspectionItems, (item) => item.side);
  //   // groupedItems = groupBy(widget._model.bodyInspectionItems,
  //   //     (VehicalInspectionBodyItemModel item) => item.side).keys.toList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    ImageMapRegion getImageRegion(
      DropdownItem<String> part,
      double dx,
      double dy,
    ) {
      return ImageMapRegion.fromCircle(
        center: Offset(dx, dy),
        radius: 20,
        color: _selectedSidePart != null &&
                _selectedSidePart.part.value == part.value
            ? const Color.fromRGBO(50, 200, 50, 0.5)
            : Colors.transparent,
        title: part.value,
      );
    }

    Widget getBodySide(
      VehicalInspectionBodySideItemModel i,
      String imagePath,
    ) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              child: Center(
                child: Text(i.side.text),
              ),
            ),
            Container(
              width: double.infinity,
              height: 280,
              child: ImageMap(
                image: Image.asset(imagePath),
                onTap: (region) {
                  // ignore: avoid_print
                  print('Pressed: ${region.title} / ${region.link}');
                  setState(() {
                    _selectedSidePart = i.parts.firstWhereOrNull(
                        (VehicalInspectionBodyPartItemModel element) =>
                            element.part.value == region.title);
                  });
                },
                regions: i.parts.map((e) {
                  if (e.part != null) {
                    // Front
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideWindshieldId) {
                      return getImageRegion(
                        e.part,
                        225,
                        55,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideHoodId) {
                      return getImageRegion(
                        e.part,
                        225,
                        118,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideGrillId) {
                      return getImageRegion(
                        e.part,
                        225,
                        180,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideFrontBumperId) {
                      return getImageRegion(
                        e.part,
                        225,
                        280,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideLeftHeadlightId) {
                      return getImageRegion(
                        e.part,
                        50,
                        160,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartFrontSideRightHeadlightId) {
                      return getImageRegion(
                        e.part,
                        400,
                        160,
                      );
                    }
                    // Back
                    if (e.part.value ==
                        Constants.vehicalBodyPartBackSideWindshieldId) {
                      return getImageRegion(
                        e.part,
                        205,
                        65,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartBackSideTrunkId) {
                      return getImageRegion(
                        e.part,
                        205,
                        190,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartBackSideRearBumperId) {
                      return getImageRegion(
                        e.part,
                        205,
                        275,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartBackSideLeftTaillightId) {
                      return getImageRegion(
                        e.part,
                        65,
                        140,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartBackSideRightTaillightId) {
                      return getImageRegion(
                        e.part,
                        335,
                        140,
                      );
                    }
                    // Roof
                    if (e.part.value ==
                        Constants.vehicalBodyPartRoofSideRoofId) {
                      return getImageRegion(
                        e.part,
                        380,
                        130,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRoofSideSunRoofId) {
                      return getImageRegion(
                        e.part,
                        260,
                        130,
                      );
                    }
                    // Left
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideFrontFenderId) {
                      return getImageRegion(
                        e.part,
                        75,
                        105,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideSideMirrorId) {
                      return getImageRegion(
                        e.part,
                        185,
                        85,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideFrontDoorId) {
                      return getImageRegion(
                        e.part,
                        225,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideRearDoorId) {
                      return getImageRegion(
                        e.part,
                        330,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideRearFenderId) {
                      return getImageRegion(
                        e.part,
                        480,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideFrontWheelId) {
                      return getImageRegion(
                        e.part,
                        90,
                        165,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartLeftSideRearWheelId) {
                      return getImageRegion(
                        e.part,
                        400,
                        165,
                      );
                    }
                    // Right
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideRearFenderId) {
                      return getImageRegion(
                        e.part,
                        40,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideRearWheelId) {
                      return getImageRegion(
                        e.part,
                        120,
                        165,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideRearDoorId) {
                      return getImageRegion(
                        e.part,
                        190,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideFrontDoorId) {
                      return getImageRegion(
                        e.part,
                        300,
                        115,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideSideMirrorId) {
                      return getImageRegion(
                        e.part,
                        340,
                        85,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideFrontFenderId) {
                      return getImageRegion(
                        e.part,
                        450,
                        105,
                      );
                    }
                    if (e.part.value ==
                        Constants.vehicalBodyPartRightSideFrontWheelId) {
                      return getImageRegion(
                        e.part,
                        435,
                        165,
                      );
                    }
                  }
                }).toList(),
              ),
            ),
            Expanded(
              child: _selectedSidePart != null
                  ? Container(
                      child: GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 4,
                        // Generate 100 widgets that display their index in the List.
                        children: damageLevelList.map((e) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedSidePart.damageLevel = e;
                              });
                              Provider.of<VehicalProvider>(context,
                                      listen: false)
                                  .saveBodyInspectionItem(_selectedSidePart)
                                  .then((response) {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: _selectedSidePart.damageLevel !=
                                              null &&
                                          _selectedSidePart.damageLevel.value ==
                                              e.value
                                      ? Colors.orange
                                      : Colors.white),
                              child: Center(
                                child: Text(
                                  e.text,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Center(
                      child: Text('please select a part'),
                    ),
            ),
          ],
        ),
      );
    }

    return widget._model.bodyInspectionItems != null
        ? SingleChildScrollView(
            child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 800,
                    onPageChanged: (index, r) {
                      setState(() {
                        _selectedSidePart = null;
                      });
                    }),
                items: widget._model.bodyInspectionItems.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      if (i.side.value == Constants.vehicalBodySideFrontId) {
                        return getBodySide(
                          i,
                          'assets/images/inspections/body-front.png',
                        );
                      }
                      if (i.side.value == Constants.vehicalBodySideBackId) {
                        return getBodySide(
                          i,
                          'assets/images/inspections/body-back.png',
                        );
                      }
                      if (i.side.value == Constants.vehicalBodySideRoofId) {
                        return getBodySide(
                          i,
                          'assets/images/inspections/body-roof.png',
                        );
                      }
                      if (i.side.value == Constants.vehicalBodySideLeftId) {
                        return getBodySide(
                          i,
                          'assets/images/inspections/body-left.png',
                        );
                      }
                      if (i.side.value == Constants.vehicalBodySideRightId) {
                        return getBodySide(
                          i,
                          'assets/images/inspections/body-right.png',
                        );
                      }
                      return Text('no item');
                    },
                  );
                }).toList(),
              ),
            ],
          ))
        : Center(
            child: Text('loading'),
          );
  }
}
