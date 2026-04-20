import 'dart:async';
import 'package:flutter/material.dart';

class AdjustableTimer extends StatefulWidget {
  const AdjustableTimer({super.key});

  @override
  State<AdjustableTimer> createState() => _AdjustableTimerState();
}

class _AdjustableTimerState extends State<AdjustableTimer> {
  int _initialSeconds = 30;
  int _currentSeconds = 30;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          _timer!.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _currentSeconds = _initialSeconds;
      _isRunning = false;
    });
  }

  void _adjustTime(int seconds) {
    setState(() {
      _initialSeconds += seconds;
      if (_initialSeconds < 0) _initialSeconds = 0;
      if (!_isRunning) {
        _currentSeconds = _initialSeconds;
      }
    });
  }

  String get _formattedTime {
    int minutes = _currentSeconds ~/ 60;
    int remainingSeconds = _currentSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rest Timer",
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _adjustTime(-10),
                icon: const Icon(Icons.remove_circle_outline),
                color: colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Text(
                _formattedTime,
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => _adjustTime(10),
                icon: const Icon(Icons.add_circle_outline),
                color: colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                label: Text(_isRunning ? "Pause" : "Start"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton.icon(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh),
                label: const Text("Reset"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  side: BorderSide(color: colorScheme.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
