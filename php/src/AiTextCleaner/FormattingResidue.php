<?php

declare(strict_types=1);

namespace AiTextCleaner;

final class FormattingResidue
{
    private function __construct() {}

    public static function clean(string $text): string
    {
        $text = preg_replace('/<\s*(address|article|blockquote|br|div|li|p|pre|section)\b[^>]*>/i', "\n", $text) ?? $text;
        $text = preg_replace('/<\s*\/(address|article|blockquote|br|div|li|p|pre|section)\s*>/i', "\n", $text) ?? $text;
        $text = strip_tags($text);
        $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
        $text = strtr($text, ['“' => '"', '”' => '"', '‘' => "'", '’' => "'", '–' => '-', '—' => '-', '…' => '...']);
        $text = preg_replace('/[ \t]+\n/u', "\n", $text) ?? $text;
        $text = preg_replace('/\n{3,}/u', "\n\n", $text) ?? $text;
        return trim($text);
    }
}
