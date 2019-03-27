import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:love_stars/common/dao/StarDao.dart';
import 'package:love_stars/common/model/StarModel.dart';
import 'package:love_stars/common/style/AppStyle.dart';
import 'package:love_stars/event/Events.dart';
import 'package:love_stars/routers/application.dart';
import 'package:love_stars/utils/TimeUtil.dart';

class CreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CreateState();
  }
}

class CreateState extends State<CreatePage>
    with SingleTickerProviderStateMixin {
  TextField textField;
  String currentText;

  String todoTime = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("创建"),
          actions: <Widget>[
            new FlatButton(
                onPressed: _submit,
                child: new Text(
                  "完成",
                  style: new TextStyle(color: Colors.white),
                ))
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: new Padding(
            padding: EdgeInsets.all(20),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: textField = new TextField(
                    maxLines: 100,
                    autofocus: true,
                    decoration: new InputDecoration.collapsed(
                      hintText: "请输入",
                    ),
                    onChanged: _onChange,
                  ),
                  flex: 1,
                ),
                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      _renderItem(
                          Icons.timer, "todo time", todoTime, _showTodoPick)
                    ],
                  ),
                  flex: 1,
                )
              ],
            )));
  }

  void _done(String text) {
    StarDao.insertStar(StarModel(
        text,
        DateTime.now().millisecondsSinceEpoch,
        null,
        todoTime == ""
            ? null
            : DateTime.parse(todoTime).millisecondsSinceEpoch));
    Application.eventBus.fire(RefreshTodoListEvent());
  }

  void _submit() {
    _done(currentText);
  }

  void _onChange(String value) {
    currentText = value;
  }

  _renderItem(
      IconData leftIcon, String title, String value, VoidCallback onPressed) {
    return new RawMaterialButton(
      onPressed: onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(15.0),
      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
      child: new Row(
        children: <Widget>[
          new Icon(leftIcon),
          new Container(
            width: 10.0,
          ),
          new Text(title, style: Constant.normalSubText),
          new Container(
            width: 10.0,
          ),
          new Expanded(child: new Text(value, style: Constant.normalText)),
          new Container(
            width: 10.0,
          ),
          new Icon(Icons.keyboard_arrow_right, size: 20.0),
        ],
      ),
    );
  }

  _showTodoPick() async {
    var picker = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    setState(() {
      todoTime = TimeUtil.format(picker);
    });
  }
}
