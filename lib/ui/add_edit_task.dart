import 'package:flutter/material.dart';
import 'package:flutter_tasks/bloc/tasks_bloc.dart';
import 'package:flutter_tasks/database/database.dart';
import 'package:flutter_tasks/generated/r.dart';
import 'package:flutter_tasks/ui/qr_scanner.dart';
import 'package:flutter_tasks/ui/tasks_list/tasks_screen.dart';
import 'package:flutter_tasks/utils/color.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:provider/provider.dart';

import 'choose_day.dart';
import 'common/common_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskEntry _task;

  AddTaskScreen.add() : _task = null;

  AddTaskScreen.edit(this._task);

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  String _name;
  String _description;
  String _day;
  String _qrCode;

  @override
  void initState() {
    super.initState();
    var task = widget._task;
    if (task != null) {
      _name = task.name;
      _description = task.description;
      _day = task.day;
      _qrCode = task.qrCode;
    }
  }

  Future _addTask() async {
    await Provider.of<TasksBloc>(context, listen: false)
        .createEntry(_name, _description, _day, _qrCode);
    push(context, TasksScreen());
  }

  Future _editTask() async {
    await Provider.of<TasksBloc>(context, listen: false)
        .updateEntry(widget._task.copyWith(
      name: _name,
      description: _description,
      day: _day,
      qrCode: _qrCode,
    ));
    push(context, TasksScreen());
  }

  bool get _valid =>
      _name?.isNotEmpty == true &&
      _description?.isNotEmpty == true &&
      _qrCode?.isNotEmpty == true &&
      _day?.isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(21, 35, 0, 10),
                  child: Text(
                    'Task Name',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                CommonTextField(
                  initialValue: _name,
                  hint: 'Example : Take the medicine',
                  onChanged: (val) => setState(() => _name = val),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(21, 35, 0, 10),
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                CommonTextField(
                  initialValue: _description,
                  hint:
                      "I should eat before medicine, and don't have to wait after eating.",
                  maxLines: 5,
                  onChanged: (val) => setState(() => _description = val),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(21, 35, 0, 0),
                  child: Text(
                    'Task Day',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(21, 17, 21, 21),
                  child: InkWell(
                    onTap: () async {
                      _day = await ChooseDayScreen.pickDay(context);
                      setState(() {});
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: getFillColor(Theme.of(context)),
                      ),
                      child: Center(
                        child: Text(
                          _day ?? 'Tab to choose a day',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _qrCode = await QrScannerScreen.scanQrCode(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(21),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task Code',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 13),
                              _qrCode?.isNotEmpty == true
                                  ? Text(
                                      _qrCode,
                                      style: TextStyle(fontSize: 14),
                                    )
                                  : Text(
                                      'Tab to scan the QR code',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Theme.of(context)
                                            .textTheme
                                            .title
                                            .color
                                            .withOpacity(.8),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Image.asset(R.icScanning),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget._task == null
              ? InkWell(
                  onTap: _valid ? _addTask : null,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Add the task',
                          style: TextStyle(
                            fontSize: 23,
                            color: _valid
                                ? null
                                : Theme.of(context)
                                    .textTheme
                                    .title
                                    .color
                                    .withOpacity(.25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: _valid
                                ? null
                                : Theme.of(context)
                                    .textTheme
                                    .title
                                    .color
                                    .withOpacity(.25),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: _valid ? _editTask : null,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 23,
                            color: _valid
                                ? null
                                : Theme.of(context)
                                    .textTheme
                                    .title
                                    .color
                                    .withOpacity(.25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.save,
                            color: _valid
                                ? null
                                : Theme.of(context)
                                    .textTheme
                                    .title
                                    .color
                                    .withOpacity(.25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
