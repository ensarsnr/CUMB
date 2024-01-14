import 'package:cumb/widgets/buttons/button_widget.dart';
import 'package:flutter/material.dart';

class OwnDetailsDialog extends StatefulWidget {
  const OwnDetailsDialog({super.key});

  @override
  State<OwnDetailsDialog> createState() => _OwnDetailsDialogState();
}

class _OwnDetailsDialogState extends State<OwnDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: const Text("Kelimeleri ekle"),
      content: SingleChildScrollView(
        child: ListBody(children: [
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Kelime",
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Karşılığı",
            ),
          ),
          ButtonWT(
            onPressed: () {},
            height: screenHeight,
            width: screenWidth,
            backgroundColor: Colors.black,
            child: const Text("data"),
          )
        ]),
      ),
    );
  }
}
