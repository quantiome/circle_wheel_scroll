import 'package:flutter/material.dart';
import 'package:circle_wheel_scroll/circle_list_child_delegate.dart';

/// A delegate that supplies children for [CircleListScrollView] using an
/// explicit list.
///
/// [CircleListScrollView] lazily constructs its children to avoid creating more
/// children than are visible through the [Viewport]. This delegate provides
/// children using an explicit list, which is convenient but reduces the benefit
/// of building children lazily.
///
/// In general building all the widgets in advance is not efficient. It is
/// better to create a delegate that builds them on demand using
/// [ListWheelChildBuilderDelegate] or by subclassing [ListWheelChildDelegate]
/// directly.
///
/// This class is provided for the cases where either the list of children is
/// known well in advance (ideally the children are themselves compile-time
/// constants, for example), and therefore will not be built each time the
/// delegate itself is created, or the list is small, such that it's likely
/// always visible (and thus there is nothing to be gained by building it on
/// demand). For example, the body of a dialog box might fit both of these
/// conditions.
class CircleListChildListDelegate extends CircleListChildDelegate {
  /// Constructs the delegate from a concrete list of children.
  CircleListChildListDelegate({@required this.children, @required this.activeChildCount}) : assert(children != null);

  /// The list containing all children that can be supplied.
  final List<Widget> children;

  @override
  final int activeChildCount;

  @override
  int get estimatedChildCount => children.length;

  @override
  Widget build(BuildContext context, int index) {
    if (index < 0 || index >= children.length) return null;
    return IndexedSemantics(child: children[index], index: index);
  }

  @override
  bool shouldRebuild(covariant CircleListChildListDelegate oldDelegate) {
    return children != oldDelegate.children;
  }
}
