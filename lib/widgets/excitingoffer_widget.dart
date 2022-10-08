import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/exciting_offers.dart';

class ExcitingOffer extends StatefulWidget {
  const ExcitingOffer({Key? key, required this.offer}) : super(key: key);
  final ExcitingOffers offer;
  @override
  State<ExcitingOffer> createState() => _ExcitingOfferState();
}

class _ExcitingOfferState extends State<ExcitingOffer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build;
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 5,
                color: Colors.grey.withOpacity(0.5))
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: widget.offer.image,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Theme.of(context).primaryColor),
                child: Text(
                  widget.offer.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              Text("${widget.offer.price_for_first_variant.toString()} ₹"),
              Text("For Variant: ${widget.offer.first_variant}"),
              Text("${widget.offer.price_for_second_variant.toString()} ₹"),
              Text("For Variant: ${widget.offer.second_variant}"),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0XFFE7AB3C)),
                child: const Text(
                  "SELL NOW",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
