/// value : "6"
/// date : "2020-03-31"
/// status_kesehatan : "SEHAT"

class DataChart {
  String value;
  String date;
  String statusKesehatan;

  static DataChart fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataChart dataChartBean = DataChart();
    dataChartBean.value = map['value'];
    dataChartBean.date = map['date'];
    dataChartBean.statusKesehatan = map['status_kesehatan'];
    return dataChartBean;
  }

  Map toJson() => {
        "value": value,
        "date": date,
        "status_kesehatan": statusKesehatan,
      };
}
