Map<String, dynamic> encodeMap(Map<String, dynamic> map) {
  map.forEach((key, value) {
    if (value is DateTime) {
      map[key] = value.toString();
    }
  });
  return map;
}
