class Survey {
  final String title;
  final String url;
  final DateTime date;
  late Object dictdata;

  Survey({
    required this.title,
    required this.url,
    required this.date
  }) {
    dictdata = {"title": title, "url": url, "date": date};
  }

}
