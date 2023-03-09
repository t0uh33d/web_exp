// ignore_for_file: non_constant_identifier_names

import 'package:exp_design/common_colors.dart';
import 'package:exp_design/render_state.dart';
import 'package:exp_design/renderer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // component heights
  double c1_h = 100;
  double c2_h = 100;
  double c3_h = 100;
  double c4_h = 100;

  // component widths
  double c1_w = 100;
  double c2_w = 100;
  double c3_w = 100;
  double c4_w = 100;

  // position
  double c1_p = 0;
  double c2_p = 100;

  void changePosition() {
    setState(() {
      double tmp = c1_p;
      c1_p = c2_p;
      c2_p = tmp;
      isExpanded = !isExpanded;
    });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _appBar(),
        body: Row(
          children: [
            _sideBar(),
            Expanded(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double mh = constraints.maxHeight;
                double mw = constraints.maxWidth;
                return SizedBox(
                  height: mh,
                  width: mw,
                  child: BlocBuilder<RendererCubit, RenderState>(
                    builder: (context, state) {
                      if (state is Rendered) {
                        return Stack(
                          children: [],
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

  Widget component(Position position, Dimension dimension, Color color) {
    return AnimatedPositioned(
      top: position.y,
      left: position.x,
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
        width: dimension.w,
        height: dimension.h,
        padding: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 500),
        child: Container(color: color),
      ),
    );
  }

  Widget _sideBar() {
    return InkWell(
      onTap: changePosition,
      child: Container(
        color: CommonColors.primaryLightColor,
        height: double.infinity,
        width: 300,
      ),
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
