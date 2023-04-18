import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  State createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 20, vsync: this);

    Future.delayed(
      Duration(
        milliseconds: 500,
      ),
      () {
        _tabController.index = 15;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My TabBar'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
            Tab(icon: Icon(Icons.directions_boat)),
            Tab(icon: Icon(Icons.directions_bus)),
            Tab(icon: Icon(Icons.directions_railway)),
            Tab(icon: Icon(Icons.directions_run)),
            Tab(icon: Icon(Icons.directions_walk)),
            Tab(icon: Icon(Icons.directions_subway)),
            Tab(icon: Icon(Icons.directions)),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.access_alarm)),
            Tab(icon: Icon(Icons.baby_changing_station)),
            Tab(icon: Icon(Icons.cabin)),
            Tab(icon: Icon(Icons.earbuds)),
            Tab(icon: Icon(Icons.face)),
            Tab(icon: Icon(Icons.g_translate)),
            Tab(icon: Icon(Icons.hail)),
            Tab(icon: Icon(Icons.ice_skating)),
            Tab(icon: Icon(Icons.join_full)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Car')),
          Center(child: Text('Transit')),
          Center(child: Text('Bike')),
          Center(child: Text('Boat')),
          Center(child: Text('Bus')),
          Center(child: Text('Railway')),
          Center(child: Text('Run')),
          Center(child: Text('Walk')),
          Center(child: Text('Subway')),
          Center(child: Text('Directions')),
          Center(child: Text('ac_unit')),
          Center(child: Text('access_alarm')),
          Center(child: Text('baby_changing_station')),
          Center(child: Text('cabin')),
          Center(child: Text('earbuds')),
          Center(child: Text('face')),
          Center(child: Text('g_translate')),
          Center(child: Text('hail')),
          Center(child: Text('ice_skating')),
          Center(child: Text('join_full')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
