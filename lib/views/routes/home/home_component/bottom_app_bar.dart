import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text, required this.onPress});
  IconData iconData;
  String text;
  Function onPress;
}
class FABBottomAppBar extends StatefulWidget {
  const FABBottomAppBar({ 
    Key? key, 
    required this.items, 
    required this.centerItemText,
    this.iconSize = 20.0,
    required this.color, 
    required this.backgroundColor,
    this.height = 70,
  }) : super(key: key);

  final String centerItemText;
  final double height;
  final double iconSize;
  final Color color;
  final Color backgroundColor;
  final List<FABBottomAppBarItem> items;

  @override
  _FABBottomAppBarState createState() => _FABBottomAppBarState();
}

class _FABBottomAppBarState extends State<FABBottomAppBar> {

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
      shape: CircularNotchedRectangle(),
  );
}

  Widget _buildTabItem({required FABBottomAppBarItem item,required int index}) {
    Color color = widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => item.onPress(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}