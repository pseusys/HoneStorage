import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/backup/bloc.dart';
import 'package:honestorage/blocs/backup/event.dart';
import 'package:honestorage/blocs/backup/state.dart';
import 'package:honestorage/blocs/dataset/bloc.dart';
import 'package:honestorage/navigation/app_state.dart';
import 'package:honestorage/pages/dataset.dart';
import 'package:honestorage/pages/splash.dart';
import 'package:honestorage/pages/initial.dart';
import 'package:honestorage/pages/unknown.dart';
import 'package:honestorage/repositories/remote.dart';

class HonestRouterDelegate extends RouterDelegate<HoneState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<HoneState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  HoneState currentState = HoneState.initial();

  HonestRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<Page<dynamic>> buildPage(BuildContext context, BackupState state) {
    List<Page<dynamic>> pages = [];
    if (state.loading) {
      pages.add(const MaterialPage(key: SplashPage.value, child: SplashPage()));
      // Will emit next state automatically
    } else if (state.datasetCache != null) {
      context.read<BackupBloc>().add(BackupDecrypted(json.decode(state.datasetCache!)));
      // TODO: cache decryption page
      // context.read<BackupBloc>().add(BackupDecrypted(dataset)); // To decrypt dataset
      // context.read<BackupBloc>().add(BackupSet(null)); // To remove cache
    } else if (state.dataset == null) {
      pages.add(const MaterialPage(key: InitialPage.value, child: InitialPage()));
      // context.read<BackupBloc>().add(BackupDecrypted(dataset)); // To create new dataset
      // context.read<BackupBloc>().add(BackupSet(backup)); // To locad from backend
    } else {
      pages.add(const MaterialPage(key: DatasetPage.value, child: DatasetPage()));
      if (currentState.rout == Rout.VIEW_RECORD) {
        if (currentState.id != null) {
          //pages.add(MaterialPage(key: ValueKey('BookListPageId${currentState.id}'), child: BookDetailsScreen(book: books[currentState.id])));
        }
      } else if (currentState.rout == Rout.EDIT_RECORD) {
        if (currentState.id != null) {
          //pages.add(MaterialPage(key: const ValueKey('LoginScreen'), child: UserScreen(refresh: notifyListeners())));
        } else {}
      }
    }
    if (currentState.rout == Rout.UNKNOWN) pages.add(const MaterialPage(key: UnknownPage.value, child: UnknownPage()));
    return pages;
  }

  bool popPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    } else if (currentState.rout == Rout.EDIT_RECORD && currentState.id != null) {
      currentState = HoneState.recordView(currentState.id);
    } else if (currentState.rout == Rout.EDIT_RECORD || currentState.rout == Rout.VIEW_RECORD) {
      currentState = HoneState.dataset();
    } else if (currentState.rout == Rout.DATASET) {
      currentState = HoneState.initial();
    } else {
      currentState = HoneState.unknown();
    }
    notifyListeners();
    return true;
  }

  Navigator _createNavigator(BuildContext context, BackupState state) {
    return Navigator(
      key: navigatorKey,
      //transitionDelegate: AnimationTransitionDelegate(),
      pages: buildPage(context, state),
      onPopPage: popPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackupBloc, BackupState>(
      builder: (context, state) {
        if (state.dataset == null) return _createNavigator(context, state);
        return BlocProvider<DatasetBloc>(
          create: (ctx) => DatasetBloc(ctx.read<RemoteRepository>(), state.dataset!),
          child: _createNavigator(context, state),
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(HoneState configuration) async => currentState = configuration;

  void handleRecordAddition() {
    currentState = HoneState.recordEdit(null);
    notifyListeners();
  }
}
