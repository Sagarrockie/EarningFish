import 'package:flutter/material.dart';

import 'lead_screen/view/lead_screen/lead_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Dm-Sans',
    ),
    home: const LeadScreen(),
  ));
}
