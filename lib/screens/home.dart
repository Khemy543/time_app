import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;

    //set bgImage
    String bgImage = data['isDaytime'] ? 'day.jpeg' : 'night.jpeg';
    Color bgColor = data['isDaytime'] ? Colors.white : Colors.black;
    Color textColor = data['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(children: [
              TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');

                    setState(() {
                      data = {
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDaytime': result['isDaytime'],
                        'location': result['location']
                      };
                    });
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit location')),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 28.0, letterSpacing: 2.0, color: textColor),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                data['time'],
                style: TextStyle(fontSize: 66.0, color: textColor),
              )
            ]),
          ),
        )));
  }
}
