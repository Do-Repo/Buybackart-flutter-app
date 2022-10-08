// ignore_for_file: prefer_const_constructors

import 'package:upwork_app/anti_scam.dart';
import 'package:upwork_app/constants.dart';

import 'package:upwork_app/models/create_order.dart';

import 'package:upwork_app/models/user.dart';
import 'package:upwork_app/pages/about_page.dart';
import 'package:upwork_app/pages/homepage.dart';
import 'package:upwork_app/pages/profile_page.dart';
import 'package:upwork_app/pages/sellnow_page.dart';
import 'package:upwork_app/pages/authPages/additional_info_page.dart';
import 'package:upwork_app/pages/authPages/login_page.dart';
import 'package:upwork_app/pages/authPages/otp_page.dart';
import 'package:upwork_app/pages/authPages/singup_page.dart';
import 'package:upwork_app/services/shared_pref.dart';
import 'package:upwork_app/theme.dart';
import 'package:upwork_app/views/bloglist_view.dart';
import 'package:upwork_app/views/intro_view.dart';
import 'package:upwork_app/widgets/scrollbehavoir_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool ft = await isFirstTime();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CreateOrder()),
      ChangeNotifierProvider(create: (context) => UserModel())
    ],
    child: MyApp(firstTime: ft),
  ));
}

Future<bool> isFirstTime() async {
  bool firstTime = true;
  await getFirstTime().then((name) async {
    if (name == true) {
      firstTime = true;
      await setFirstTime(false);
    } else {
      firstTime = false;
    }
  });

  return firstTime;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.firstTime}) : super(key: key);
  final bool firstTime;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2160),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'BuyBacKart',
              theme: Styles.themeData(),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ScrollConfiguration(
                    behavior: MyBehavior(), child: child!);
              },
              home: (firstTime)
                  ? IntroView()
                  : Structure());
        });
  }
}

class Structure extends StatefulWidget {
  Structure({Key? key}) : super(key: key);

  @override
  State<Structure> createState() => _StructureState();
}

class _StructureState extends State<Structure>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    getSavedUser().then((value) {
      if (value != null) {
        Provider.of<UserModel>(context, listen: false).setUser(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: currentIndex,
          onTap: (index) {
            tabController.animateTo(index);
            setState(() => currentIndex = index);
          },
        ),
        extendBodyBehindAppBar: true,
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyHomePage(),
            AboutPage(),
            SellNowPage(),
            BlogList(),
            AuthStructure(
              hometabController: tabController,
            )
          ],
        ),
      ),
    );
  }
}

class AuthStructure extends StatefulWidget {
  const AuthStructure({Key? key, this.hometabController}) : super(key: key);
  final TabController? hometabController;

  @override
  State<AuthStructure> createState() => _AuthStructureState();
}

class _AuthStructureState extends State<AuthStructure>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController tabController;

  int handleNavigation(UserModel user) {
    int showPage = 0;
    if (user.id != null && user.token != null) {
      // User is logged in, verify if his profile is complete
      saveBelovedUser(user);
      if (user.email != "invalid@email.com") {
        // User profile is complete
        showPage = 2;
      } else {
        // User profile is not complete
        showPage = 1;
      }
    }
    return showPage;
  }

  void saveBelovedUser(UserModel user) async {
    await saveUser(user);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserModel>(
      builder: ((context, value, child) {
        return Scaffold(
          body: IndexedStack(index: handleNavigation(value), children: [
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  LoginPage(
                      homeTabController: widget.hometabController,
                      authTabController: tabController),
                  SignupPage(authTabController: tabController),
                  SignInOTP(authTabController: tabController),
                ]),
            const AdditionalInfo(),
            ProfilePage(
              homeTabController: widget.hometabController,
            )
          ]),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
