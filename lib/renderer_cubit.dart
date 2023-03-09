import 'package:exp_design/render_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RendererCubit extends Cubit<RenderState> {
  RendererCubit() : super(LoadingUserPreset());

  void getUserPreset() {}
}
