import 'package:badges/badges.dart';
import 'package:firebase_demo/business_logic/models/menu.dart';
import 'package:firebase_demo/business_logic/viewmodels/cart_viewmodel.dart';
import 'package:firebase_demo/business_logic/viewmodels/home_viewmodel.dart';
import 'package:firebase_demo/ui/widgets/menu_item.dart';
import 'package:firebase_demo/ui/widgets/silver_appbar_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    _viewModel.loadHotelInfo();

    return Scaffold(
      drawer: _buildDrawer(context),
      body: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return _buildLoading();
        }
        if (viewModel.errorMessage.isNotEmpty) {
          return _buildError(viewModel.errorMessage);
        }
        return _buildBody(context, viewModel);
      }),
    );
  }
}

_buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

_buildBody(BuildContext context, HomeViewModel viewModel) {
  return DefaultTabController(
    length: viewModel.hotel.menuList.length,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 2,
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.white,
            actions: [
              Consumer<CartViewModel>(builder: (context, viewModel, child) {
                String count = '';
                if (viewModel.cartItems.length > 0) {
                  count = viewModel.cartItems.length.toString();
                }
                return Badge(
                  showBadge: count == '' ? false : true,
                  position: BadgePosition.topEnd(top: 3, end: 3),
                  badgeContent:
                      Text(count, style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.all(6),
                  animationType: BadgeAnimationType.fade,
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                );
              }),
            ],
            expandedHeight: 55.0,
            floating: true,
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: SliverAppBarDelegate(
              TabBar(
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: _buildTabItems(viewModel),
                isScrollable: true,
                indicatorColor: Colors.redAccent,
              ),
            ),
            pinned: true,
          ),
        ];
      },
      body: Center(
        child: TabBarView(
          children: _buildTabBody(viewModel),
        ),
      ),
    ),
  );
}

_buildTabItems(HomeViewModel viewModel) {
  List<Tab> items = [];
  viewModel.hotel.menuList.forEach((element) {
    items.add(Tab(
      icon: null,
      text: element.name,
    ));
  });
  return items;
}

_buildTabBody(HomeViewModel viewModel) {
  List<Widget> items = [];
  viewModel.hotel.menuList.forEach((menu) {
    items.add(Center(
      child: _buildMenuItems(menu),
    ));
  });
  return items;
}

_buildMenuItems(Menu menu) {
  return ListView.builder(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    itemCount: menu.dishList.length,
    itemBuilder: (context, index) {
      return MenuItem(
        dish: menu.dishList[index],
      );
    },
  );
}

_buildLoading() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 40,
          child: CupertinoActivityIndicator(animating: false, radius: 10),
        ),
      ],
    ),
  );
}

_buildError(String message) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 40,
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
