part of 'widgets_imports.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void getSchedules() {
    context.read<HomeCubit>().getSchedules();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getSchedules();
  }

  int active = 0;

  void setActive(int index) {
    setState(() {
      active = index;
      _scrollController.animateTo(
        0.0, // Scroll to the top (position 0.0)
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...switch (state) {
              HomeInitial() => [const LoadingIndicator()],
              HomeLoading() => [const LoadingIndicator()],
              HomeLoaded() => [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: GestureDetector(
                      // onTap: getSchedules,
                      child: Text(
                        "Schedules",
                        style: TextStyle(
                            color: TColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    width: double.infinity,
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.schedules.length,
                        itemBuilder: (context, index) {
                          final isActive = active == index;
                          final currentScheduleDay = state.schedules[index].day;
                          // final int some =
                          //     int.parse(currentScheduleDay.split(' ')[2]);
                          // print(DateTime.now().day == some);
                          return ScheduleChip(
                            isActive: isActive,
                            index: index,
                            day: currentScheduleDay,
                            setActive: setActive,
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        itemCount: state.schedules[active].schedule.length,
                        itemBuilder: (context, i) {
                          final activeSchedule = state.schedules[active];
                          final animes = activeSchedule.schedule[i];
                          var time = state.schedules[active].schedule[i];
                          var timeString = "";
                          if (time.isEmpty) {
                            timeString = "";
                          } else {
                            timeString = time[0].time;
                          }
                          return Column(
                            children: [
                              Gap(20.h),
                              TimeSeparator(time: timeString),
                              ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: animes.length,
                                  itemBuilder: (context, ani) {
                                    final anime = animes[ani];

                                    return ScheduleCard(
                                      anime: anime,
                                    );
                                  }),
                            ],
                          );
                        }),
                  )
                ],
              HomeError() => [Text(state.failure.message)],
            },
          ],
        );
      },
    );
  }
}
