import 'package:flutter/material.dart';
import 'package:muq_snackbar/base/muq_snackbar_base.dart';

/// The gap between stack of cards
int gapBetweenCard = 15;

/// calculate position of old cards based on current position
double calculatePosition(
    List<MuqSnackbar> toastBars, MuqSnackbar self) {
  if (toastBars.isNotEmpty && self != toastBars.last) {
    final box = self.info.key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      return gapBetweenCard * (toastBars.length - toastBars.indexOf(self) - 1);
    }
  }
  return 0;
}

/// rescale the old cards based on its position
double calculateScaleFactor(
    List<MuqSnackbar> toastBars, MuqSnackbar current) {
  int index = toastBars.indexOf(current);
  int indexValFromLast = toastBars.length - 1 - index;
  double factor = indexValFromLast / 25;
  double res = 0.97 - factor;
  return res < 0 ? 0 : res;
}