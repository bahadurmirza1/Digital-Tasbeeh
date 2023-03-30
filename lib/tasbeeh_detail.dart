import 'package:digital_tasbeeh/Model/tasbeeh.dart';
import 'package:digital_tasbeeh/database/dbhelper.dart';
import 'package:flutter/material.dart';

class TasbeehDetails extends StatefulWidget {
  const TasbeehDetails({super.key});
  // Tasbeeh t = new Tasbeeh();
  // String s;

  //TesbeehDetails(this.t);
  @override
  State<TasbeehDetails> createState() => _TasbeehDetailsState();
}

class _TasbeehDetailsState extends State<TasbeehDetails> {
  Tasbeeh tobj = new Tasbeeh();

  Counter() async {
    setState(() {
      tobj.tcount += 1;
      if (tobj.tcount % 100 == 0) {
        tobj.ttotal = tobj.tcount ~/ 100;
      }
    });
    await DatabaseHelper.instance.updateCounter(tobj);
  }

  @override
  Widget build(BuildContext context) {
    final t = ModalRoute.of(context)!.settings.arguments as Tasbeeh;
    tobj = t;
    return WillPopScope(
        onWillPop: () async {
          //print("BACK PRESS");
          //Navigator.pop(context, tobj);
          return true;
        },
        child: Scaffold(
            body: GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img4.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 300,
                              child: Text(
                                t.tname,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 253, 253, 253)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    Text(
                      tobj.tcount.toString(),
                      style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 8, 240, 4)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Counter();
                    //   },
                    //   child: Text('Press'),
                    //   style: ElevatedButton.styleFrom(
                    //     shape: CircleBorder(),
                    //     padding: EdgeInsets.all(24),
                    //   ),
                    // )
                  ],
                ),
              )),
          onTap: () {
            Counter();
          },
        )));
  }
}
