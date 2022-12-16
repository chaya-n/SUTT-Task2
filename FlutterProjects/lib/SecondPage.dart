import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPage extends StatefulWidget {
  GoogleSignInAccount userdata;
  SecondPage(this.userdata);
  @override
  State<StatefulWidget> createState() {
    return SecondPageState(this.userdata);
  }
}


class SecondPageState extends State<SecondPage> {

  String stringResponse='',buff='';
  String ini='',out='';
  Map head={};
  Map values={},values2={};
  http.Response? response,response2;
  var destination=TextEditingController();
  var start=TextEditingController();

  String distance='',stnName='',stnCode='',pfn='',time='';
  
  Future apiCall()async{
    final url=Uri.parse("https://irctc1.p.rapidapi.com/api/v2/trainBetweenStations?fromStationCode=$ini&toStationCode=$out");
    final head ={
      "X-RapidAPI-Key": "4384faa124mshf9a257361d9d978p122ab9jsn2605a431e4cc",//Literally,paste your key here
      "X-RapidAPI-Host": "irctc1.p.rapidapi.com",
      "useQueryString": "true"
    };
    final response =await http.get(url,headers:head);
    setState(() {
      // values=jsonDecode(response.body);
      // print(values.runtimeType);
      // specificValues=values['data'];
      print(values['data'][0][['train_number']]);
      buff=values['data'][0]['train_number'].toString();
      stnName=values['data'][0]['train_origin_station'].toString();
      stnCode=values['data'][0]['train_origin_code'].toString();
    });
  }

  Future api2Call()async{
    final url=Uri.parse("https://irctc1.p.rapidapi.com/api/v1/getTrainSchedule?trainNo=$buff");
    final head ={
      "X-RapidAPI-Key": "4384faa124mshf9a257361d9d978p122ab9jsn2605a431e4cc",//Literally,paste your key here
      "X-RapidAPI-Host": "irctc1.p.rapidapi.com",
      "useQueryString": "true"
    };
    final response2 =await http.get(url,headers:head);
    setState(() {
      values2=jsonDecode(response2.body);
      // print(values2.runtimeType);

    });
  }

  GoogleSignInAccount userdata;
  SecondPageState(this.userdata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //now you have passing variable
        title: Text("Select Stations"),
        backgroundColor: Colors.brown,),
      body: Container(
        child: Column(
          children: [
            TextField(
            decoration: InputDecoration(
              hintText: 'Start',
            ),

              controller: start,
          ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Destination',
              ),

              controller: destination,

            ),
            ElevatedButton(onPressed: (){
              ini=start.text;
              out=destination.text;
              apiCall();
              api2Call();
              print(values['data'][0][['train_number']]);

              
            }, child:  Text('search'),style: ElevatedButton.styleFrom(primary: Colors.brown),),
            Container(child: values==null? Text("loading...") : Text('$buff')),
            Card(
              child: Padding(
                padding: EdgeInsetsDirectional.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$buff'),
                          Text('Platform Number')
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Station Name (Station Code)"),
                          Text("Will Stop?")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Platform'),
                          Text('Distance'),
                          Text('Time')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}