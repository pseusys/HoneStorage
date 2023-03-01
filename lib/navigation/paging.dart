part of 'delegate.dart';

extension PageOrDialogSupports on HonestRouterDelegate {
  // TODO: generalize build functions

  void showRecordViewEditDialog(BuildContext context, int index) {
    final storageBloc = context.read<StorageBloc>();
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return BlocProvider(
          create: (_) => RecordBloc(index, storageBloc),
          child: InterfaceWidget(
            index: index,
            getName: (BuildContext context) => context.read<RecordBloc>().state.title.value,
            implySwitchBackButton: false,
            actions: (context, setState) => [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: setState.call,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  storageBloc.add(RecordRemoved(index));
                  Navigator.pop(context);
                },
              ),
            ],
            switchActions: (context, setState) => [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  context.read<RecordBloc>().add(const RecordSubmitted());
                  setState.call();
                },
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: setState.call,
              ),
            ],
          ),
        );
      },
    );
  }

  void showRecordAddDialog(BuildContext context, int index) {
    final storageBloc = context.read<StorageBloc>();
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return BlocProvider(
          create: (_) => RecordBloc(index, storageBloc),
          child: InterfaceWidget(
            index: index,
            view: false,
            getName: (_) => 'Add new record',
            getSwitchName: (BuildContext context) => context.read<RecordBloc>().state.title.value,
            actions: (context, setState) => [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: setState.call,
              ),
            ],
            switchActions: (context, setState) => [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: setState.call,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  storageBloc.add(RecordRemoved(index));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
