part of 'widgets_imports.dart';

class TimeSeparator extends StatelessWidget {
  const TimeSeparator({
    super.key,
    required this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20.w,
          height: 8.h,
          decoration: const BoxDecoration(color: TColors.primaryColor),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: TColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
