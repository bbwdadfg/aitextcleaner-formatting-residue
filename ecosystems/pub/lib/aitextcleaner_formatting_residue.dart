const _blockTag = r'<\/?(?:address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>';
final _blockTagPattern = RegExp(_blockTag, caseSensitive: false);
final _htmlTagPattern = RegExp(r'<[^>]*>');

String _decodeEntities(String value) {
  return value.replaceAllMapped(RegExp(r'&(#x?[0-9a-f]+|amp|apos|gt|lt|nbsp|quot);', caseSensitive: false), (match) {
    final entity = match.group(1)!.toLowerCase();
    if (entity == 'amp') return '&';
    if (entity == 'apos' || entity == '#39' || entity == '#x27') return "'";
    if (entity == 'gt') return '>';
    if (entity == 'lt') return '<';
    if (entity == 'nbsp') return ' ';
    if (entity == 'quot') return '"';
    final radix = entity.startsWith('#x') ? 16 : 10;
    final digits = entity.substring(entity.startsWith('#x') ? 2 : 1);
    return String.fromCharCode(int.parse(digits, radix: radix));
  });
}

String cleanFormattingResidue(String text) {
  var cleaned = text.replaceAll(_blockTagPattern, '\n').replaceAll(_htmlTagPattern, '');
  cleaned = _decodeEntities(cleaned)
      .replaceAll('“', '"')
      .replaceAll('”', '"')
      .replaceAll('‘', "'")
      .replaceAll('’', "'")
      .replaceAll('–', '-')
      .replaceAll('—', '-')
      .replaceAll('…', '...')
      .replaceAll(RegExp(r'[ \t]+\n'), '\n')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n');
  return cleaned.trim();
}
