extension StringExtensions on String {
  String reversed() {
    return split('').reversed.join();
  }
  String sprintf(List<String> list) {
    var r = this;
    list.forEach((s)=>r = r.replaceFirst('%s', s));
    return r;
  }
}