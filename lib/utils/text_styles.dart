import 'package:flutter/material.dart';
import 'package:oldbike/utils/colors.dart';

// NOTE: kts = Constant Text Style

// Main Text Styles
// === === === === ===
const TextStyle ktsNormalLargeLabel = TextStyle(
  fontSize: 32.0,
);

const TextStyle ktsMainTitle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const TextStyle ktsHeading = TextStyle(
  fontSize: 34.0,
  fontWeight: FontWeight.w900,
);

const TextStyle ktsAttentionLabel = TextStyle(
  color: kcAccent,
);

const TextStyle ktsSmallLabelWithSpacing = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 12.0,
  letterSpacing: 3.0,
);

// Card Text Styles
// === === === === ===
const TextStyle ktsCardTitle = TextStyle(
  fontSize: 34.0,
  fontWeight: FontWeight.w900,
  color: kcWhite200,
);

const TextStyle ktsCardDate = TextStyle(
  fontSize: 15.0,
  color: kcWhite400,
);

const TextStyle ktsCardStats = TextStyle(
  color: kcWhite100,
);

const TextStyle ktsCardAction = TextStyle(
  color: kcAccentT4,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w500,
);

// Profile Summary Text Styles
// === === === === ===
const TextStyle ktsProfileTitle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w800,
);

const TextStyle ktsProfileSubtitle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  height: 6.5,
);

const TextStyle ktsProfileTiny = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w300,
  height: 1.6,
  color: kcWhite300,
);
