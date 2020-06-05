import 'package:flutter/material.dart';

// Currently does not have two states, open or closed but user can
// drag anywhere. Currently two different open
// GitHub issues addressing this similar feature.
// I used a combination NotificationListener's, ScrollNotification,
// DraggableScrollableNotification,
// and DraggableScrollableSheet to create the effect.
// Changing the DraggableScrollableSheet Key is the key to achieving the snap
// by changing the initialChildSize to _minExtent or _maxExtent.

class HomeBottomSheet extends StatefulWidget {
  const HomeBottomSheet({Key key}) : super(key: key);

  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  String _draggableScrollableSheetKey = DateTime.now().toString();
  double _minExtent = 0.1;
  double _maxExtent = 0.99;
  bool _isListViewScrolling = false;
  double _initialExtent = 0.1;
  double _dragExtentScrolled = 0.1;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          // Future use
        } else if (scrollNotification is ScrollUpdateNotification) {
          // Future use
        } else if (scrollNotification is ScrollEndNotification) {
          // If ListView content is not scrolling, then auto close/open sheet
          if (!_isListViewScrolling) {
            if (_dragExtentScrolled <= 0.3) {
              setState(() {
                _draggableScrollableSheetKey = DateTime.now().toString();
              });
              _initialExtent = _minExtent;
            }
            else if (_dragExtentScrolled >= 0.3 && _dragExtentScrolled < 0.6) {
              setState(() {
                _draggableScrollableSheetKey = DateTime.now().toString();
              });
              _initialExtent = _minExtent;
            }
            else if (_dragExtentScrolled >= 0.6 && _dragExtentScrolled <= 0.97) {
              setState(() {
                _draggableScrollableSheetKey = DateTime.now().toString();
              });
              _initialExtent = _maxExtent;
            }
            else if (_dragExtentScrolled >= 0.98) {
              // Need to catch it but do nothing, it will automatically fully open
              // This is in case user flings open the sheet
            }
            _isListViewScrolling = true;
          }
        }
        return false;
      },
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (DraggableScrollableNotification notification) {
          _dragExtentScrolled = notification.extent;
          _isListViewScrolling = notification.extent >= 0.1 ? false : true;
          return false;
        },
        child: DraggableScrollableSheet(
          key: Key(_draggableScrollableSheetKey),
          initialChildSize: _initialExtent,
          minChildSize: 0.1,
          maxChildSize: _maxExtent,
          builder: (BuildContext context, ScrollController controller) {
            // Using Slivers and SliverPersistentHeaderDelegate only because once the card
            // is dragged fully open, the header needs to stick to the top. But because the
            // top shape of the card has rounded corners, once you scroll content beyond
            // the top you can see through the rounded corners the scrolled content.
            // Without this requirement a simple SingleChildScrollView wold have worked
            return Container(
              color: Colors.lightBlue.shade900,
              child: CustomScrollView(
                controller: controller,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                        child: PreferredSize(
                          preferredSize: Size.fromHeight(80.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue.shade900,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 16.0),
                                Container(
                                  width: 50.0,
                                  height: 4.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                                  ),
                                ),
                                SizedBox(height: 14.0),
                                Text('Locations', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                //SizedBox(height: 16.0)
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/ocean.jpg'), fit: BoxFit.fitWidth),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Relaxing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 8.0),
                                    Text('Great place to vacation', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.lightBlue.shade900),),
                                    SizedBox(height: 8.0),
                                    Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', style: TextStyle(fontSize: 16, color: Colors.black)),
                                    Divider(thickness: 1.0),
                                    Wrap(
                                      children: <Widget>[
                                        Chip(label: Text('Miami'), avatar: Icon(Icons.airplanemode_active, color: Colors.grey,), backgroundColor: Colors.white70),
                                        Chip(label: Text('New York'), avatar: Icon(Icons.beach_access, color: Colors.grey,), backgroundColor: Colors.white70),
                                        Chip(label: Text('Huston'), avatar: Icon(Icons.motorcycle, color: Colors.grey,), backgroundColor: Colors.white70),
                                        Chip(label: Text('Tampa'), avatar: Icon(Icons.lightbulb_outline, color: Colors.grey,), backgroundColor: Colors.white70),
                                        Chip(label: Text('Phoenix'), avatar: Icon(Icons.spa, color: Colors.grey,), backgroundColor: Colors.white70),
                                      ],
                                    ),
                                    Divider(thickness: 1.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Using Slivers and SliverPersistentHeaderDelegate only because once the card
// is dragged fully open, the header needs to stick to the top. But because the
// top shape of the card has rounded corners, once you scroll content beyond
// the top you can see through the rounded corners the scrolled content.
// Without this requirement a simple SingleChildScrollView wold have worked
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarDelegate({ this.child });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white70,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}