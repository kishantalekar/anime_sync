// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:anime_sync/core/theme/colors.dart';
import 'package:anime_sync/src/countdown/widgets/count_down_card.dart';
import 'package:anime_sync/src/home/widgets/widgets_imports.dart';
import 'package:flutter/material.dart';
import 'package:anime_sync/src/countdown/cubit/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// {@template countdown_body}
/// Body of the CountdownPage.
///
/// Add what it does
/// {@endtemplate}
class CountdownBody extends StatefulWidget {
  /// {@macro countdown_body}
  const CountdownBody({super.key});

  @override
  State<CountdownBody> createState() => _CountdownBodyState();
}

class _CountdownBodyState extends State<CountdownBody> {
  void getCountdowns(String status) {
    context.read<CountdownCubit>().getCountdowns(status);
  }

  @override
  void initState() {
    super.initState();
    getCountdowns('trending');
  }

  final List<String> statusList = ['trending', 'upcoming', 'soon'];
  String selectedStatus = 'trending';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountdownCubit, CountdownState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$selectedStatus animes',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  DropdownButton<String>(
                    focusColor: Colors.yellow,
                    selectedItemBuilder: (BuildContext context) {
                      return statusList.map((String value) {
                        return SizedBox(
                          width: 100.w,
                          child: Align(
                            child: Text(
                              selectedStatus,
                              style: TextStyle(color: TColors.primaryColor),
                            ),
                          ),
                        );
                      }).toList();
                    },
                    items: statusList.map(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: value == selectedStatus
                                    ? TColors.primaryColor
                                    : null),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      if (value == selectedStatus) return;
                      setState(() {
                        selectedStatus = value!;
                        getCountdowns(selectedStatus);
                      });
                    },
                    value: selectedStatus,
                    borderRadius: BorderRadius.circular(12),
                    underline: Container(color: Colors.transparent),
                  ),
                ],
              ),
            ),
            ...switch (state) {
              CountdownLoaded() => [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Gap(20.h),
                        itemCount: state.countdownList.length,
                        itemBuilder: (context, index) {
                          final card = state.countdownList[index];
                          return CountDownCard(
                            card: card,
                          );
                        }),
                  )
                ],
              CountdownInitial() => [LoadingIndicator()],
              CountdownLoading() => [LoadingIndicator()],
              CountdownError() => [
                  Text(
                    state.failure.message,
                    style: TextStyle(color: Colors.white),
                  )
                ],
            }
          ],
        );
      },
    );
  }
}
