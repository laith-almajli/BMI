import 'dart:math';

import 'package:bmi/result.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

bool isSwitched = false;

class _HomeState extends State<Home> {
  double weight = 60;
  double heightVal = 150;
  bool isMale = true;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Body Mass Index",
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
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: isSwitched == false ? Colors.black : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    m1Expanded(context, 'male'),
                    const SizedBox(
                      width: 10,
                    ),
                    m1Expanded(context, 'female'),
                  ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Height",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: isSwitched == false
                                    ? Colors.black
                                    : Colors.white,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                heightVal.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w800,
                                  color: isSwitched == false
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text("CM",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isSwitched == false
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                            ],
                          ),
                          Slider(
                              activeColor: Colors.white,
                              inactiveColor: Colors.teal,
                              min: 150,
                              max: 250,
                              value: heightVal,
                              onChanged: (value) {
                                setState(() => heightVal = value);
                              }),
                        ],
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    m2Expanded(context, 'weight'),
                    const SizedBox(
                      width: 10,
                    ),
                    m2Expanded(context, 'age'),
                  ]),
                ),
              ),
              Container(
                color: Colors.teal,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                child: TextButton(
                    onPressed: () {
                      var result = weight / pow(heightVal / 100, 2);
                      newAlert(context, result);
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color:
                            isSwitched == false ? Colors.black : Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void newAlert(BuildContext context, double result) {
    final alert = AlertDialog(
      backgroundColor: isSwitched == false ? Colors.white : Colors.black,
      title: Text(
        "Alert Dealog",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isSwitched == false ? Colors.black : Colors.white,
        ),
      ),
      content: SizedBox(
        height: 125,
        child: Column(children: [
          Divider(
            color: isSwitched == false ? Colors.black : Colors.white,
          ),
          Text(
            "Age is : $age Years Old , Height is : ${heightVal.toStringAsFixed(1)} CM , Male : $isMale , Weight is : $weight KG",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSwitched == false ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Result(
                            result: result,
                            isMale: isMale,
                            age: age,
                            heightVal: heightVal,
                            weight: weight,
                          )));
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                child: const Text("Confirm"),
              ),
              const SizedBox(
                width: 7,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                child: const Text("Cancel"),
              )
            ],
          )
        ]),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext ctx) => alert,
        barrierDismissible: false);
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = type == 'male' ? true : false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (isMale && type == 'male') || (!isMale && type == 'female')
                ? Colors.blue
                : Colors.pink,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(type == 'male' ? Icons.male : Icons.female,
                  size: 90,
                  color: isSwitched == false ? Colors.white : Colors.black),
              const SizedBox(
                height: 15,
              ),
              Text(
                type == "male" ? 'Male' : 'Female',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: isSwitched == false ? Colors.black : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == "age" ? 'Age' : 'Weight',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: isSwitched == false ? Colors.black : Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  type == "age" ? '$age' : '$weight',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w800,
                    color: isSwitched == false ? Colors.white : Colors.black,
                  ),
                ),
                Text(type == "age" ? 'YO' : 'KG',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSwitched == false ? Colors.black : Colors.white,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age++ : weight++;
                    });
                  },
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                  child: Icon(Icons.add,
                      color: isSwitched == false ? Colors.white : Colors.black),
                ),
                const SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age-- : weight--;
                    });
                  },
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                  child: Icon(Icons.remove,
                      color: isSwitched == false ? Colors.white : Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
