import 'package:flutter/material.dart';
import 'package:flutterprojects/DisplayCard.dart';
import 'package:flutterprojects/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectStations extends StatefulWidget {
  @override
  State<SelectStations> createState() => _SelectStationsState();
}

class _SelectStationsState extends State<SelectStations> {

  Map values={},values2={};
  String distance='',stnName='',stnCode='',pfn='';
  var destination=TextEditingController();
  var start=TextEditingController();
  String ini='',out='',trnNo='',trnName='';

  Future apiCall(String from, String to)async{
    final url=Uri.parse("https://irctc1.p.rapidapi.com/api/v2/trainBetweenStations?fromStationCode=$from&toStationCode=$to");
    final head ={
      "X-RapidAPI-Key": "8c38163f64msh06e7d20ec943026p1f4ba9jsnb5bbe6a9fc54",//Literally,paste your key here
      "X-RapidAPI-Host": "irctc1.p.rapidapi.com",
      "useQueryString": "true"
    };
    final response =await http.get(url,headers:head);
    setState(() {
      values=jsonDecode(response.body);
      print(values.runtimeType);
      print(values);
      trnNo=values['data'][0]['train_number'].toString() ?? "Loading....";
      trnName=values['data'][0]['train_name'].toString() ?? "Loading....";
      if(response.statusCode==200){
        api2Call(trnNo);
      }
    });
  }

  Future api2Call(String trnNum)async{
    final url=Uri.parse("https://irctc1.p.rapidapi.com/api/v1/getTrainSchedule?trainNo=$trnNum");
    final head ={
      "X-RapidAPI-Key": "8c38163f64msh06e7d20ec943026p1f4ba9jsnb5bbe6a9fc54",//Literally,paste your key here
      "X-RapidAPI-Host": "irctc1.p.rapidapi.com",
      "useQueryString": "true"
    };
    final response2 =await http.get(url,headers:head);
    setState(() {
      values2=jsonDecode(response2.body);
      print(values2.runtimeType);
      print(values2);


      distance=values2['data']['route'][0]['distance_from_source'].toString() ?? "Loading..." ;
      stnCode=values2['data']['route'][0]['station_code'].toString() ?? "Loading....";
      stnName=values2['data']['route'][0]['station_name'].toString() ?? "Loading....";
      pfn=values2['data']['route'][0]['platform_number'].toString() ?? "Loading....";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Trains'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                TextField(
                  decoration:  InputDecoration(
                    hintText: 'Start (enter only the station code)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    suffixIcon: Align(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: Icon(
                        Icons.add_circle
                      ),
                    )
                  ),
                  controller: start,

                ),
                SizedBox(height: 16),
                TextField(
                  decoration:  InputDecoration(
                    hintText: 'Destination (enter only the station code)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                      suffixIcon: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                            Icons.add_circle
                        ),
                      )
                  ),
                  controller: destination,
                ),
                ElevatedButton(onPressed: () {
                  ini=start.text.toString().toLowerCase() ;
                  out=destination.text.toString().toLowerCase();
                  apiCall(ini,out);
                  print(ini);
                  print(out);
                },
                    child: const Text('Search'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

    DisplayCard(trainNumber: trnNo, platformNumber: pfn, distance: distance, stationCode: stnCode, stationName: stnName,trainName:trnName)
                // trnNo==null? Text("Loading...") : Text("$trnNo"),
                // pfn==null? Text("Loading...") : Text("$pfn"),
                // stnName==null? Text("Loading...") : Text("$stnName"),
                // stnCode==null? Text("Loading...") : Text("$stnCode"),
                // distance==null? Text("Loading...") : Text("$distance"),
                // SizedBox(
                //   height: 555,
                //   child: ListView.builder(itemBuilder: (context,inder){
                //
                //     distance=values2['data']['route'][0]['distance_from_source'].toString() ?? "Loading..." ;
                //     stnCode=values2['data']['route'][0]['station_code'].toString() ?? "Loading....";
                //     stnName=values2['data']['route'][0]['station_name'].toString() ?? "Loading....";
                //     pfn=values2['data']['route'][0]['platform_number'].toString() ?? "Loading....";
                //
                //     return
                //       DisplayCard(trainNumber: trnNo, platformNumber: pfn, distance: distance, stationCode: stnCode, stationName: stnName);
                //   },itemCount: values['data']== null? 0: values['data']?.length,),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

