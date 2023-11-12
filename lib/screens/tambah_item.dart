import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventor/widgets/generic_button.dart';

class TambahItem extends StatefulWidget {
  const TambahItem({super.key});

  @override
  State<TambahItem> createState() => _TambahItemState();
}

class _TambahItemState extends State<TambahItem> {
  final _formKey = GlobalKey<FormState>();
  final _rarityList = ['Common', 'Uncommon', 'Rare', 'Very rare', 'Epic', 'Legendary'];
  final _namaController = TextEditingController();
  final _amountController = TextEditingController();
  final _rarityController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tambah Item", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
      ),
      body: GestureDetector(
        // Gesture detector to unfocus TextFormField when tapped outside
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          // Set a uniform padding for all descendant widgets
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Form(
            //     Form with key attribute for validation purposes
            key: _formKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          label: Text("Nama"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        })),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final number = int.tryParse(value!);
                          if (value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          if (number == null) {
                            return 'Hanya boleh bilangan bulat';
                          }
                          return null;
                        })),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _deskripsiController,
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                          label: Text("Deskripsi"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        })),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu(
                      controller: _rarityController,
                      initialSelection: "Common",
                      label: const Text("Rarity"),
                      dropdownMenuEntries: _rarityList.map((val) {
                        return DropdownMenuEntry(value: val, label: val);
                      }).toList()),
                ),
                GenericButton(
                    text: "Save",
                    padding: 15,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // If the form is valid, display a popup dialog.
                        _showFormDataDialog(context, _namaController.text, _amountController.text,
                            _deskripsiController.text, _rarityController.value.text);
                      }
                    })
              ],
            ),
          )),
        ),
      ),
    );
  }
}

Future<void> _showFormDataDialog(
    BuildContext context, String nama, String amount, String deskripsi, String rarity) {
  // Builder function to show a popup dialog.
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Data Form"),
          actions: [
            Center(
                child: GenericButton(
                    text: "OK", height: 40, width: 100, onPressed: () => Navigator.pop(context))),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: $nama"),
                Text("Amount: $amount"),
                Text("Rarity: $rarity"),
                Text("Deskrpisi: $deskripsi")
              ],
            ),
          ),
        );
      });
}
