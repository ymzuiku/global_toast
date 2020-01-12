library global_toast;

import 'package:flutter/material.dart';

/// Toast 在第一个page init 之后设定 globalContext
class Toast {
  static BuildContext globalContext;
  static void error(
    String msg, {
    //临时 context
    BuildContext context,
    //显示的时间 单位毫秒
    int showTime = 1600,
    //显示的背景
    Color bgColor = Colors.red,
    //显示的文本颜色
    Color textColor = Colors.white,
    //显示的文字大小
    double textSize = 14.0,
    //显示的位置
    double top = 150,
    double topRate = 0,
    //文字水平方向的内边距
    double pdHorizontal = 20.0,
    //文字垂直方向的内边距
    double pdVertical = 10.0,
    double elevation = 5.0,
    int fadeInTime = 300,
    int fadeOutTime = 100,
  }) {
    Toast.info(
      msg,
      context: context,
      showTime: showTime,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      top: top,
      topRate: topRate,
      pdHorizontal: pdHorizontal,
      pdVertical: pdVertical,
      elevation: elevation,
    );
  }

  static void success(
    String msg, {
    //临时 context
    BuildContext context,
    //显示的时间 单位毫秒
    int showTime = 1600,
    //显示的背景
    Color bgColor = Colors.greenAccent,
    //显示的文本颜色
    Color textColor = Colors.white,
    //显示的文字大小
    double textSize = 14.0,
    //显示的位置
    double top = 150,
    double topRate = 0,
    //文字水平方向的内边距
    double pdHorizontal = 20.0,
    //文字垂直方向的内边距
    double pdVertical = 10.0,
    double elevation = 5.0,
    int fadeInTime = 300,
    int fadeOutTime = 100,
  }) {
    Toast.info(
      msg,
      context: context,
      showTime: showTime,
      bgColor: bgColor,
      textColor: textColor,
      textSize: textSize,
      top: top,
      topRate: topRate,
      pdHorizontal: pdHorizontal,
      pdVertical: pdVertical,
      elevation: elevation,
    );
  }

  static void info(
    String msg, {
    //临时 context
    BuildContext context,
    //显示的时间 单位毫秒
    int showTime = 1600,
    //显示的背景
    Color bgColor = Colors.black87,
    //显示的文本颜色
    Color textColor = Colors.white,
    //显示的文字大小
    double textSize = 14.0,
    //显示的位置
    double top = 150,
    double topRate = 0,
    //文字水平方向的内边距
    double pdHorizontal = 20.0,
    //文字垂直方向的内边距
    double pdVertical = 10.0,
    // 投影
    double elevation = 5.0,
    int fadeInTime = 300,
    int fadeOutTime = 100,
  }) async {
    if (msg == null) {
      return;
    }
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context ?? Toast.globalContext);
    bool showing = true;
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        //top值，可以改变这个值来改变toast在屏幕中的位置
        top: buildToastPosition(context, top, topRate),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: AnimatedOpacity(
              opacity: showing ? 1.0 : 0.0, //目标透明度
              duration: showing ? Duration(milliseconds: fadeInTime) : Duration(milliseconds: fadeOutTime),
              child: Center(
                child: Card(
                  color: bgColor,
                  elevation: elevation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: pdHorizontal, vertical: pdVertical),
                    child: Text(
                      msg,
                      style: TextStyle(
                        fontSize: textSize,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    //插入到整个布局的最上层
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: showTime));

    //2秒后消失
    showing = false;
    overlayEntry.markNeedsBuild();
    await Future.delayed(Duration(milliseconds: fadeOutTime));
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

// 设置toast位置
  static buildToastPosition(context, top, topRate) {
    return top + MediaQuery.of(context).size.height * topRate;
  }
}
