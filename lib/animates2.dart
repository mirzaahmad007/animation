import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Animates2 extends StatefulWidget {

  const Animates2({super.key});

  @override
  State<Animates2> createState() => _Animates2State();
}

class _Animates2State extends State<Animates2>
with SingleTickerProviderStateMixin{
  int count=0;

  bool like=false;


void increament(){
  setState(() {
    count++;
  });
}
void decreament(){
  setState(() {
   if(count>0){
     count--;
   }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                like=!like;
              });
            },
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 200),
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
            child: like? Icon(Icons.favorite_outline): Icon(Icons.favorite, color: Colors.red,),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width*0.4,
            height: MediaQuery.of(context).size.height*0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.blue.shade300
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              
              children: [
                GestureDetector(
                  onTap:increament,
                    child: Icon(Icons.add, size: 25,)),
                GestureDetector(
                  onTap: (){

                  },
                    child: Text("$count", style: GoogleFonts.nerkoOne(fontSize: 24),)),
                GestureDetector(
                  onTap: decreament,
                    child: Icon(Icons.remove, size: 25,))

              ],

            ),
          )
        ],
      ),
    );
  }
}
