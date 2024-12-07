import 'package:flutter/material.dart';


class GridItemSlider extends StatefulWidget {
   final Map<String, dynamic> item;

  const GridItemSlider({super.key , required this.item});

  @override
  State<GridItemSlider> createState() => _GridItemSlider(item: item);
}

class _GridItemSlider extends State<GridItemSlider> {
 final Map<String, dynamic> item;

   _GridItemSlider({required this.item});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double factor = screenWidth < 550 ? 0.75 : 0.83;
    if (screenWidth < 460) factor = 0.6;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: item["value"] > 0 ? item["color"] : Colors.grey[700]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: screenWidth > 550
            ? EdgeInsets.symmetric(horizontal: 25 * factor ,vertical: 20 * factor - 4)
            : EdgeInsets.all(20 * factor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      item["icon"],
                      color: item["value"] > 0 ? item["color"] : Colors.grey[700]!,
                      size: (screenWidth < 600 ? 36 : 38) * factor,
                    ),
                    SizedBox(width: 12),
                    Text(
                      item["name"],
                      style: TextStyle(
                        color: item["value"] > 0 ? item["color"] : Colors.grey[700]!,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * factor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Value: ${(item['value'] * 100).toInt()}%",
                  style: TextStyle(
                    color: Colors.grey[700]!,
                    fontSize: 13 * factor,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5 * factor,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8 * factor),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 25 * factor * 0.81),
              ),
              child: Slider(
                value: (item['value'] as double),
                min: 0,
                max: 1,
                divisions: 100,
                onChanged: (newValue) {
                  item['value'] = newValue;
                  setState((){});
                },
                activeColor: item["value"] > 0 ? item["color"] : Colors.grey[700]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

