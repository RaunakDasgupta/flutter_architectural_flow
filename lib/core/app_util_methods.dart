String sanitizeJson(String input) {
  // Remove any whitespace first
  String sanitized = input.trim();

  // Add quotes to property names if missing
  sanitized = sanitized.replaceAllMapped(
    RegExp(r'(\{|\,|\n)\s*([a-zA-Z0-9_]+)\s*:'),
        (match) => '${match.group(1)}"${match.group(2)}":',
  );

  // Add quotes to string values if missing
  sanitized = sanitized.replaceAllMapped(
    RegExp(r':\s*([^"{}\[\],\s][^,}\]]*[^"{}\[\],\s])(?=\s*[,}\]]|$)'),
        (match) => ':"${match.group(1)}"',
  );

  return sanitized;
}