import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/overview_screen/overview_screen.dart';
import 'package:frontend/screens/stats_screen/stats_screen.dart';
import 'package:frontend/screens/timer_screen/timer_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/timer_service.dart';
import 'package:frontend/services/user_data_service.dart';

const double _fabDimension = 56.0;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;

    //select screen based on bottom navigation bar index
    switch (_index) {
      case 0:
        body = const OverviewScreen();
        break;
      case 1:
        body = const StatsScreen();
        break;
      case 2:
        body = const Center(child: Text("Profile"));
        break;
      default:
        //error: this should never happen!
        body = const Placeholder();
    }

    return Scaffold(
      body: Stack(
        children: [
          body,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 25,
              color: const Color.fromRGBO(249, 241, 231, 1),
              child: Center(
                child: Consumer(builder: (context, ref, _) {
                  final timerService = ref.watch(timerProvider);
                  return Text(
                      "${timerService.hours.twoDigits()}:${timerService.minutes.twoDigits()}:${timerService.seconds.twoDigits()}");
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        openBuilder: (BuildContext context, VoidCallback _) {
          return const TimerScreen();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Consumer(builder: (context, ref, _) {
                return Icon(
                  ref.watch(timerProvider).isRunning
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                );
              }),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        return BottomNavigationBar(
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_outlined),
              label: 'Stats',
            ),
            if (ref.watch(authProvider).user?.isAdmin ?? false)
              const BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings_outlined),
                label: 'Admin',
              ),
          ],
        );
      }),
    );
  }
}

extension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
