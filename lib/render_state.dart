// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class RenderState {}

class LoadingUserPreset extends RenderState {}

class Rendered extends RenderState {
  final List<ComponentState> componentState;
  Rendered({
    required this.componentState,
  });

  Rendered copyWith({
    List<ComponentState>? componentState,
  }) {
    return Rendered(
      componentState: componentState ?? this.componentState,
    );
  }
}

class ComponentState {
  final Position position;
  final Dimension dimension;
  final bool isExpanded;
  ComponentState({
    required this.position,
    required this.dimension,
    required this.isExpanded,
  });

  ComponentState copyWith({
    Position? position,
    Dimension? dimension,
    bool? isExpanded,
  }) {
    return ComponentState(
      position: position ?? this.position,
      dimension: dimension ?? this.dimension,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class Position {
  final double x;
  final double y;

  Position(this.x, this.y);

  Position updateX(double x) => Position(x, y);

  Position updateY(double y) => Position(x, y);
}

class Dimension {
  final double w;
  final double h;
  Dimension(this.w, this.h);

  Dimension changeWidth(double w) => Dimension(w, h);

  Dimension changeHeight(double w) => Dimension(w, h);
}
