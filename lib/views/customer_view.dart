import 'package:upwork_app/widgets/title_widget.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class CustomerTestimonials extends StatefulWidget {
  const CustomerTestimonials({Key? key}) : super(key: key);

  @override
  State<CustomerTestimonials> createState() => _CustomerTestimonialsState();
}

class _CustomerTestimonialsState extends State<CustomerTestimonials> {
  Container item(
      String imageUrl, String name, String description, String content) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            title: Text(
              name,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, letterSpacing: -0.7),
            ),
            subtitle: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: ShortCutTitle(
            title: "Customers Testimonials",
          ),
        ),
        ExpandablePageView(children: [
          item('assets/images/gurmeet.jpeg', "GURMEET AHUJA", "Customer",
              "I sold my iphone 13 Pro at very best price. I am very much happy with the services Highly recommend to everyone. Quick account transfer was again unexpected !! Thank you BuyBacKart."),
          item('assets/images/suman_pal.jpeg', "SUMAN PAL", "Customer",
              "I am very happy with BuyBacKart because I have many phones sales in BuyBacKart. the service is very convenient, with doorstep collection of phone and immediate payment in my bank account. Technician come from BuyBacKart, their behavior is very good. I would highly recommend to everyone for sell the old mobile phone in BuyBacKart.")
        ])
      ],
    );
  }
}
