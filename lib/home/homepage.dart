import 'dart:convert';

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

    Future<List<Widget>> createList() async {
      List<Widget> list = [];
      String dataString = await DefaultAssetBundle.of(
        context,
      ).loadString("assets/data.json");
      List<dynamic> dataJSON = json.decode(dataString);

      dataJSON.forEach((element) {
        String finalString = "";
        List<String> dataList = List<String>.from(element["placeItems"]);
        dataList.forEach((item) {
          finalString += item + "|";
        });
        list.add(
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(5.0),

              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      element["placeImage"],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Text(
                              element["placeName"],
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.00),
                            child: Text(
                              finalString,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Text(
                              finalString,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      return list;
    }

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
                Container(
                  child: FutureBuilder(
                    initialData: <Widget>[Text('loading')],
                    future: createList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data!,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black54,
        child: Icon(Icons.hotel, color: Colors.white),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWith = MediaQuery.of(context).size.width;
    PageController controller = PageController(
      viewportFraction: 0.8,
      initialPage: 1,
    );
    List<Widget> banners = []; // Recommended creating list

    for (int i = 0; i < bannerItems.length; i++) {
      var bannerView = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(
                  bannerImages[i],
                  fit: BoxFit.cover,
                ), //ssquare,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bannerItems[i],
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                    Text(
                      "More than 40% off",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
