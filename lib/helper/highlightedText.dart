import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final String searchQuery;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxlines;
  HighlightedText(
      {required this.text,
      required this.searchQuery,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.maxlines = null});

  @override
  Widget build(BuildContext context) {
    // Case-insensitive search
    final RegExp regex = RegExp('($searchQuery)', caseSensitive: false);
    final Iterable<Match> matches = regex.allMatches(text);

    // If there are no matches, return the original text
    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: GoogleFonts.urbanist().fontFamily,
        ),
        maxLines: maxlines,
      );
    }

    // Create a list of TextSpan widgets with highlighted matches
    List<Widget> children = [];
    int lastMatchEnd = 0;

    for (Match match in matches) {
      // Add the text before the match
      if (match.start > lastMatchEnd) {
        children.add(
          Text(
            text.substring(lastMatchEnd, match.start),
            maxLines: maxlines,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              fontFamily: GoogleFonts.urbanist().fontFamily,
            ),
          ),
        );
      }

      // Add the highlighted match
      children.add(
        Container(
          color: Colors.yellow, // Highlight color
          child: Text(
            match.group(0)!,
            maxLines: maxlines,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: Colors.black, // Text color on highlight
              fontFamily: GoogleFonts.urbanist().fontFamily,
            ),
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    // Add the remaining text after the last match
    if (lastMatchEnd < text.length) {
      children.add(
        Text(
          text.substring(lastMatchEnd),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontFamily: GoogleFonts.urbanist().fontFamily,
          ),
        ),
      );
    }

    return RichText(
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          children: children.map((widget) {
            return WidgetSpan(child: widget);
          }).toList(),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontFamily: GoogleFonts.urbanist().fontFamily,
          )),
    );
  }
}
