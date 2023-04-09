import 'package:flutter/material.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Timer',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 20),
                //hour:minute:second timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '00',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      '00',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      '00',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    ));
  }
}
