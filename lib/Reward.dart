import 'package:flutter/material.dart';



class RewardPage extends StatefulWidget{

  _RewardPage createState() => _RewardPage();
}
class _RewardPage extends State<RewardPage>
{
double windowHeight=0;
double windowWidth=0;

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xff6ee1e0),
       elevation: 0,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios),
         onPressed: (){
         },
       ),
       title: Text("REWARDS AND REFERALS", style: TextStyle(
           color: Colors.black
       ),
       ),
     ),
      body: Container(
        height:MediaQuery.of(context).size.height ,
          width:MediaQuery.of(context).size.width ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(

               children: [
                 Container(

                   margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
                 child: Image.asset('images/circle.png',
                 height: 150,width: 150),

                ),
                 Container(
                   margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                   child: Image.asset('images/circle.png',
                   height: 150,width: 150),
                 ),
            ],
              ),
               Container(
                 margin: EdgeInsets.fromLTRB(20,20,30,0),
                 padding: EdgeInsets.fromLTRB(17,20,13,8),
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow:[
                       BoxShadow(
                         color:Colors.grey.withOpacity(0.5),
                         spreadRadius: 0,
                         blurRadius: 3,
                         offset: Offset(0,2),
                       )
                     ]
                 ),

                 child:Row(
                   children: [
                     Container(
                  child: Text(
                    "135DR4",

                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23
                    ),
                  ),
                     ),
                  Container(
                    margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Text("Copy code",
                    style: TextStyle(
                        color: Colors.black,

                        fontSize: 16

                 ),
                ),
                  ),
                 ],
                ),
               ),
              Container(
                  margin: EdgeInsets.fromLTRB(18,15,16,0),
                  padding: EdgeInsets.fromLTRB(5,10,10,10),
                  width: double.infinity,

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                      BoxShadow(
                      color:Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0,2),
                    )
                  ]
                      ),
                      child: Image.asset('images/facebook.png',scale: 5,
                      ),

                    ),
                    Container(

                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                              color:Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0,2),
                            )
                          ]
                      ),
                      child: Image.asset('images/instagram.jpg',scale: 5,),
                    ),
                    Container(

                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                              color:Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0,2),
                            )
                          ]
                      ),
                      child: Image.asset('images/whatsapp.png',scale: 5,),
                    ),
                    Container(

                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                              color:Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0,2),
                            )
                          ]
                      ),
                      child: Image.asset('images/share.png',scale: 5,),
                    ),
                  ],
                )
              ),
                Container(
                    margin: EdgeInsets.fromLTRB(28,0,16,0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(

                        child:Text("Facebook",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black

                          ),

                        ),
                      ),
                      Container(

                        child:Text("Instagram",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black

                        ),

                      ),
                      ),
                      Container(

                        child:Text("Whatsapp",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black

                        ),

                      ),
                      ),
                     Container(

                      child:Text("Share to Others",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.black

                        ),

                      ),),
                    ],
                  )
                ),
                Container(

                 margin: EdgeInsets.fromLTRB(10,5,10,0),
                 decoration: BoxDecoration(
                 color: Colors.white,

                  borderRadius: BorderRadius.circular(15),
                   boxShadow:[
                   BoxShadow(
                   color:Colors.grey.withOpacity(0.5),
                     spreadRadius: 0,
                     blurRadius: 3,
                     offset: Offset(0,2),
                     )
                   ]
                ),
                  child:Column(
                    children: [
                      Container(
                      child:Center(
                       child:Text("HOW TO EARN",
                      style: TextStyle(
                          color: Colors.black,

                          fontSize: 20
                      ),
                      ),
                      ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 200, 0),
                      child:Text("Rewards info 1",
                        style: TextStyle(
                            color: Colors.black,

                            fontSize: 15
                        ),
                      ),),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 200, 0),
                      child:Text("Rewards info 1",
                        style: TextStyle(
                            color: Colors.black,

                            fontSize: 15
                        ),
                      ),
                      ),
                        Container(
                         margin: EdgeInsets.fromLTRB(200, 20, 0, 5),
                          child:Text("View more details",
                          style: TextStyle(
                          color: Colors.black,

                        fontSize: 12
                          ),
                          ),
                           ),
                    ],
                  )
                ),
              Container(

                margin: EdgeInsets.all(10),
                child:Row
                  (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                   Container(

                       padding: EdgeInsets.fromLTRB(10,10,150,10),
                       decoration: BoxDecoration(
                           color: Colors.white,

                           borderRadius: BorderRadius.circular(15),
                           boxShadow:[
                             BoxShadow(
                               color:Colors.grey.withOpacity(0.5),
                               spreadRadius: 0,
                               blurRadius: 3,
                               offset: Offset(0,2),
                             )
                           ]
                       ),
                     child:Text("Have a code?",
                       style: TextStyle(
                         fontSize: 10,color: Colors.black

                       ),

                     )
                   ),
                       Container(

                         padding: EdgeInsets.fromLTRB(20,10,15,10),
                         decoration: BoxDecoration(
                             color: Color(0xff6ee1e0),

                             borderRadius: BorderRadius.circular(15),
                             boxShadow:[
                               BoxShadow(
                                 color:Colors.grey.withOpacity(0.5),
                                 spreadRadius: 0,
                                 blurRadius: 3,
                                 offset: Offset(0,2),
                               )
                             ]
                         ),
                       child:Text("REDEEM",
                       style: TextStyle(
                       fontSize: 12,color: Colors.black

                       ),
                       ),
                       ),
                  ],
                )
              ),
              FlatButton(
                child:Container(
                margin: EdgeInsets.fromLTRB(0,10,0,0),
               padding: EdgeInsets.fromLTRB(30, 3, 30, 5),
                decoration: BoxDecoration(
                    color: Color(0xff6ee1e0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),

                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(0,2),
                      )
                    ]
                ),
                child:Column(
                  children: [

                       Container(
                          child:Text(
                          "^",style: TextStyle(
                            fontSize: 18
                          ),
                          ),
                        ),
                       Container(

                          child:Text("Pull this too see your reward History",
                        style: TextStyle(
                      fontSize: 15

                ),
                ),
                ),
     ],
                    ),
              ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultPage()),
                  );
                },
              ),
            ],
                ),
              ),
               
          
   
        );

  }

}


class ResultPage extends StatefulWidget{
  _ResultPage createState() => _ResultPage();
}
class _ResultPage extends State<ResultPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6ee1e0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  RewardPage()));
          },
        ),
        title: Text("REWARDS AND REFERALS", style: TextStyle(
            color: Colors.black
        ),
        ),
      ),
      body: SingleChildScrollView(
        

        child:Column(

          children: [
            Container(


                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(15),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(0,2),
                      )
                    ]
                ),
                child:Column(
                  children: [
                    Container(
                      child:Center(
                        child:Text("Your code:345DF",style: TextStyle(
                            fontSize: 18
                        ),),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0, 20, 250, 0),
                      child:Text("Rewards info 1",style: TextStyle(
                          fontSize: 13,color: Colors.black
                      ),),
                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0, 20, 250, 0),
                      child:Text("Rewards info 1",style: TextStyle(
                          fontSize: 13,color: Colors.black
                      ),),

                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0, 20, 250, 0),
                      child:Text("Rewards info 1",style: TextStyle(
                          fontSize: 13,color: Colors.black
                      ),),

                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0, 20, 250, 10),
                      child:Text("Rewards info 1",style: TextStyle(
                          fontSize: 13,color: Colors.black
                      ),),

                    ),
                    Container(
                      margin:EdgeInsets.all(5),
                      padding: EdgeInsets.fromLTRB(35,10,35,10),
                      decoration: BoxDecoration(
                        color: Color(0xff6ee1e0),

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:Text("Share",style: TextStyle(
                          fontSize: 13,color: Colors.black
                      ),),
                    ),
                  ],
                )

            ),

              Container(
              margin:EdgeInsets.fromLTRB(2, 10, 2, 0) ,
              decoration: BoxDecoration(
                color: Color(0xff6ee1e0),

                borderRadius: BorderRadius.circular(15),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  Container(


                    child:Text("Your reward History",style:TextStyle(
                        fontSize: 18
                    ),),

                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(15),

                    ),
                    child:Row(
                      children: [
                        Container(

                          child: Text("128SDF",style: TextStyle(
                              fontSize: 30
                          ),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(150, 10, 5, 10),
                            child:Column(
                              children: [
                                Container(
                                    child:Text("Points earned",style: TextStyle(
                                        fontSize: 12
                                    ),)
                                ),
                                Container(
                                  child:Text("15",style: TextStyle(
                                      fontSize: 18
                                  )
                                  ),),
                              ],
                            )
                        )


                      ],
                    ) ,

                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(15),

                    ),
                    child:Row(
                      children: [
                        Container(

                          child: Text("128SDF",style: TextStyle(
                              fontSize: 30
                          ),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(150, 10, 5, 10),
                            child:Column(
                              children: [
                                Container(
                                    child:Text("Points earned",style: TextStyle(
                                        fontSize: 12
                                    ),)
                                ),
                                Container(
                                  child:Text("15",style: TextStyle(
                                      fontSize: 18
                                  )
                                  ),),
                              ],
                            )
                        )


                      ],
                    ) ,

                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(15),

                    ),
                    child:Row(
                      children: [
                        Container(

                          child: Text("128SDF",style: TextStyle(
                              fontSize: 30
                          ),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(150, 10, 5, 10),
                            child:Column(
                              children: [
                                Container(
                                    child:Text("Points earned",style: TextStyle(
                                        fontSize: 12
                                    ),)
                                ),
                                Container(
                                  child:Text("15",style: TextStyle(
                                      fontSize: 18
                                  )
                                  ),),
                              ],
                            )
                        )


                      ],
                    ) ,

                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(15),

                    ),
                    child:Row(
                      children: [
                        Container(

                          child: Text("128SDF",style: TextStyle(
                              fontSize: 30
                          ),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(150, 10, 5, 10),
                            child:Column(
                              children: [
                                Container(
                                    child:Text("Points earned",style: TextStyle(
                                        fontSize: 12
                                    ),)
                                ),
                                Container(
                                  child:Text("15",style: TextStyle(
                                      fontSize: 18
                                  )
                                  ),),
                              ],
                            )
                        )


                      ],
                    ) ,

                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(15),

                    ),
                    child:Row(
                      children: [
                        Container(

                          child: Text("128SDF",style: TextStyle(
                              fontSize: 30
                          ),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(150, 10, 5, 10),
                            child:Column(
                              children: [
                                Container(
                                    child:Text("Points earned",style: TextStyle(
                                        fontSize: 12
                                    ),)
                                ),
                                Container(
                                  child:Text("15",style: TextStyle(
                                      fontSize: 18
                                  )
                                  ),),
                              ],
                            )
                        )


                      ],
                    ) ,

                  ),






                ],


              ),


            ),
          ],),
      ),
    );

  }

}