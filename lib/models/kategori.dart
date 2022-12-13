class Kategori {
  late final String category;
  late final String url;
  late final String key;

  Kategori(this.category, this.url, this.key);

  Kategori.fromJson(Map<String, dynamic> parsedJson) {
    category = parsedJson['category'];
    url = parsedJson['url'];
    key = parsedJson['key'];
  }
}
