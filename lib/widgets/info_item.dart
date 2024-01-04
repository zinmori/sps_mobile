import 'package:flutter/material.dart';
import 'package:sps_mobile/widgets/info_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });
  final int id;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => InfoDetail(
                id: id,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(image),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
