/// value : "1"
/// label : "23"

class Sehat {
  String value;
  String label;

  static Sehat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Sehat sehatBean = Sehat();
    sehatBean.value = map['value'];
    sehatBean.label = map['label'];
    return sehatBean;
  }

  Map toJson() => {
        "value": value,
        "label": label,
      };
}
