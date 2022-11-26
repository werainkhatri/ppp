extension TryGet<T> on List<T> {
  T? tryGet(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }
}
