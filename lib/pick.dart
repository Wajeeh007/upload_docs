import 'field.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'provider_class.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _showToast(){
    return Fluttertoast.showToast(
        msg: 'Upload All Documents To Proceed',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        textColor: Colors.black
    );
  }

  _alert(){
    return Alert(context: context,
        type: AlertType.info,
        title: 'Process Complete',
        desc: 'You have uploaded all the documents',
        buttons: [
          DialogButton(child: Text('Finish', style: TextStyle(fontSize: 10.0, color: Colors.white),), onPressed: (){Navigator.pop(context);}, width: 150,)
        ]
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => Model(),
    child: Scaffold(
      backgroundColor: Color(0xff293462),
      body: SafeArea(
        child: Consumer<Model>(
          builder: (context, Model, child) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: Text(
                      'Upload Documents',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: Model.i,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.blue.shade900,
                                ),
                              );
                            }
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4 - Model.i,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  filefield('Profile Picture', false, Model),
                  filefield('Passport', true, Model),
                  filefield('Certificate', true, Model),
                  filefield('Driving License', true, Model),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 48.0,
                    width: MediaQuery.of(context).size.width/1.2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)
                          )
                      ),
                      onPressed: Model.buttonCheck ? (){_alert();} : (){_showToast();},
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    ));
  }
}