import 'package:cumb/constants/texts/constant_texts.dart';
import 'package:cumb/model/items_model.dart';
import 'package:cumb/widgets/buttons/button_widget.dart';
import 'package:cumb/widgets/texts/button_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OwnWordsDialog extends StatefulWidget {
  const OwnWordsDialog({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  State<OwnWordsDialog> createState() => _OwnWordsDialogState();
}

class _OwnWordsDialogState extends State<OwnWordsDialog> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    openItemBox();
  }

  void openItemBox() async {
    if (!Hive.isBoxOpen("itemBox")) {
      await Hive.openBox<ItemModel>("itemBox");
    }
  }

  void addItemToBox(
      String title, String desc, List<Map<String, String>> words) {
    final itemBox = Hive.box<ItemModel>("itemBox");
    final newItem = ItemModel(title, desc);

    // itemBox'un içine yeni öğe ekleyin
    itemBox.add(newItem);

    // Eklenen öğeden sonra liste yeniden oluşturulsun
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(OwnWordDialog.createdCard),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: OwnWordDialog.cardName,
              ),
            ),
            ButtonWT(
              onPressed: () {
                addItemToBox(titleController.text, "", []);
                Navigator.pop(context);
              },
              height: widget.screenHeight * 0.08,
              width: widget.screenWidth,
              backgroundColor: Colors.red,
              child: ButtonText(
                text: "Tamamla",
                fontSize: widget.screenWidth * 0.05,
              ),
            )
          ],
        ),
      ),
    );
  }
}
