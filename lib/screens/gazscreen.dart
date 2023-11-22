import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';

class GazController extends StatefulWidget {
  const GazController({Key? key}) : super(key: key);

  @override
  State<GazController> createState() => _GazControllerState();
}

class _GazControllerState extends State<GazController> {
  List<OrdinalData> ordinalList = [
    // OrdinalData(domain: 'Mon', measure: 3),
    // OrdinalData(domain: 'Tue', measure: 5),
    // OrdinalData(domain: 'Wed', measure: 9),
    // OrdinalData(domain: 'Thu', measure: 6.5),
  ];

  late final ordinalGroup = [
    OrdinalGroup(
      id: '1',
      data: ordinalList,
    ),
  ];
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref();
  final CollectionReference _temperatureHumidityCollection =
      FirebaseFirestore.instance.collection('data');



  String GazStr ='0.0';

  dynamic valueGaz='';
  double doubleGaz = 0;

  @override
  Widget build(BuildContext context) {


    _databaseReference.child('gaz').onValue.listen((event) {
      final data = event.snapshot.value as String;
      setState(() {
        GazStr = data;
        doubleGaz =double.parse(GazStr) ;
      });
      print('---------------${data}');
      print('/////////////////${doubleGaz}');
      // _temperatureHumidityCollection.add({
      //   'Temp': data,
      //   'timestamp': FieldValue.serverTimestamp(),
      // });

    });

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32),
                    CircularPercentIndicator(
                      radius: 180,
                      lineWidth: 13,
                      percent: doubleGaz / 100,
                      progressColor: Colors.indigo,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${GazStr}%', // Vous pouvez ajuster la précision des décimales selon vos besoins
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'GAZ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _roundedButton(title: 'GENERAL', isActive: true),
                        _roundedButton(title: 'SERVICES'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      ///digramme******************************************************
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _fan(title: 'FAN 1', isActive: true),
                        _fan(title: 'FAN 2', isActive: true),
                        _fan(title: 'FAN 3'),
                      ],
                    ),
                    const SizedBox(height: 35),



                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance.collection('data').snapshots(),
                    //   builder: (context, snapshot) {
                    //     // if (snapshot.connectionState == ConnectionState.waiting) {
                    //     //   return CircularProgressIndicator();
                    //     // }
                    //     if (!snapshot.hasData || snapshot.data == null) {
                    //       return Text('No data available');
                    //     }
                    //
                    //     var documents = snapshot.data!.docs;
                    //     List<Widget> widgets = [];
                    //
                    //     for (var document in documents) {
                    //       var data = document.data() as Map<String, dynamic>;
                    //
                    //       // Check if 'your_field' exists in the data map
                    //       print('---------${data['gaz']}');
                    //
                    //       if(data['gaz'] != null){
                    //         ordinalList.add(OrdinalData(domain: '2023', measure: data['gaz']) );
                    //
                    //         // double storeGaz = double.parse(data['gaz']);
                    //         // print('+++++++++++++++++++++++++++++${data['gaz'].isString}');
                    //       }
                    //     }
                    //
                    //     return Container(
                    //       child: AspectRatio(
                    //         aspectRatio: 16 / 9,
                    //         child: DChartBarO(
                    //           fillColor: (group, ordinalData, index) {
                    //             if (ordinalData.measure > 8) return Colors.red;
                    //             return Colors.indigo;
                    //           },
                    //
                    //           groupList: ordinalGroup,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fan({
    required String title,
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isActive ? Colors.indigo : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Image.asset(
            isActive ? 'assets/images/fan-2.png' : 'assets/images/fan-1.png',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.black87 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _roundedButton({
    required String title,
    bool isActive = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
