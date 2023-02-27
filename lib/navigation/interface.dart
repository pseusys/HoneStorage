import 'package:flutter/material.dart';
import 'package:honestorage/models/record.dart';
import 'package:honestorage/pages/edit.dart';
import 'package:honestorage/pages/view.dart';

typedef InterfaceReturnFunction<T extends Object> = T Function(BuildContext context, void Function() switchState);

class InterfaceWidget extends StatefulWidget {
  // TODO: replace name with name getter function.

  final int index;
  final Record record;
  final String name;
  final String switchName;
  final bool view;
  final bool implyBackButton;
  final bool implySwitchBackButton;
  final InterfaceReturnFunction<IconButton>? backButton;
  final InterfaceReturnFunction<IconButton>? switchBackButton;
  final InterfaceReturnFunction<List<IconButton>>? actions;
  final InterfaceReturnFunction<List<IconButton>>? switchActions;

  InterfaceWidget({
    Key? key,
    required this.index,
    required this.record,
    this.view = true,
    String? name,
    String? switchName,
    this.implyBackButton = true,
    this.implySwitchBackButton = true,
    this.backButton,
    this.switchBackButton,
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
  late bool _implyBackButton;
  late Widget? _backButton;
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
    InterfaceReturnFunction<IconButton>? backButton;
    InterfaceReturnFunction<List<IconButton>>? actions;
    if (_view) {
      _name = widget.name;
      _payload = RecordViewPage(widget.index, widget.record);
      _implyBackButton = widget.implyBackButton;
      backButton = widget.backButton;
      actions = widget.actions;
    } else {
      _name = widget.switchName;
      _payload = RecordEditPage(widget.index, widget.record);
      _implyBackButton = widget.implySwitchBackButton;
      backButton = widget.switchBackButton;
      actions = widget.switchActions;
    }
    _backButton = backButton?.call(context, () => setState(() => _view = !_view));
    _actions = actions?.call(context, () => setState(() => _view = !_view));
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
                  leading: _backButton,
                  automaticallyImplyLeading: _implyBackButton,
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
        leading: _backButton,
        automaticallyImplyLeading: _implyBackButton,
        actions: [if (_actions != null) ..._actions!],
      ),
      body: SingleChildScrollView(
        child: _payload,
      ),
    );
  }
}
