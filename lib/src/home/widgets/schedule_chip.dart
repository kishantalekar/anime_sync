part of 'widgets_imports.dart';

class ScheduleChip extends StatelessWidget {
  const ScheduleChip(
      {super.key,
      required this.isActive,
      required this.day,
      required this.index,
      required this.setActive});

  final bool isActive;
  final int index;
  final String day;
  final Function setActive;

  @override
  Widget build(BuildContext context) {
    final List<String> some = day.split(' ');
    final String dayy = some[0];
    // final String month = some[1];
    final String date = some[2];

    return GestureDetector(
      onTap: () {
        setActive(index);
      },
      child: Chip(
          backgroundColor: isActive ? TColors.primaryColor : null,
          shape: const OvalBorder(),
          label: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dayy,
              ),
              Text(date)
            ],
          )),
    );
  }
}
