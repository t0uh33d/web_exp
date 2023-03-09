// ignore_for_file: non_constant_identifier_names

import 'package:exp_design/common_colors.dart';
import 'package:exp_design/render_state.dart';
import 'package:exp_design/renderer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RendererCubit rendererCubit = GetCubit.find<RendererCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _appBar(),
        body: Row(
          children: [
            if (size.width > 600) _sideBar(),
            Expanded(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double mh = constraints.maxHeight;
                double mw = constraints.maxWidth;
                rendererCubit.startRendering(Dimension(mw, mh));
                return SizedBox(
                  height: mh,
                  width: mw,
                  child: BlocBuilder<RendererCubit, RenderState>(
                    builder: (context, state) {
                      if (state is Rendered) {
                        return Stack(
                          children: [
                            component(
                              position: state.componentState[0].position,
                              dimension: state.componentState[0].dimension,
                              color: CommonColors.quizWrongOptionColor,
                              componentID: 0,
                              isExpanded: state.componentState[0].isExpanded,
                            ),
                            component(
                              position: state.componentState[1].position,
                              dimension: state.componentState[1].dimension,
                              color: CommonColors.purpleDarkForegroundColor,
                              componentID: 1,
                              isExpanded: state.componentState[1].isExpanded,
                            ),
                            component(
                              position: state.componentState[2].position,
                              dimension: state.componentState[2].dimension,
                              color: CommonColors.menuIconColor,
                              componentID: 2,
                              isExpanded: state.componentState[2].isExpanded,
                            ),
                            component(
                              position: state.componentState[3].position,
                              dimension: state.componentState[3].dimension,
                              color: CommonColors.darkGreenTextColor,
                              componentID: 3,
                              isExpanded: state.componentState[3].isExpanded,
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: CommonColors.primaryColor,
                        ),
                      );
                    },
                  ),
                );
              },
            ))
          ],
        ));
  }

  Widget component({
    required Position position,
    required Dimension dimension,
    required Color color,
    required int componentID,
    required bool isExpanded,
  }) {
    return AnimatedPositioned(
      top: position.y,
      left: position.x,
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
        width: dimension.w,
        height: dimension.h,
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    rendererCubit.renderNewState(
                      componentID,
                      !isExpanded,
                    );
                  },
                  icon: Icon(
                    isExpanded ? Icons.close_fullscreen : Icons.open_in_full,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sideBar() {
    return Container(
      color: CommonColors.primaryLightColor,
      height: double.infinity,
      width: 300,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        "Moving widgets!!",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
      backgroundColor: CommonColors.primaryColor,
    );
  }
}
