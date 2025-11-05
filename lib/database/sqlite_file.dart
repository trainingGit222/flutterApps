class SqliteFile {
  static const String tableName='timeanddate';
  static const String id='id';
  static const String time='time';
  static const String date='date';
  static final String createtable='''
   CREATE TABLE $tableName(
   $id INTEGER PRIMARY KEY AUTOINCREMENT
    NOT NULL,
   $time TEXT,
   $date TEXT
   )
   ''';
}