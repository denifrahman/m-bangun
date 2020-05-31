/// value : "1"
/// label : "23"

class PDP {
  String value;
  String label;

  static PDP fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PDP PDPBean = PDP();
    PDPBean.value = map['value'];
    PDPBean.label = map['label'];
    return PDPBean;
  }

  Map toJson() => {
        "value": value,
        "label": label,
      };
}
