import 'package:aitextcleaner_formatting_residue/aitextcleaner_formatting_residue.dart';
void main() {
  final actual = cleanFormattingResidue(
    '<p>Hello <span>world</span>…</p><div>Next line</div>',
  );
  assert(actual == 'Hello world...\n\nNext line');
}
