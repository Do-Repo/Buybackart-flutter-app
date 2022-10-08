import 'package:upwork_app/pages/sellingPage/brandchoice_page.dart';
import 'package:upwork_app/widgets/animator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/sell_options.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({Key? key, required this.option}) : super(key: key);
  final SellOptions option;
  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      child: GestureDetector(
        onTap: (() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BrandChoice(option: option)));
        }),
        child: SizedBox(
          height: 350.sp,
          width: 350.sp,
          child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.5))
                ],
                // border: Border.all(
                //     style: BorderStyle.solid,
                //     width: 2,
                //     color: Theme.of(context).primaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: option.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        option.title,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
