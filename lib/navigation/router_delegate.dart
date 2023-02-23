import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/blocs/cache/event.dart';
import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/navigation/app_state.dart';
import 'package:honestorage/pages/storage.dart';
import 'package:honestorage/pages/splash.dart';
import 'package:honestorage/pages/initial.dart';
import 'package:honestorage/pages/unknown.dart';
import 'package:honestorage/repositories/backup.dart';

class HonestRouterDelegate extends RouterDelegate<HoneState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<HoneState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  HoneState currentState = HoneState.initial();

  HonestRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<Page<dynamic>> buildPage(BuildContext context, CacheState state) {
    List<Page<dynamic>> pages = [];
    if (state.loading) {
      pages.add(const MaterialPage(key: SplashPage.value, child: SplashPage()));
      // Will emit next state automatically
    } else if (state.cacheString != null) {
      context.read<CacheBloc>().add(CacheDecrypted(json.decode(state.cacheString!)));
      // TODO: cache decryption page
      // context.read<BackupBloc>().add(BackupDecrypted(storage)); // To decrypt storage
      // context.read<BackupBloc>().add(BackupSet(null)); // To remove cache
    } else if (state.cacheStorage == null) {
      pages.add(const MaterialPage(key: InitialPage.value, child: InitialPage()));
      // context.read<BackupBloc>().add(BackupDecrypted(storage)); // To create new storage
      // context.read<BackupBloc>().add(BackupSet(backup)); // To locad from backend
    } else {
      pages.add(const MaterialPage(key: StoragePage.value, child: StoragePage()));
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
      currentState = HoneState.storage();
    } else if (currentState.rout == Rout.STORAGE) {
      currentState = HoneState.initial();
    } else {
      currentState = HoneState.unknown();
    }
    notifyListeners();
    return true;
  }

  Navigator _createNavigator(BuildContext context, CacheState state) {
    return Navigator(
      key: navigatorKey,
      //transitionDelegate: AnimationTransitionDelegate(),
      pages: buildPage(context, state),
      onPopPage: popPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state.cacheStorage == null) return _createNavigator(context, state);
        return BlocProvider<StorageBloc>(
          create: (ctx) => StorageBloc(ctx.read<BackupRepository>(), state.cacheStorage!),
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
