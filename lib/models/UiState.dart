class UiState<T> {
  bool isInit = false;
  bool isLoading = false;
  Exception? exception = null;
  T? data = null;

  UiState({this.data});
}
