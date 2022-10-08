import 'package:upwork_app/widgets/appbar_widget.dart';
import 'package:upwork_app/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      const CustomAppbar(title: 'About Us'),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ShortCutTitle(
                title: "Our Humble Beginning",
              ),
              const SizedBox(height: 10),
              Text(
                "BuyBacKart came into existence in Feb 2020. It is the brainchild of Mr. Aftab Ansari who spent almost a decade in the industry before launching the brand. He started from scratch and today he proudly owns his venture BuyBacKart all by himself. He has a story to inspire the modern youth. He is a real-life hero who defeated all the odds to rise above all.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              const ShortCutTitle(
                title: "Early years of his struggle",
              ),
              const SizedBox(height: 10),
              Text(
                "Mr. Aftab Ansari suffered from the life-crippling disease polio right in early childhood that transformed his life. The disease made him hover between life and death after poliovirus started to spread in his body. His family spent all their money to make bring him out from the jaws of death. But sadly, the disease made his both legs paralyzed and left him disabled. He had to take the help of crutches to walk for the rest of his life.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "However, his parents left no stone unturned to bring him back to his legs and spent all their money on his treatment. Slowly and gradually, they started facing a scarcity of funds. The situation got so worse that he had to quit his school education to support his family.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "At the age of 18 when children go to school and enjoy life, Mr. Aftab was finding a job on his crutches to support his family. Fortunately, he got his first job offer as a sales executive for LG Electronics in April 2009. He worked for the company for almost 1 year and garnered a lot of appreciation from his seniors. After that, he joined BlackBerry in June 2010. Within a year, he was promoted as a sales trainer to train the sales team.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "After giving 1 year to BlackBerry, he joined HotSpot as a store manager in October 2011. It was a big break for him and he gave his best shot to get further growth in his career. Hence, he joined Samsung after that. By now, everyone around him started liking his skills and trusting him. He earned goodwill and respect from all four corners. In fact, his close friends also started pushing him to start his own venture due to his incredible skills, professional approach, and visionary thinking. They were even ready to support him financially.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "With God’s grace and friends’ support, Mr. Aftab Ansari opened his first store in 2015. After opening the first smartphone store, he opened 3 more stores consequently in GK, Shaheen Bagh, and Sainik Farm. After opening those stores, he tasted quick success. But, in 2017 he started facing losses due to the sudden boom of online e-commerce stores. The retail business saw a sudden downfall and it was getting very difficult to register profits. As a result, by the end of 2017, he went bankrupt",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              const ShortCutTitle(
                title: "He started exploring life",
              ),
              const SizedBox(height: 10),
              Text(
                "After facing heavy losses, he almost went into depression. However, he didn’t lose hope and started exploring life. He took a short sabbatical from work and started reading a lot of books. After reading books, he realized new ways to taste success and happiness. He gained a lot of knowledge about networking and business. One of the biggest lessons that he learned was ‘Networking’. He realized the importance of professional connections to grow and achieve goals without relying on traditional methods of making money.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "After building a network in a year or so, Mr. Aftab Ansari again took an eagle’s flight and started dreaming to build his new venture with Rs.4000 in his pocket. He used all his resources, connections, and skills to give birth to his dream venture, BuyBacKart.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              const ShortCutTitle(
                title: "How BuyBacKart was born",
              ),
              const SizedBox(height: 10),
              Text(
                "Finally, in Feb 2020, he officially registered BuyBacKart and started working hard day & night to spread it all over. To gain an online presence, he left no stone unturned to get in touch with the online audience. He started building a website and a team to take his company to the next level.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "Today, BuyBacKart is on the verge of completing it’s 2000 orders. With sheer dedication, hard work, and a positive attitude, Mr. Aftab Ansari is now back in the game. The brand has already made headlines in the online and offline market. It’s giving tough competition to it’s competitors with it’s best services and rates",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              const ShortCutTitle(
                title: "BuyBacKart",
              ),
              const SizedBox(height: 10),
              Text(
                "With BuyBacKart, he killed two birds with one stone.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "First off, he created a platform for frequent smartphone and gadget buyers who want to sell their used smartphones/gadgets at the best prices.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "Secondly, he opened the doors to all budget-centric customers who want to flaunt expensive smartphones, tablets, and laptops without burning a hole in their pockets",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "Along with that, he also started offering mobile repair services without causing a dent in their pockets. Knowing the high servicing and repairing cost of branded mobile phones, he started offering mobile repair services for all mobile brands at highly affordable prices.",
                style: TextStyle(fontSize: 45.sp),
              ),
              const SizedBox(height: 10),
              Text(
                "Hence, Mr. Aftab Ansari created a seamless, user-friendly, and highly beneficial platform for smartphone lovers. They can not only get the best prices for their used phones but can also buy used smartphones in a mint condition right from the website. Today, BuyBacKart is giving tough competition to it’s competitors with it’s incredible prices, offerings, and services. It has become one of the top online portals to buy and sell second-hand devices in Delhi NCR.",
                style: TextStyle(fontSize: 45.sp),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
