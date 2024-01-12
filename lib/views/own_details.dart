import 'package:cumb/constants/texts/constant_texts.dart';
import 'package:cumb/model/items_model.dart';
import 'package:cumb/model/words_model.dart';
import 'package:cumb/widgets/buttons/button_widget.dart';
import 'package:cumb/widgets/texts/button_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OwnDetails extends StatefulWidget {
  final String title;

  const OwnDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<OwnDetails> createState() => _OwnDetailsState();
}

class _OwnDetailsState extends State<OwnDetails> {
  late Box<ItemModel> itemBox;
  late Box<WordsModel> wordsBox;

  @override
  void initState() {
    super.initState();
    openItemBox();
    openWordsBox();
  }

  void openItemBox() async {
    // itemBox'u açma işlemi, daha önce açılmadıysa
    if (!Hive.isBoxOpen("itemBox")) {
      await Hive.openBox<ItemModel>("itemBox");
    }
    // itemBox'ı referans al
    itemBox = Hive.box<ItemModel>("itemBox");
  }

  void openWordsBox() async {
    // wordsBox'ı açma işlemi, daha önce açılmadıysa
    if (!Hive.isBoxOpen("wordsBox")) {
      await Hive.openBox<WordsModel>("wordsBox");
    }
    // wordsBox'ı referans al
    wordsBox = Hive.box<WordsModel>("wordsBox");
  }

  List<WordsModel?> getWordsForItem(int itemId) {
    // Seçilen öğe için wordsBox'tan ilgili WordsModel'ları al
    return wordsBox.values
        .where((wordsModel) => wordsModel.itemId == itemId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    ItemModel? selectedItem;
    try {
      // widget.title ile eşleşen ItemModel'ı seç
      selectedItem =
          itemBox.values.firstWhere((item) => item.title == widget.title);
    } catch (e) {
      // Eğer seçilen öğe yoksa selectedItem'yi null olarak ayarla
      selectedItem = null;
    }

    if (selectedItem != null) {
      // Seçilen öğenin ID'si ile ilişkili WordsModel'ları al
      List<WordsModel?> wordsForItem = getWordsForItem(selectedItem.hashCode);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title), // widget.title kullanıldı
        ),
        body: ListView.builder(
          itemCount: wordsForItem.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Word: ${wordsForItem[index]?.words}"),
              subtitle: Text("Meaning: ${wordsForItem[index]?.itemId}"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String firstWord = "";
                String secondWord = "";

                return AlertDialog(
                  title: const Text("Kelime Ekle"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          firstWord = value;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: OwnWordDialog.word,
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          secondWord = value;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: OwnWordDialog.word2,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ButtonWT(
                      onPressed: () {
                        // Eğer hem birinci kelime hem de ikinci kelime doluysa işlemi gerçekleştir
                        if (firstWord.isNotEmpty && secondWord.isNotEmpty) {
                          // Seçilen öğenin ID'sini al
                          int itemId = selectedItem.hashCode;

                          // Yeni WordsModel nesnesi oluştur
                          WordsModel newWordsModel =
                              WordsModel([firstWord, secondWord], itemId);

                          // WordsModel'ı wordsBox'a ekle
                          wordsBox.add(newWordsModel);

                          // Dialog'ı kapat
                          Navigator.pop(context);
                        }
                      },
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      backgroundColor: Colors.red,
                      child: ButtonText(
                        text: "Tamamla",
                        fontSize: screenWidth * 0.05,
                      ),
                    )
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Item not found"),
        ),
      );
    }
  }
}
