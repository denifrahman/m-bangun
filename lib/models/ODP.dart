/// value : "1"
/// label : "23"

class ODP {
  String value;
  String label;

  static ODP fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ODP ODPBean = ODP();
    ODPBean.value = map['value'];
    ODPBean.label = map['label'];
    return ODPBean;
  }

  Map toJson() => {
        "value": value,
        "label": label,
      };
}
