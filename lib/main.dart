import 'package:calculator/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

var input = '';
var output = '';
var opartor = '';
var hideInput = false;
var outputSize = 25.0;
onButtonClick(value){
 if(value == 'C'){
  input ='';
  output = '';
 }
 else if(value == Icon(Icons.cancel_presentation)){
  if(input.isNotEmpty){
    input = input.substring(0,input.length -1);
  }
 }
 else if (value == "="){
  if(input.isNotEmpty){

    var userInput = input;

    userInput = input.replaceAll('x', '*');
    Parser p = Parser();
    Expression expression  = p.parse(userInput);
    ContextModel cm = ContextModel();
    var finalValue = expression.evaluate(EvaluationType.REAL, cm);
    output = finalValue.toString();
    if(output.endsWith('.0')){
    output = output.substring(0,output.length - 2);
    }  
// input = output;
hideInput = false;
outputSize = 50;

  }
  } else {
    input = input + value;
    outputSize = 25;
    hideInput = false;
    
  }
  setState(() {});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Column(
          children: [
          ///Input  
            Expanded(child: Container(
              color: Colors.black,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
               mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(hideInput?'': input,
                style: TextStyle(fontSize: 35,
                color: Colors.white),),
                SizedBox(height:20,),
                Text(output,
                style: TextStyle(fontSize: outputSize,
                color: Colors.white.withOpacity(0.7)),)
              ],
            ),)),

          ///Button
          Row(
            children: [button(text: 'C',bgbtnColor: opratorColor),
            button(text: '%',bgbtnColor: opratorColor),
            clearBtn(),
            button(text: '/',bgbtnColor: opratorColor),],
          ),
          Row(
            children: [button(text: '7'),
            button(text: '8'),
            button(text: '9'),
            button(text: 'x',bgbtnColor: opratorColor),],
          ),
          Row(
            children: [button(text: '4'),
            button(text: '5'),
            button(text: '6'),
            button(text: '-',bgbtnColor: opratorColor),],
          ),
          Row(
            children: [button(text: '1'),
            button(text: '2'),
            button(text: '3'),
            button(text: '+',bgbtnColor: opratorColor),],
          ),
          Row(
            children: [button(text: '00'),
            button(text: '0'),
            button(text: '.'),
            button(text: '=',bgbtnColor: blueColor),],
          )],
        ),

    );
  }
  Widget button ({text, txtColor = Colors.white ,bgbtnColor = buttonColor}){
  return Expanded(child: 
    Container(
      height: 75,
      width: 75,
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(8),
        primary: bgbtnColor
      ),
       onPressed: () => onButtonClick(text),
      child: Text(text,
      style: 
      TextStyle(fontSize:25,
      fontWeight: FontWeight.bold,
      color: txtColor)),
      ),
    ));
}

Widget clearBtn() {
    return Expanded(child: 
    Container(
      height: 75,
      width: 75,
      margin: EdgeInsets.all(8),
      child: ElevatedButton(onPressed: () {}, 
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(8),
        backgroundColor:opratorColor
      ),
      child: Icon(Icons.cancel_presentation,size: 25,)
      ),
    ));
  }

}
