import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Convertor(),
    );
  }
}
class Convertor extends StatefulWidget {
  const Convertor({Key? key}) : super(key: key);

  @override

  State<Convertor> createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  @override


  void initState(){
    userInput=0;
    super.initState();
  }
  late double userInput;
  late String from='Meters (m)';
  late String to='Meters (m)';
  late String resultMessage='Result';
  final List<String> measures = ['Meters (m)', 'Kilometers (Km)', 'Grams (g)', 'Kilograms (Kg)', 'Feet', 'Miles','Pounds'];

  final Map<String,int> Convert={
    'Meters (m)' : 0,
    'Kilometers (Km)' : 1,
    'Grams (g)' : 2,
    'Kilograms (Kg)' : 3,
    'Feet' : 4,
    'Miles' : 5,
    'Pounds' : 6
  };

  dynamic formulas ={
    '0' :[1,0.001,0,0,3.280,0.0006213,0],
    '1' :[1000,1,0,0,3280.84,0.6213,0],
    '2' :[0,0,1,0.001,0,0,0.00220],
    '3' :[0,0,1000,1,0,0,2.2046],
    '4' :[0.0348,0.00030,0,0,1,0.000189,0],
    '5' :[1609.34,1.60934,0,0,5280,1,0],
    '6' :[0,0,453.592,0.4535,0,0,1],
  };

void convert(double value, String _from, String _to){

  int? nfrom=Convert[_from];
  int? nto=Convert[_to];
  var multi=formulas[nfrom.toString()][nto];
  var result=value*multi;

  if(result==0){
    resultMessage='Cannot perform this conversion';
  }
 else{
   resultMessage='${result.toString()} ${to.toString()}';
  }
 setState(() {
   resultMessage=resultMessage;
 });
}


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Center(child: Text('LENGTH CONVERTER',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: TextField(
                  onChanged: (text){

                    var input=double.tryParse(text);
                    if(input !=null){
                      setState(() {
                         userInput=input;
                      });
                    }
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText:'Enter Your Value',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('From',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton(
                    value: from,
                    dropdownColor: Colors.blue,
                    iconEnabledColor: Colors.white,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Choose a Unit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    items: measures.map((String value){
                    return DropdownMenuItem(value: value,
                    child: Center(child: Text(value,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),);
                  }).toList(),
                  onChanged: (value){
                      setState(() {
                        from=value.toString();
                      });
                  },),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('To',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton(
                    value: to,
                    dropdownColor: Colors.blue,
                    iconEnabledColor: Colors.white,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Choose a Unit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    items: measures.map((String value){
                      return DropdownMenuItem(value: value,
                        child: Center(child: Text(value,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),);
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        to=value.toString();
                      });
                    },),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: (){

                  if(from.isEmpty || to.isEmpty || userInput==0){
                    return;
                  }
                  else{
                    convert(userInput,from,to);
                  }

                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text('CONVERT',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
              SizedBox(height: 50,),
              Text((resultMessage==null)?'':resultMessage,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}

