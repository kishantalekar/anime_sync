// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:anime_sync/src/countdown/models/countdown_model.dart';
import 'package:anime_sync/src/countdown/widgets/countdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CountDownCard extends StatelessWidget {
  const CountDownCard({
    super.key,
    required this.card,
  });

  final CountdownModel card;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20.h),
        ListTile(
          minLeadingWidth: 0,
          leading: Container(
            width: 90.w,
            height: 90.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(card.imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            card.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(card.episode),
        ),
        Gap(15.h),
        CountDownItem(
          totalSeconds: int.parse(card.countdown),
        )
      ],
    );
  }
}
