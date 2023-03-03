// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:honestorage/blocs/cache/bloc.dart';
import 'package:honestorage/blocs/cache/event.dart';
import 'package:honestorage/blocs/cache/state.dart';
import 'package:honestorage/blocs/record/bloc.dart';
import 'package:honestorage/blocs/record/event.dart';
import 'package:honestorage/blocs/record/state.dart';
import 'package:honestorage/blocs/storage/bloc.dart';
import 'package:honestorage/blocs/storage/event.dart';
import 'package:honestorage/navigation/interface.dart';
import 'package:honestorage/pages/storage.dart';
import 'package:honestorage/pages/splash.dart';
import 'package:honestorage/pages/initial.dart';
import 'package:honestorage/pages/unknown.dart';

part 'paging.dart';

enum HonestRoute {
  INITIAL,
  STORAGE,
  VIEW_RECORD,
  EDIT_RECORD,
  UNKNOWN;
}

class HonestRouterDelegate extends RouterDelegate<HonestRoute> with ChangeNotifier, PopNavigatorRouterDelegateMixin<HonestRoute> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  HonestRoute currentState = HonestRoute.INITIAL;

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
      pages.add(MaterialPage(key: StoragePage.value, child: StoragePage(currentState, state)));
    }
    if (currentState == HonestRoute.UNKNOWN) pages.add(const MaterialPage(key: UnknownPage.value, child: UnknownPage()));
    return pages;
  }

  bool popPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    } else if (currentState == HonestRoute.EDIT_RECORD || currentState == HonestRoute.VIEW_RECORD) {
      currentState = HonestRoute.STORAGE;
    } else if (currentState == HonestRoute.STORAGE) {
      currentState = HonestRoute.INITIAL;
    } else {
      currentState = HonestRoute.UNKNOWN;
    }
    notifyListeners();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) => Navigator(
        key: navigatorKey,
        //transitionDelegate: AnimationTransitionDelegate(),
        pages: buildPage(context, state),
        onPopPage: popPage,
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(HonestRoute configuration) async => currentState = configuration;
}
