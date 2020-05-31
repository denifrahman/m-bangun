/// value : "1"
/// label : "23"

class Positif {
  String value;
  String label;

  static Positif fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Positif PositifBean = Positif();
    PositifBean.value = map['value'];
    PositifBean.label = map['label'];
    return PositifBean;
  }

  Map toJson() => {
        "value": value,
        "label": label,
      };
}
