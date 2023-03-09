import 'package:exp_design/render_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RendererCubit extends Cubit<RenderState> {
  RendererCubit() : super(LoadingUserPreset());

  late Dimension _totalSpace;
  late double _maxWidth;
  late double _maxHeight;
  late double _minWidth;
  late double _minHeight;
  bool _allClosed = true;
  final double _dragSpeed = 1.3;
  bool _mirrored = false;

  void startRendering(Dimension totalSpace) {
    _totalSpace = totalSpace;
    calculateComponentFlexibility();
    List<ComponentState>? componentState = List.generate(
      4,
      (index) => ComponentState(
        position: Position(0, 0),
        dimension: Dimension(0, 0),
        isExpanded: false,
      ),
    );
    defaultState(componentState);
    emit(Rendered(componentState: componentState));
  }

  void mirroredState(List<ComponentState> componentStates) {
    for (int idx = 0; idx < componentStates.length - 1; idx++) {
      Position currentPosition = componentStates[idx].position;
      componentStates[idx] = componentStates[idx]
          .copyWith(position: Position(_maxWidth, currentPosition.y));
    }
    componentStates[3] = componentStates[3].copyWith(position: Position(0, 0));
  }

  void renderNewState(int componentID, bool shouldExpand) {
    switch (componentID) {
      case 0:
        _update_cs1(shouldExpand);
        return;
      case 1:
        _update_cs2(shouldExpand);
        return;
      case 2:
        _update_cs3(shouldExpand);
        return;
    }
  }

  void onDragEnd() {
    List<ComponentState> componentStates = (state as Rendered).componentState;
    if (componentStates[0].position.x >= 1.25 * _minWidth) {
      mirroredState(componentStates);
      _mirrored = true;
    } else {
      defaultState(componentStates);
      _mirrored = false;
    }
    emit(Rendered(componentState: componentStates));
  }

  void dragComponents(double dx) {
    if (!_allClosed) return;
    List<ComponentState> componentStates = (state as Rendered).componentState;

    if (_outOfBounds(componentStates)) {
      onDragEnd();
      return;
    }

    for (int idx = 0; idx < componentStates.length - 1; idx++) {
      Position currentPosition = componentStates[idx].position;
      componentStates[idx] = componentStates[idx].copyWith(
        position: Position(
          currentPosition.x + (dx * _dragSpeed),
          currentPosition.y,
        ),
      );
    }
    Position currentPosition = componentStates[3].position;
    componentStates[3] = componentStates[3].copyWith(
        position: Position(currentPosition.x - dx, currentPosition.y));

    emit(Rendered(componentState: componentStates));
  }

  bool _outOfBounds(List<ComponentState> componentStates) {
    Position cs1 = componentStates[0].position;
    Position cs4 = componentStates[3].position;

    return (cs1.x < 0 ||
        cs1.x > (_totalSpace.w - _minWidth) ||
        cs4.x < 0 ||
        cs4.x > (_totalSpace.w - _maxWidth));
  }

  void _update_cs1(bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;

    if (shouldExpand) {
      componentStates[0] = componentStates[0].copyWith(
          isExpanded: true,
          dimension: Dimension(_minWidth, _maxHeight),
          position: _mirrored ? Position(_maxWidth, 0) : Position(0, 0));
      componentStates[1] = componentStates[1].copyWith(
        position: _mirrored
            ? Position(_maxWidth, _maxHeight)
            : Position(0, _maxHeight),
        isExpanded: false,
        dimension: Dimension(_minWidth, _minHeight),
      );
      componentStates[2] = componentStates[2].copyWith(
        position: Position(_minWidth, 0),
        dimension: Dimension(_minWidth, _totalSpace.h),
        isExpanded: true,
      );
      componentStates[3] = componentStates[3].copyWith(
        isExpanded: false,
        position: _mirrored ? Position(0, 0) : Position(_maxWidth, 0),
        dimension: Dimension(_minWidth, _totalSpace.h),
      );
    } else {
      componentStates[0] = componentStates[0].copyWith(
        isExpanded: false,
        dimension: Dimension(_minWidth, _minHeight),
        position: _mirrored ? Position(_maxWidth, 0) : Position(0, 0),
      );
      componentStates[1] = componentStates[1].copyWith(
        position: _mirrored
            ? Position(_maxWidth, _minHeight)
            : Position(0, _minHeight),
        dimension: Dimension(_minWidth, _minHeight),
        isExpanded: false,
      );
      componentStates[2] = componentStates[2].copyWith(
        position: _mirrored
            ? Position(_maxWidth, _maxHeight)
            : Position(0, _maxHeight),
        dimension: Dimension(_minWidth, _minHeight),
        isExpanded: false,
      );
      componentStates[3] = componentStates[3].copyWith(
        isExpanded: true,
        position: _mirrored ? Position(0, 0) : Position(_minWidth, 0),
        dimension: Dimension(_maxWidth, _totalSpace.h),
      );
    }

    _allClosed = !shouldExpand;

    emit((state as Rendered).copyWith(componentState: componentStates));
  }

  void _update_cs2(bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;
    if (shouldExpand) {
      if (!componentStates[0].isExpanded) {
        _update_cs1(true);
      }
      _swap(componentStates, 1, 2);
    } else {
      _update_cs1(false);
    }
    emit((state as Rendered).copyWith(componentState: componentStates));
  }

  void _update_cs3(bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;
    if (shouldExpand) {
      _update_cs1(true);
    } else {
      _update_cs1(false);
    }
    emit((state as Rendered).copyWith(componentState: componentStates));
  }

  void _swap<T>(List<T> arr, int i, int j) {
    T tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }

  void defaultState(List<ComponentState> componentState) {
    for (int idx = 0; idx < 3; idx++) {
      ComponentState cs = ComponentState(
        position: Position(0, idx * _minHeight),
        dimension: Dimension(_minWidth, _minHeight),
        isExpanded: false,
      );
      componentState[idx] = cs;
    }
    ComponentState cs4 = ComponentState(
      position: Position(_minWidth, 0),
      dimension: Dimension(_maxWidth, _totalSpace.h),
      isExpanded: true,
    );
    componentState[3] = cs4;
  }

  void calculateComponentFlexibility() {
    _minHeight = _totalSpace.h / 3;
    _minWidth = _totalSpace.w / 3;
    _maxHeight = _minHeight * 2;
    _maxWidth = _minWidth * 2;
  }
}
