part of 'delegate.dart';

extension PageOrDialogSupports on HonestRouterDelegate {
  void showRecordViewEditDialog(BuildContext context, int index) {
    final storageBloc = context.read<StorageBloc>();
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return BlocProvider(
          create: (_) => RecordBloc.copy(index, storageBloc),
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

  void showRecordAddDialog(BuildContext context) {
    final storageBloc = context.read<StorageBloc>();
    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return BlocProvider(
          create: (_) => RecordBloc.create(storageBloc),
          child: InterfaceWidget(
            view: false,
            getSwitchName: (_) => 'Add new record',
            switchActions: (context, setState) {
              return [
                BlocBuilder<RecordBloc, RecordState>(
                  buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == FormzStatus.submissionSuccess) Navigator.pop(context);
                    return IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: state.status.isValid ? () => context.read<RecordBloc>().add(const RecordSubmitted()) : null,
                    );
                  },
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
