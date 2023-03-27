class BackendStatus {
  final DateTime updated;
  final String lastCache;
  final bool syncAvailable, syncEnabled;

  BackendStatus(this.updated, this.lastCache, this.syncAvailable, this.syncEnabled);
}
