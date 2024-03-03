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

  @override
  void initState() {
    super.initState();
    getSchedules();
  }

  int active = 0;

  void setActive(int index) {
    setState(() {
      active = index;
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
                          return ScheduleChip(
                            isActive: isActive,
                            index: index,
                            day: currentScheduleDay,
                            setActive: setActive,
                          );
                        }),
                  ),
                  Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        separatorBuilder: (context, i) => TimeSeparator(
                            time: state.schedules[active].schedule[i][0].time),
                        itemCount: state.schedules[active].schedule.length,
                        itemBuilder: (context, i) {
                          final activeSchedule = state.schedules[active];
                          final animes = activeSchedule.schedule[i];

                          return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: animes.length,
                              itemBuilder: (context, ani) {
                                final anime = animes[ani];

                                return ScheduleCard(
                                  anime: anime,
                                );
                              });
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
