import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/timer_service.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(
          flex: 6,
          child: _UpperSection(),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
      ],
    ));
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

    final double maxHeight = MediaQuery.of(context).size.height;
    final double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Porsche AG',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: reducedFontColor,
                  ),
            ),

            const SizedBox(height: 10),

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

            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.1),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Work time 40 hours • Your daily rate 145€',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 100,
                        color: reducedFontColor,
                      ),
                ),
              ),
            ),

            SizedBox(height: maxHeight * 0.05),

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
