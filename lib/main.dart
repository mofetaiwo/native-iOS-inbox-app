import 'package:flutter/cupertino.dart';
import 'views/inbox_view.dart';

void main() {
  runApp(const mp2());
}

class mp2 extends StatelessWidget {
  const mp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'MP 2',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        brightness: Brightness.light,
      ),
      home: InboxView(),
    );
  }
}
