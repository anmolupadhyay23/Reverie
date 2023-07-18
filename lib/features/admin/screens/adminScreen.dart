import 'package:flutter/material.dart';
import 'package:riverie/features/admin/screens/orderScreen.dart';
import 'package:riverie/features/admin/screens/postScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int _page=0;
  double _bottomBarWidth=42;
  double _bottomBarBorderWidth=5;

  List<Widget> pages = [
    const PostsScreen(),
    const Center(
      child: Text('Analytics Page'),
    ),
    const OrderScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                // gradient: GlobalVariables.appBarGradient, // Color can be changed from globalVariables
                  color: Colors.white
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  // child: Image.asset('assets/riverie.png',width: 120,height: 45,color: Colors.black,),
                  child: Text(
                    'Riverie',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 20
                    ),
                  ),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                )
              ],
            ),
          ),
        ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // POSTS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==0 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: const Icon(
                    Icons.home_outlined
                ),
              ),
              label: ''
          ),
          // ANALYTICS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==1 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ''
          ),
          // ORDERS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page==2 ? Colors.black : Colors.black12,
                            width: _bottomBarBorderWidth
                        )
                    )
                ),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ''
          ),
        ],
      ),
    );
  }
}
