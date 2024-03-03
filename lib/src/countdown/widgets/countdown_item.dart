import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CountDownItem extends StatefulWidget {
  const CountDownItem({
    Key? key,
    required this.totalSeconds,
  }) : super(key: key);
  final int totalSeconds;
  @override
  State<CountDownItem> createState() => _CountDownItemState();
}

class _CountDownItemState extends State<CountDownItem> {
  late DateTime _date;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _date = DateTime.fromMillisecondsSinceEpoch(widget.totalSeconds * 1000);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      subOneSecond();
    });
  }

  void subOneSecond() {
    setState(() {
      _date = _date.subtract(const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget holder(String upper, String lower) {
    return Column(
      children: [
        Text(
          upper,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        Text(
          lower,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        holder(_date.day.toString(), "days"),
        Gap(25.w),
        holder(_date.hour.toString(), "hours"),
        Gap(25.w),
        holder(_date.minute.toString(), "min"),
        Gap(25.w),
        holder(_date.second.toString(), "sec"),
      ],
    );
  }
}
