import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/services/timer_service.dart';
import 'package:frontend/widgets/entry_list_tile.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Column(
        children: [
          Expanded(
            flex: 6,
            child: _UpperSection(),
          ),
          Expanded(
            flex: 4,
            child: _LowerSection(),
          ),
        ],
      ),
    );
  }
}

class _UpperSection extends ConsumerWidget {
  const _UpperSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerService = ref.watch(timerProvider);

    final timerTextTheme = Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 100,
          color: const Color(0xFFfefdfd),
        );

    const reducedFontColor = Color(0xFFf5ddaf);

    final double maxWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //custom app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/logo-black.svg',
                    height: 19,
                  ),
                  const Expanded(child: SizedBox()),
                  //container with rounded corners, a centered icon and a ripple effect
                  Material(
                    color: reducedFontColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        //Show snackbar "Your settings are managed by your company"
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Your settings are managed by your company',
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.settings,
                          color: reducedFontColor,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  VerticalDivider(
                    color: reducedFontColor.withOpacity(0.7),
                    indent: 17,
                    endIndent: 17,
                  ),
                  _CustomIconButton(
                    onPressed: () {},
                    icon: Icons.keyboard_arrow_down,
                    size: 15,
                    filled: true,
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: reducedFontColor.withOpacity(0.3),
            indent: 20,
            endIndent: 20,
            height: 1,
          ),

          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),

          Text(
            '• Porsche AG',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: reducedFontColor,
                ),
          ),

          const SizedBox(height: 14),

          //hour:minute:second timer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.1),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timerService.hours.twoDigits(),
                    style: timerTextTheme,
                  ),
                  Text(
                    ':',
                    style: timerTextTheme,
                  ),
                  Text(
                    timerService.minutes.twoDigits(),
                    style: timerTextTheme,
                  ),
                  Text(
                    ':',
                    style: timerTextTheme,
                  ),
                  Text(
                    timerService.seconds.twoDigits(),
                    style: timerTextTheme?.copyWith(
                      color: const Color(0xFFe7b480),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 7),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.11),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Work time 40 hours • Your daily rate \$145',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 100,
                      color: reducedFontColor,
                    ),
              ),
            ),
          ),

          const Expanded(child: SizedBox()),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //start timer button
              if (!timerService.wasRunningOnce)
                _CustomIconButton(
                  onPressed: timerService.startTimer,
                  icon: Icons.play_arrow,
                  filled: true,
                  tooltip: 'Start timer',
                ),

              //pause timer button
              if (timerService.wasRunningOnce && timerService.isRunning)
                _CustomIconButton(
                  onPressed: timerService.pauseTimer,
                  icon: Icons.pause,
                  filled: true,
                  tooltip: 'Pause timer',
                ),

              //start timer button when paused
              if (timerService.wasRunningOnce && !timerService.isRunning)
                _CustomIconButton(
                  onPressed: timerService.startTimer,
                  icon: Icons.play_arrow,
                  filled: true,
                  tooltip: 'Resume timer',
                ),

              //stop timer button
              if (timerService.wasRunningOnce)
                _CustomIconButton(
                  onPressed: timerService.resetTimer,
                  icon: Icons.stop,
                  filled: false,
                  tooltip: 'Stop timer',
                ),
            ],
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _LowerSection extends StatelessWidget {
  const _LowerSection({super.key});

  @override
  Widget build(BuildContext context) {
    //foreground color: white, background color: primary color, rounded corners on the top
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "This week you worked",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: const [
                  EntryListTile(
                    title: "Monday 10.04",
                    subtitle: "Office",
                    duration: 2,
                  ),
                  EntryListTile(
                    title: "Tuesday 11.04",
                    subtitle: "Remote",
                    duration: 2.4,
                  ),
                  EntryListTile(
                    title: "Wednesday 12.04",
                    subtitle: "Office",
                    duration: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    required this.filled,
    this.size = 35,
    this.tooltip,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;
  final double size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    const highlight = Color(0xFFfefdfd);

    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: highlight, width: 2),
          color: filled ? highlight : Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.17),
          child: Icon(
            icon,
            color: filled ? primary : highlight,
          ),
        ),
      ),
      iconSize: size,
      color: highlight,
    );
  }
}

extension on int {
  String twoDigits() => toString().padLeft(2, '0');
}
