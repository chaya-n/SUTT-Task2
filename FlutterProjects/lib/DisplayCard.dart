import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisplayCard extends StatelessWidget {
  final String trainNumber;
  final String platformNumber;
  final String distance;
  final String stationCode;
  final String stationName;
  final String trainName;

  const DisplayCard({super.key,
    required this.trainNumber,
    required this.platformNumber,
    required this.distance,
    required this.stationCode,
    required this.stationName,
    required this.trainName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
        ),
        child:
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Text(trainName,
                //       style: const TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w600,
                //       )),
                // ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: Row(
                  children: [
                    const Icon(Icons.stairs,
                      color: Colors.brown,),
                    const SizedBox(width: 5),
                    const Text("Platform Number: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                    Text(platformNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),)
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, top: 5),
            //   child: Row(
            //     children: [
            //       const Icon(Icons.access_time_filled_rounded,
            //         color: Colors.brown,),
            //       const SizedBox(width: 5),
            //       Text(startTime,
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontSize: 16
            //         ),),
            //       const SizedBox(width: 5),
            //       const Text("-", style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),),
            //       const SizedBox(width: 5),
            //       Text(endTime,
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontSize: 16
            //         ),)
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(Icons.map_rounded,
                    color: Colors.brown,),
                  const SizedBox(width: 5),
                  const Text("Distance: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(distance,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(Icons.abc,
                    color: Colors.brown,),
                  const SizedBox(width: 5),
                  const Text("Station Name : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(stationName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(Icons.abc,
                    color: Colors.brown,),
                  const SizedBox(width: 5),
                  const Text("Station Code : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(stationCode,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(Icons.abc,
                    color: Colors.brown,),
                  const SizedBox(width: 5),
                  const Text("Train Name : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(trainName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 15),
              child: Row(
                children: [
                  const Icon(Icons.abc,
                    color: Colors.brown,),
                  const SizedBox(width: 5),
                  const Text("Train Number : ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(trainNumber,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),)
                ],
              ),
            )
          ],

        )
    );
  }
}