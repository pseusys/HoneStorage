import 'package:flutter/material.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/pages/edit.dart';
import 'package:honestorage/pages/view.dart';

class InterfaceWidget extends StatefulWidget {
  final Record record;
  final int index;
  final String name;
  final String switchName;
  final bool view;
  final bool backButton;
  final bool switchBackButton;
  final List<IconButton> Function(void Function() switchState, RecordViewPage? viewPage, RecordEditPage? editPage)? actions;
  final List<IconButton> Function(void Function() switchState, RecordViewPage? viewPage, RecordEditPage? editPage)? switchActions;

  InterfaceWidget({
    Key? key,
    required this.record,
    required this.index,
    this.view = true,
    String? name,
    String? switchName,
    this.backButton = true,
    this.switchBackButton = true,
    this.actions,
    this.switchActions,
  })  : name = name ?? record.title,
        switchName = switchName ?? "Edit ${record.title}",
        super(key: key);

  @override
  State<InterfaceWidget> createState() => _InterfaceWidgetState();
}

class _InterfaceWidgetState extends State<InterfaceWidget> {
  late bool _view;
  late String _name;
  late Widget _payload;
  late bool _backButton;
  late List<Widget>? _actions;

  @override
  void initState() {
    _view = widget.view;
    _setupVariables();
    super.initState();
  }

  @override
  void setState(VoidCallback switchFunction) {
    super.setState(switchFunction);
    _setupVariables();
  }

  void _setupVariables() {
    Widget? viewPage, editPage;
    List<IconButton> Function(void Function(), RecordViewPage?, RecordEditPage?)? actionList;
    if (_view) {
      _name = widget.name;
      _payload = RecordViewPage(widget.index, widget.record);
      _backButton = widget.backButton;
      actionList = widget.actions;
      viewPage = _payload;
      editPage = null;
    } else {
      _name = widget.switchName;
      _payload = RecordEditPage(widget.index, widget.record);
      _backButton = widget.switchBackButton;
      actionList = widget.switchActions;
      viewPage = null;
      editPage = _payload;
    }
    _actions = actionList?.call(() => setState(() => _view = !_view), viewPage as RecordViewPage?, editPage as RecordEditPage?);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return width > height ? _makeDialog(context, width) : _makePage(context);
  }

  Widget _makeDialog(BuildContext context, double width) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width / 2, minWidth: width / 2),
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text(_name),
                  automaticallyImplyLeading: _backButton,
                  actions: [if (_actions != null) ..._actions!],
                ),
                SingleChildScrollView(
                  child: _payload,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _makePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        automaticallyImplyLeading: _backButton,
        actions: [if (_actions != null) ..._actions!],
      ),
      body: SingleChildScrollView(
        child: _payload,
      ),
    );
  }
}
