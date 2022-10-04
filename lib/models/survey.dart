class Survey {
  final String title;
  final String url;
  final DateTime endDate;
  late Object dictdata;

  Survey({
    required this.title,
    required this.url,
    required this.endDate
  }) {
    dictdata = {"title": title, "url": url, "date": endDate};
  }

}
