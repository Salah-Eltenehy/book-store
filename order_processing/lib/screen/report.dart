import 'package:flutter/material.dart';
import 'package:order_processing/screen/MainApp.dart';
import 'package:http/http.dart' as http;
import '../Constants.dart';
class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
           child: ListView(
             children: [
               Center(
                 child: Stack(
                   children: [
                     SizedBox(height: 300,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         OutlinedButton(onPressed:(){
                          MainApp.currentPage =0;
                          MainApp.update();
                         }, child: Text("Cancel",style: TextStyle(
                           fontSize: 15,
                           letterSpacing: 2,
                           color: Colors.black,
                         ),),
                           style: OutlinedButton.styleFrom(
                               padding: EdgeInsets.symmetric(horizontal: 50),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                           ),
                         ),
                         ElevatedButton(onPressed: ()async{
                           String _url = "http://${ip}:8080/bookstore/manager/report/viewTotalBookSales";
                           print(_url);
                           var response = await http.get(Uri.parse(_url));
                           print(response.body);
                           MainApp.currentPage =0;
                           MainApp.update();
                         }, child: Text("view report 1",style: TextStyle(
                           fontSize: 15,
                           letterSpacing: 2,
                           color: Colors.white,
                         ),),
                           style: ElevatedButton.styleFrom(
                               primary: kPrimaryColor,
                               padding: EdgeInsets.symmetric(horizontal: 30),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                           ),
                         ),

                       ],
                     ),
                     SizedBox(height: 300,),
                   ],
                 ),
               ),
               Center(
                 child: Stack(
                   children: [
                     SizedBox(height: 300,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         OutlinedButton(onPressed:() async {
                           String _url = "http://${ip}:8080/bookstore/manager/report/viewTop10Books";
                           print(_url);
                           var response = await http.get(Uri.parse(_url));
                           print(response.body);
                           MainApp.currentPage =0;
                           MainApp.update();
                         }, child: Text("view report 2",style: TextStyle(
                           fontSize: 15,
                           letterSpacing: 2,
                           color: Colors.black,
                         ),),
                           style: OutlinedButton.styleFrom(
                               padding: EdgeInsets.symmetric(horizontal: 50),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                           ),
                         ),
                         ElevatedButton(onPressed: ()async{
                           String _url = "http://${ip}:8080/bookstore/manager/report/viewTop5Customers";
                           print(_url);
                           var response = await http.get(Uri.parse(_url));
                           print(response.body);
                           MainApp.currentPage =0;
                           MainApp.update();
                         }, child: Text("view report 3",style: TextStyle(
                           fontSize: 15,
                           letterSpacing: 2,
                           color: Colors.white,
                         ),),
                           style: ElevatedButton.styleFrom(
                               primary: kPrimaryColor,
                               padding: EdgeInsets.symmetric(horizontal: 30),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                           ),
                         ),

                       ],
                     ),
                     SizedBox(height: 300,),
                   ],
                 ),
               )
             ],

           ),

            );
  }
}
