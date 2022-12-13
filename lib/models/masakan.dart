class Masakan {
  late final String title;
  late final String thumb;
  late final String key;
  late final String times;
  late final String serving;
  late final String difficulty;

  Masakan(this.title, this.thumb, this.key, this.times, this.serving,
      this.difficulty);

  Masakan.fromJson(Map<String, dynamic> parsedJson) {
    title = parsedJson['title'];
    thumb = parsedJson['thumb'];
    key = parsedJson['key'];
    times = parsedJson['times'];
    serving = parsedJson['serving'];
    difficulty = parsedJson['difficulty'];
  }
}
