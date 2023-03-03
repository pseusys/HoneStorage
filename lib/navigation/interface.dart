import 'package:flutter/material.dart';

import 'package:honestorage/pages/edit.dart';
import 'package:honestorage/pages/view.dart';

typedef InterfaceReturnFunction<T extends Object> = T Function(BuildContext context, void Function() switchState);

class InterfaceWidget extends StatefulWidget {
  // TODO: replace name with name getter function.

  final int? index;
  final String Function(BuildContext context) getName;
  final String Function(BuildContext context) getSwitchName;
  final bool view;
  final bool implyBackButton;
  final bool implySwitchBackButton;
  final InterfaceReturnFunction<IconButton>? backButton;
  final InterfaceReturnFunction<IconButton>? switchBackButton;
  final InterfaceReturnFunction<List<Widget>>? actions;
  final InterfaceReturnFunction<List<Widget>>? switchActions;

  InterfaceWidget({
    Key? key,
    this.index,
    this.view = true,
    String Function(BuildContext context)? getName,
    String Function(BuildContext context)? getSwitchName,
    this.implyBackButton = true,
    this.implySwitchBackButton = true,
    this.backButton,
    this.switchBackButton,
    this.actions,
    this.switchActions,
  })  : getName = getName ?? ((_) => "View record"),
        getSwitchName = getSwitchName ?? ((_) => "Edit record"),
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
    InterfaceReturnFunction<List<Widget>>? actions;
    if (_view) {
      _name = widget.getName(context);
      _payload = RecordViewPage(widget.index!);
      _implyBackButton = widget.implyBackButton;
      backButton = widget.backButton;
      actions = widget.actions;
    } else {
      _name = widget.getSwitchName(context);
      _payload = RecordEditPage(widget.index);
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
    final dialogWidth = width / 3 * 2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: dialogWidth, minWidth: dialogWidth),
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
                Flexible(
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
      body: Flexible(
        child: _payload,
      ),
    );
  }
}
