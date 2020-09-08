import 'package:flutter/material.dart';

/// A delegate used by [RenderCircleListViewport] to manage its children.
///
/// [RenderCircleListViewport] during layout will ask the delegate to create
/// children that are visible in the viewport and remove those that are not.
abstract class CircleListChildManager {
  /// The maximum number of children that can be provided to
  /// [RenderCircleListViewport].
  ///
  /// If non-null, the children will have index in the range [0, childCount - 1].
  ///
  /// If null, then there's no explicit limits to the range of the children
  /// except that it has to be contiguous. If [childExistsAt] for a certain
  /// index returns false, that index is already past the limit.
  int get childCount;

  /// Checks whether the delegate is able to provide a child widget at the given
  /// index.
  ///
  /// This function is not about whether the child at the given index is
  /// attached to the [RenderCircleListViewport] or not.
  bool childExistsAt(int index);

  /// Creates a new child at the given index and updates it to the child list
  /// of [RenderCircleListViewport]. If no child corresponds to `index`, then do
  /// nothing.
  ///
  /// It is possible to create children with negative indices.
  void createChild(int index, {@required RenderBox after});

  /// Removes the child element corresponding with the given RenderBox.
  void removeChild(RenderBox child);

  /// return number of active items after which the scrolling should stop.
  int get activeChildCount;
}
