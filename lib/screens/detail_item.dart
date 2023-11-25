import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventor/widgets/generic_button.dart';

import '../models/item.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({super.key, required this.data});

  final Fields data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Detail Item", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: ${data.name}"),
            Text("Rarity: ${data.rarity}"),
            Text("Amount: ${data.amount}x"),
            Text("Deskripsi: ${data.description}"),
            Center(child: GenericButton(text: 'Kembali', onPressed: () => Navigator.pop(context))),
          ],
        ),
      ),
    );
  }
}
