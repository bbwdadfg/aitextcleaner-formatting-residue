const BLOCK_TAGS: [&str; 9] = [
    "address",
    "article",
    "blockquote",
    "br",
    "div",
    "li",
    "p",
    "pre",
    "section",
];

fn strip_tags(input: &str) -> String {
    let mut output = String::new();
    let mut rest = input;
    while let Some(start) = rest.find('<') {
        output.push_str(&rest[..start]);
        let Some(end_relative) = rest[start..].find('>') else {
            output.push_str(&rest[start..]);
            return output;
        };
        let end = start + end_relative;
        let raw_tag = rest[start + 1..end].trim_start_matches('/').trim_start();
        let name = raw_tag
            .split_whitespace()
            .next()
            .unwrap_or("")
            .to_ascii_lowercase();
        if BLOCK_TAGS.contains(&name.as_str()) {
            output.push('\n');
        }
        rest = &rest[end + 1..];
    }
    output.push_str(rest);
    output
}

fn decode_entities(input: String) -> String {
    input
        .replace("&amp;", "&")
        .replace("&lt;", "<")
        .replace("&gt;", ">")
        .replace("&quot;", "\"")
        .replace("&#39;", "'")
        .replace("&apos;", "'")
        .replace("&nbsp;", " ")
}

pub fn clean_formatting_residue(text: &str) -> String {
    let mut cleaned = decode_entities(strip_tags(text))
        .replace('“', "\"")
        .replace('”', "\"")
        .replace('‘', "'")
        .replace('’', "'")
        .replace('–', "-")
        .replace('—', "-")
        .replace('…', "...");
    cleaned = cleaned
        .lines()
        .map(|line| line.trim_end_matches([' ', '\t']))
        .collect::<Vec<_>>()
        .join("\n");
    while cleaned.contains("\n\n\n") {
        cleaned = cleaned.replace("\n\n\n", "\n\n");
    }
    cleaned.trim().to_string()
}
