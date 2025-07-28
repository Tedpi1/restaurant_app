import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var bannerItems = ["Burgers", "Pizza", "Chesse Chilly", "Noodles", "Drinks"];
var bannerImages = [
  "images/burger.jpg",
  "images/pizza.jpg",
  "images/cheesechilly.jpg",
  "images/noodles.jpg",
  "images/hawkers.jpg",
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWith = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWith,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                      Text(
                        'Food App',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Samantha",
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                    ],
                  ),
                ),
                BannerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWith = MediaQuery.of(context).size.width;
    PageController controller = PageController(initialPage: 1);
    List<Widget> banners = []; // Recommended creating list

    for (int i = 0; i < bannerItems.length; i++) {
      var bannerView = Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(bannerImages[i], fit: BoxFit.cover), //ssquare
          ],
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      width: screenWith,
      height: screenWith * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
