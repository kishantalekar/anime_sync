part of 'widgets_imports.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: 140.w,
              height: 140.h,
              imageUrl: anime.imgSrc,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Skeletonizer(
                  child: Skeleton.replace(
                child: Container(),
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    anime.episodeNo,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: TColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
