import 'package:flutter/material.dart';

import 'package:honestorage/navigation/app_state.dart';

class HonestRouteInformationParser extends RouteInformationParser<HoneState> {
  @override
  Future<HoneState> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "/");
    // Handle '/'
    if (Rout.INITIAL.prefixes.any((e) => uri.toString().startsWith(e))) return HoneState.initial();

    // Handle '/dataset'
    if (Rout.DATASET.prefixes.any((e) => uri.toString().startsWith(e))) return HoneState.dataset();

    // Handle '/view'
    if (Rout.VIEW_RECORD.prefixes.any((e) => uri.toString().startsWith(e))) {
      if (uri.pathSegments.isEmpty) return HoneState.unknown();
      var id = int.tryParse(uri.pathSegments[1]);
      return id == null ? HoneState.unknown() : HoneState.recordView(id);
    }

    // Handle '/add' and '/edit/:id'
    if (Rout.EDIT_RECORD.prefixes.any((e) => uri.toString().startsWith(e))) {
      var id = int.tryParse(uri.pathSegments.isEmpty ? "null" : uri.pathSegments[1]);
      return HoneState.recordEdit(id);
    }

    // Handle unknown routes
    return HoneState.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(HoneState configuration) {
    if (configuration.rout == Rout.DATASET) {
      return RouteInformation(location: HoneState.dataset().uri.path);
    } else if (configuration.rout == Rout.VIEW_RECORD) {
      return RouteInformation(location: HoneState.recordView(configuration.id).uri.path);
    } else if (configuration.rout == Rout.EDIT_RECORD) {
      return RouteInformation(location: HoneState.recordEdit(configuration.id).uri.path);
    } else if (configuration.rout == Rout.UNKNOWN) {
      return RouteInformation(location: HoneState.unknown().uri.path);
    } else {
      return const RouteInformation(location: null);
    }
  }
}
