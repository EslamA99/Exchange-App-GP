import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gp_version_01/Controller/itemController.dart';
import 'package:gp_version_01/Controller/userController.dart';
import 'package:gp_version_01/models/item.dart';
import 'package:provider/provider.dart';

import '../Screens/details_screen.dart';
import 'product_Item.dart';

// ignore: must_be_immutable
class Grid extends StatelessWidget {
  List<Item> items;
  Grid({this.items});
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () async {
          await Provider.of<ItemController>(context, listen: false)
              .checkBanedItem(items[index]);
          await Provider.of<UserController>(context, listen: false)
              .getDetailsOfOtherUser(items[index].itemOwner)
              .then((_) {
            print(Provider.of<UserController>(context, listen: false)
                .otherUserName);

            Navigator.pushNamed(context, Details.route, arguments: [
              items[index],
              true,
            ]);
          });
        },
        child: ProductItem(item: items[index]),
      ),
      staggeredTileBuilder: (int index) =>
          //StaggeredTile.count(2,index.isOdd?2:1 ),
          new StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
