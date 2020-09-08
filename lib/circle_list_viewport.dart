import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:circle_wheel_scroll/circle_list_child_delegate.dart';
import 'package:circle_wheel_scroll/circle_wheel_render.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';

/// A viewport showing a subset of children on a wheel.
///
/// Typically used with [CircleListScrollView], this viewport is similar to
/// [Viewport] in that it shows a subset of children in a scrollable based
/// on the scrolling offset and the children's dimensions. But uses
/// [RenderCircleListViewport] to display the children on a wheel.
///
/// See also:
///
///  * [CircleListScrollView], widget that combines this viewport with a scrollable.
///  * [RenderCircleListViewport], the render object that renders the children
///    on a wheel.
class CircleListViewport extends RenderObjectWidget {
  /// Creates a viewport where children are rendered onto a wheel.
  ///
  /// The [diameterRatio] argument defaults to 2.0 and must not be null.
  ///
  /// The [itemSize] argument in pixels must be provided and must be positive.
  ///
  /// The [clipToSize] argument defaults to true and must not be null.
  ///
  /// The [renderChildrenOutsideViewport] argument defaults to false and must
  /// not be null.
  ///
  /// The [offset] argument must be provided and must not be null.
  const CircleListViewport({
    Key key,
    @required this.itemSize,
    this.clipToSize = true,
    this.renderChildrenOutsideViewport = false,
    @required this.offset,
    @required this.childDelegate,
    @required this.axis,
    this.radius = 100,
  })  : assert(childDelegate != null),
        assert(offset != null),
        assert(itemSize != null),
        assert(clipToSize != null),
        assert(renderChildrenOutsideViewport != null),
        assert(
          !renderChildrenOutsideViewport || !clipToSize,
          RenderCircleListViewport.clipToSizeAndRenderChildrenOutsideViewportConflict,
        ),
        assert(axis != null),
        super(key: key);

  /// {@macro flutter.rendering.wheelList.itemExtent}
  final Size itemSize;

  /// {@macro flutter.rendering.wheelList.clipToSize}
  final bool clipToSize;

  /// {@macro flutter.rendering.wheelList.renderChildrenOutsideViewport}
  final bool renderChildrenOutsideViewport;

  /// [ViewportOffset] object describing the content that should be visible
  /// in the viewport.
  final ViewportOffset offset;

  /// A delegate that lazily instantiates children.
  final CircleListChildDelegate childDelegate;

  final Axis axis;

  final double radius;

  @override
  CircleListElement createElement() => CircleListElement(this);

  @override
  RenderCircleListViewport createRenderObject(BuildContext context) {
    final CircleListElement childManager = context as CircleListElement;
    return RenderCircleListViewport(
      axis: axis,
      radius: radius,
      childManager: childManager,
      offset: offset,
      itemSize: itemSize,
      clipToSize: clipToSize,
      renderChildrenOutsideViewport: renderChildrenOutsideViewport,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderCircleListViewport renderObject) {
    renderObject
      ..axis = axis
      ..radius = radius
      ..offset = offset
      ..itemSize = itemSize
      ..clipToSize = clipToSize
      ..renderChildrenOutsideViewport = renderChildrenOutsideViewport;
  }
}
