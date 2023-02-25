part of 'delegate.dart';

extension Section on HonestRouterDelegate {
  // TODO: refactor backButton -> Widget
  // TODO: generalize build functions

  void showRecordViewEditDialog(BuildContext context, int index, Record record) => showGeneralDialog(
        context: context,
        pageBuilder: (ctx, animation, secondaryAnimation) => InterfaceWidget(
          record: record,
          index: index,
          switchBackButton: false,
          actions: (setState, viewPage, editPage) => [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: setState.call,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<StorageBloc>().add(RecordRemoved(index));
                Navigator.pop(context);
              },
            ),
          ],
          switchActions: (setState, viewPage, editPage) => [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: setState.call,
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: setState.call,
            ),
          ],
        ),
      );

  void showRecordAddDialog(BuildContext context, int index, Record record) => showGeneralDialog(
        context: context,
        pageBuilder: (ctx, animation, secondaryAnimation) => InterfaceWidget(
          record: record,
          index: index,
          view: false,
          name: 'Add new record',
          actions: (setState, viewPage, editPage) => [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: setState.call,
            ),
          ],
          switchActions: (setState, viewPage, editPage) => [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: setState.call,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<StorageBloc>().add(RecordRemoved(index));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}
