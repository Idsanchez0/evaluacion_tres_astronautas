import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:evaluacion_tres_astronautas/SizeConfig/SizeConfig.dart';
import 'package:evaluacion_tres_astronautas/Views/Components/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class Calendario extends StatefulWidget{
  Calendario():super();
  _Calendario createState()=>new _Calendario();
}
class _Calendario extends State<Calendario>{
  Widget footerG=Container();
  late DateTime date, date1;
  var today = DateTime.now();
  late CalendarController _controller;
  String _curretDate='';
  bool shouldPop = true;

  @override
  void initState() {
    super.initState();
    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    _curretDate = fecha.toString().split(new RegExp(r"T00:00:00")).toString().substring(1,11);
    _controller = CalendarController();
    footerG=FooterGeneral(screen: 'calendario');
  }

  //
  Future ErrorPopUp(String text){
    return showDialog(
      context: this.context,
      builder: (BuildContext context){
        return Center(
          //backgroundColor: Colors.blue,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 25*SizeConfig.heightMultiplier,
                width: 80*SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.widthMultiplier)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                      child: Column(
                        children: [
                          Container(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      width: 10*SizeConfig.widthMultiplier,
                                      height: 10*SizeConfig.imageSizeMultiplier,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(Radius.circular(50*SizeConfig.widthMultiplier))
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Icon(Icons.warning_amber_outlined, color: Colors.white),
                                        ),
                                      )
                                  ),
                                ),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier, left: 2*SizeConfig.widthMultiplier, right: 2*SizeConfig.widthMultiplier),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: HexColor("253166"))
                                    )
                                ),
                                child: Text(text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: HexColor("253166"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.5*SizeConfig.textMultiplier,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3*SizeConfig.heightMultiplier),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 60*SizeConfig.widthMultiplier,
                                height: 5*SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                    color: HexColor('e0844c'),
                                    borderRadius: BorderRadius.all(Radius.circular(50*SizeConfig.widthMultiplier))
                                ),
                                child: Center(
                                  child: Text("Accept",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 2.5*SizeConfig.textMultiplier,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    Widget Header=Container(
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier),
        width: double.infinity,
        color: HexColor('f4f4f4'),
        child: Container(
            padding: EdgeInsets.only(top: 5*SizeConfig.heightMultiplier),
            child: Table(
              columnWidths: {
                0:FlexColumnWidth(5),
                1:FlexColumnWidth(2),
                2:FlexColumnWidth(2),
              },
              children: [
                TableRow(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 40*SizeConfig.widthMultiplier),
                        child: Image(
                          image: AssetImage("images/icons/nasa.png"),
                          height: 25*SizeConfig.imageSizeMultiplier,
                        ),
                      ),
                      Container(
                        child: Table(
                          children: [
                            TableRow(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                    child: InkWell(
                                      onTap: (){
                                        ErrorPopUp('Notifications are not enabled');
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                          height: 5*SizeConfig.heightMultiplier,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: kElevationToShadow[2],
                                          ),
                                          child: Image(
                                            image: AssetImage('images/icons/notification.png'),
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
                                    child: InkWell(
                                      onTap: (){
                                        ErrorPopUp('The settings are not available');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2*SizeConfig.imageSizeMultiplier),
                                        height: 5*SizeConfig.heightMultiplier,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: kElevationToShadow[2],
                                        ),
                                        child: Image(
                                          image: AssetImage('images/icons/ajustes.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                            )
                          ],
                        ),
                      )
                    ]
                )
              ],
            )
        )
    );

    Widget Title=Container(
        padding: EdgeInsets.only(left: 4*SizeConfig.widthMultiplier, right: 4*SizeConfig.widthMultiplier, bottom: 1*SizeConfig.heightMultiplier),
        width: double.infinity,
        color: HexColor('f4f4f4'),
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 3.5*SizeConfig.heightMultiplier),
              child: Text("Calendar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 3.5*SizeConfig.textMultiplier,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
        )
    );
    //Calendar
    Widget Calendario = Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 2*SizeConfig.heightMultiplier),
      child: TableCalendar(
        locale: "es_EC",
        initialCalendarFormat: CalendarFormat.month,
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: BoxDecoration(color: HexColor("e5e5e4")),
          weekdayStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier, color: Colors.black),
          weekendStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier, color: Colors.black),
        ),
        calendarStyle: CalendarStyle(
          todayColor: HexColor('e0844c'),//e5e5e4
          selectedColor: Theme.of(context).primaryColor,
          weekdayStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier,color: Colors.grey),
          holidayStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier,color: HexColor('e0844c')),
          outsideWeekendStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier, color: Color.fromRGBO(104, 51, 150, 0.2)),
          outsideStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier, color: Color.fromRGBO(104, 51, 150, 0.2)),
          weekendStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier, color: HexColor('e0844c')),
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 2*SizeConfig.textMultiplier,
              color: Colors.white
          ),
          eventDayStyle: TextStyle(fontSize: 2*SizeConfig.textMultiplier,color: HexColor('e0844c')),
        ),
        headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_left, size: 7*SizeConfig.imageSizeMultiplier, color: HexColor('e0844c')),
          rightChevronIcon: Icon(Icons.arrow_right, size: 7*SizeConfig.imageSizeMultiplier, color: HexColor('e0844c')),
          centerHeaderTitle: true,
          formatButtonVisible: false,
          formatButtonTextStyle: TextStyle(color: Colors.white,),
          titleTextStyle: TextStyle(fontSize: 2.3*SizeConfig.textMultiplier, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        startingDayOfWeek: StartingDayOfWeek.sunday,
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, events) => InkWell(
            child: Container(
                margin: EdgeInsets.all(1.7*SizeConfig.widthMultiplier),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: HexColor('e0844c'),
                    borderRadius: BorderRadius.circular(25*SizeConfig.widthMultiplier)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 2*SizeConfig.textMultiplier,),
                )
            ),
          ),
          todayDayBuilder: (context, date, events) => Container(
              margin: EdgeInsets.all(1.7*SizeConfig.widthMultiplier),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: HexColor('e0844c')),
                  borderRadius: BorderRadius.circular(25*SizeConfig.widthMultiplier)),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 2*SizeConfig.textMultiplier,),
              )
          ),
          markersBuilder: (context, date, events, _events1) {
            DateTime date1=DateTime.now();
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Container(
                  height: 2*SizeConfig.imageSizeMultiplier,
                  width: 2*SizeConfig.widthMultiplier,
                  margin: EdgeInsets.all(1*SizeConfig.widthMultiplier),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25*SizeConfig.widthMultiplier)),
                ),
              );
            }
            return children;
          },
        ),
        calendarController: _controller,
      ),
    );
    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async{
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SubMenuAgenda(token: _token,data: _data)));
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: HexColor('f4f4f4'),
        body: Center(
          child: Container(
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Header,
                  Title,
                  Calendario,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: footerG,
      ),
    );
  }
}