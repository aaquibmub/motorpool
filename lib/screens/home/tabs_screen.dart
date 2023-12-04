import 'package:flutter/material.dart';
import 'package:motorpool/helpers/common/custom_icons.dart';
import 'package:motorpool/screens/home/dashboard_screen.dart';
import 'package:motorpool/screens/home/trip_screen.dart';
import 'package:motorpool/screens/home/vehical-inspection-list-screens.dart';
import 'package:motorpool/screens/home/vehicals_screen.dart';

class TabsScreen extends StatefulWidget {
  final int index;

  TabsScreen(
    this.index,
  );

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': DashboardScreen()},
      {'page': TripScreen()},
      {'page': VehicalsScreen()},
      {'page': VehicalInspectionListScreen()},
    ];

    _selectedPageIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_trip,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_vehicle,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              MyFlutterApp.ico_vehicle_inspection,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
