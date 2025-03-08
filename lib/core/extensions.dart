class DynamicExtra{
  static bool nullOrEmpty(dynamic d)=>d == null || (d as String) == '';
  static int length(dynamic d) {
    String? s = d;
    if(s == null || s == ''){
      return 0;
    }
    return s.length;
  }
}
extension StringExtensions on String {
  String reversed() {
    return split('').reversed.join();
  }
  String sprintf(List<String> list) {
    var r = this;
    list.forEach((s)=>r = r.replaceFirst('%s', s));
    return r;
  }
  bool nullOrEmpty() =>this == '';
}
extension StringsExtensions on String? {
  bool nullOrEmpty()=>this == null || this == '';
}