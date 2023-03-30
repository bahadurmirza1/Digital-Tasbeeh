import 'package:digital_tasbeeh/Model/tasbeeh.dart';
import 'package:digital_tasbeeh/database/dbhelper.dart';
import 'package:digital_tasbeeh/tasbeeh_detail.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  //TasbeehDetails td = new TasbeehDetails();
  const MainScreen({super.key});
  //MainScreen(this.td);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void submit() async {
    if (tasbeehName.text != null) {
      Tasbeeh t = new Tasbeeh();
      t.tcount = 0;
      t.ttotal = 0;
      t.tname = tasbeehName.text;
      DatabaseHelper.instance.insertTasbeeh(t).then((value) {
        print("Data Inserted");
      }).onError((error, stackTrace) {
        print(error);
      });
      await getData();
      setState(() {});
    }

    Navigator.of(context).pop(tasbeehName.text);
  }

  List<Tasbeeh> tlist = [];

  Future getData() async {
    tlist = await DatabaseHelper.instance.getAllData();
    setState(() {});
  }

  Future OpenDailog(String check, int id) => showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Tasbeeh'),
          content: TextField(
            controller: tasbeehName,
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter Tasbeeh"),
          ),
          actions: [
            TextButton(
                onPressed: (() {
                  //check == "update" ? update(id) : submit();
                  if (check == "update") {
                    update(id);
                  } else {
                    submit();
                  }
                }),
                child: Text("SUBMIT"))
          ],
        );
      });
  void update(int id) async {
    Tasbeeh t = new Tasbeeh();
    t.tid = id;
    t.tname = tasbeehName.text;
    t.tcount = 0;
    t.ttotal = 0;
    await DatabaseHelper.instance.updateCounter(t);
    Navigator.pop(context);
    getData();
  }

  TextEditingController tasbeehName = TextEditingController();

  @override
  void initState() {
    _requestSqlData();
  }

  void _requestSqlData() async {
    var v =await getData();
    print(v.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTapDown: (details) async {
        //   await getData();
        //   setState(() {});
        // },
        onPanDown: (details) async {
          await getData();
          setState(() {});
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Digital Tasbeeh"),
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: 620.0,
                  child: ListView.builder(
                      itemCount: tlist.length,
                      itemBuilder: (context, index) {
                        Tasbeeh t = tlist[index];

                        return Card(
                          elevation: 12.0,
                          child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TasbeehDetails(),
                                settings: RouteSettings(
                                  arguments: tlist[index],
                                ),
                              ),
                            );} ,
                          child: Container(
                          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: Colors.black,
  ),
                          
                          height: 70,
                          child: Row(
                            children: [
                             
                              SizedBox(width: 15,),
                              IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      OpenDailog("update", t.tid);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white),
                                    onPressed: () async {
                                      await DatabaseHelper.instance
                                          .deleteTasbeeh(t.tid);
                                      getData();
                                    }),

                                    SizedBox(width: 15,),
                                    Column(children: [
                                        SizedBox(height: 18,),
                                        Text("${t.ttotal.toString()}",
                                   style: TextStyle(fontSize: 18,color: Colors.white)),
                                   Text("${t.tcount.toString()}",
                                   style: TextStyle(fontSize: 10,color: Colors.white)),
                                      ],),
                                    
                                    
                                   
                                    SizedBox(width: 20,),

                                   SingleChildScrollView(child: Row(
                                     children: [
                                       Container(
                                        width: 125 
                                        ,
                                         child: Text(
                            t.tname,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            //overflow: TextOverflow.ellipsis,
                          ),
                                       ),
                                     ],
                                   )),
                              ],),
                        )));
                      }),
                ),
              ],
            )),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () async {
              tasbeehName.text = "";
              await OpenDailog("insert", 1);
            },
            tooltip: 'Increment',
            child: const Icon(
              Icons.add,
            ),
          ),
        ));
  }
}
