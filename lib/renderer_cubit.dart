import 'package:exp_design/render_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RendererCubit extends Cubit<RenderState> {
  RendererCubit() : super(LoadingUserPreset());

  late Dimension totalSpace;
  late double maxWidth;
  late double maxHeight;
  late double minWidth;
  late double minHeight;
  void startRendering(Dimension totalSpace) {
    this.totalSpace = totalSpace;
    calculateComponentFlexibility();
    List<ComponentState>? componentState = [];
    defaultState(componentState);
    emit(Rendered(componentState: componentState));
  }

  void renderNewState(int componentID, bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;
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

  void _update_cs1(bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;
    if (shouldExpand) {
      componentStates[0] = componentStates[0].copyWith(
        isExpanded: true,
        dimension: Dimension(minWidth, maxHeight),
      );
      componentStates[1] = componentStates[1].copyWith(
        position: Position(0, maxHeight),
        isExpanded: false,
        dimension: Dimension(minWidth, minHeight),
      );
      componentStates[2] = componentStates[2].copyWith(
        position: Position(minWidth, 0),
        dimension: Dimension(minWidth, totalSpace.h),
        isExpanded: true,
      );
      componentStates[3] = componentStates[3].copyWith(
        isExpanded: false,
        position: Position(maxWidth, 0),
        dimension: Dimension(minWidth, totalSpace.h),
      );
    } else {
      componentStates[0] = componentStates[0].copyWith(
        isExpanded: false,
        dimension: Dimension(minWidth, minHeight),
      );
      componentStates[1] = componentStates[1].copyWith(
        position: Position(0, minHeight),
        dimension: Dimension(minWidth, minHeight),
        isExpanded: false,
      );
      componentStates[2] = componentStates[2].copyWith(
        position: Position(0, maxHeight),
        dimension: Dimension(minWidth, minHeight),
        isExpanded: false,
      );
      componentStates[3] = componentStates[3].copyWith(
        isExpanded: true,
        position: Position(minWidth, 0),
        dimension: Dimension(maxWidth, totalSpace.h),
      );
    }
    emit((state as Rendered).copyWith(componentState: componentStates));
  }

  void _update_cs2(bool shouldExpand) {
    List<ComponentState> componentStates = (state as Rendered).componentState;
    if (shouldExpand) {
      if (componentStates[0].isExpanded) {
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
        position: Position(0, idx * minHeight),
        dimension: Dimension(minWidth, minHeight),
        isExpanded: false,
      );
      componentState.add(cs);
    }
    ComponentState cs4 = ComponentState(
      position: Position(minWidth, 0),
      dimension: Dimension(maxWidth, totalSpace.h),
      isExpanded: true,
    );
    componentState.add(cs4);
  }

  void calculateComponentFlexibility() {
    minHeight = totalSpace.h / 3;
    minWidth = totalSpace.w / 3;
    maxHeight = minHeight * 2;
    maxWidth = minWidth * 2;
  }
}
