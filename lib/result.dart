import 'package:bmi/home.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result(
      {super.key,
      required this.result,
      required this.isMale,
      required this.age,
      required this.weight,
      required this.heightVal});

  final double result;
  final bool isMale;
  final int age;
  final double weight;
  final double heightVal;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String get resultPhrase {
    String resultText = "";
    if (widget.result >= 30) {
      resultText = "Obese";
    } else if (widget.result > 25 && widget.result < 30) {
      resultText = "Overweight";
    } else if (widget.result >= 18.5 && widget.result <= 24.9) {
      resultText = "Normal";
    } else
      resultText = "Thin";

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back,
                  color: isSwitched == false ? Colors.black : Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            );
          },
        ),
        title: Text(
          "Result",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isSwitched == false ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.black,
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        color: isSwitched == false ? Colors.black : Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Gender : ${widget.isMale ? 'Male' : 'Female'}',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  )),
              Text('Age : ${widget.age}',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  )),
              Text('Weight : ${widget.weight.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  )),
              Text('Height : ${widget.heightVal.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  )),
              Text('Result : ${widget.result.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  )),
              Text(
                'Healthiness : $resultPhrase',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                  color: isSwitched == false ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
