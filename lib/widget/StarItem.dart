import 'package:flutter/material.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:love_stars/utils/TimeUtil.dart';
import 'package:love_stars/widget/CardItem.dart';

class StarItem extends StatelessWidget {
  final StarModel model;

  final VoidCallback onPressed;

  final VoidCallback onLongPressed;

  final VoidCallback onDonePressed;

  bool isTodo;

  StarItem(this.isTodo, this.model,
      {this.onDonePressed, this.onPressed, this.onLongPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new GestureDetector(
        onLongPress: onLongPressed,
        onTap: onPressed,
        child: new CardItem(
          color: Colors.white,
          child: new Container(
            child: new Padding(
              padding: new EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Text("内容：" + model.content ?? "name"),
                          model.todoTime != null && isTodo
                              ? new Text("todo时间：" +
                                      TimeUtil.formatDate(model.todoTime) ??
                                  "--")
                              : new Container(),
                          model.doneTime != null && !isTodo
                              ? new Text("done时间：" +
                                      TimeUtil.formatTime(model.doneTime) ??
                                  "--")
                              : new Container(),
                        ],
                      ),
                      flex: 1),
                  onDonePressed != null
                      ? new FlatButton(
                          onPressed: onDonePressed,
                          child: new Icon(
                            Icons.done,
                          ),
                        )
                      : new Container(),
                  model.collectTime == null
                      ? new Container()
                      : new Icon(Icons.star),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
