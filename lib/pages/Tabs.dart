import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'CategoryPage.dart';
import 'HomePage.dart';
import 'UserPage.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentIndex = 0;
  PageController _pageController;
  List<Widget> list = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._pageController = new PageController(initialPage: this.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: this._pageController,
        children: this.list,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            this.currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("购物车")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的")),
        ],
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        currentIndex: this.currentIndex,
        onTap: (index) {
          setState(() {
            this.currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
