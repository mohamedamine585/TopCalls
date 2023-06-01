import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:topcalls/Call.dart';
import 'package:topcalls/CallsService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  CallsService callsService = CallsService();
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
        });
      },
      child: Scaffold(
        body: FutureBuilder(
          future: callsService.fetch_top_cotnact(),
          
          builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) { 
                int totald ;
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) { 
                   totald = (snapshot.data?.elementAt(index).totalduration ?? 0);
                    return Container(
                      
                      child: Card(
                        
                        color: (index == 0)? Colors.amber:Color.fromARGB(255, 226, 216, 216),
                        child: Row(
                          children: [
                            Container(
                              width: 25,
                              child: (index == 0)?Icon(Icons.favorite):Text("  ${index - 1 }"),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: 120,
                              child: Text("N: "+(snapshot.data?.elementAt(index).contact ?? ""),softWrap: true,)),
                              Container(
                                width: 90,
                                child: Text(" total duration : "+((totald < 10000)?totald.toString():(totald/1000).toInt().toString() + "k"),softWrap: true,),
                              ),
                              Container(
                                width: 100,
                                child: Text(" last call : " + (snapshot.data?.elementAt(index).lastcall).toString(),softWrap: true,),
                              )
                          ],
                        ),
                      ),
                    );
                   },
                  
                );
           },
          
        ),
      ),
    );
  }
}