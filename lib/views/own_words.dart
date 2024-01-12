import 'package:cumb/constants/texts/constant_texts.dart';
import 'package:cumb/model/items_model.dart';
import 'package:cumb/views/own_details.dart';
import 'package:cumb/widgets/dialog/own_words_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

//! Aynı isimde grup oluşturmaması gerekiyor. Oluşturulduğunda mantıksal hata ortaya çıkıyor.

class OwnWords extends StatefulWidget {
  const OwnWords({Key? key}) : super(key: key);

  @override
  State<OwnWords> createState() => _OwnWordsState();
}

class _OwnWordsState extends State<OwnWords> {
  late Box<ItemModel> itemBox;

  @override
  void initState() {
    super.initState();
    openItemBox();
  }

  void openItemBox() async {
    if (!Hive.isBoxOpen("itemBox")) {
      await Hive.openBox<ItemModel>("itemBox");
    }

    itemBox = Hive.box<ItemModel>("itemBox");
  }

  void deleteItem(int index) async {
    if (index >= 0 && index < itemBox.length) {
      itemBox.deleteAt(itemBox.length - index - 1);
      setState(() {});
    }
  }

  List<ItemModel?> createReversedItemList(Box<ItemModel> itemBox) {
    return List.generate(
        itemBox.length, (index) => itemBox.getAt(itemBox.length - index - 1));
  }

  Widget buildListView(List<ItemModel?> reversedItems) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: reversedItems.length,
      itemBuilder: (context, index) {
        var title = reversedItems[index]?.title ?? "";
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OwnDetails(title: title),
              ),
            );
          },
          title: Text(title),
          subtitle: const Text("0"),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              deleteItem(index);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<ItemModel?> reversedItems = createReversedItemList(itemBox);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: screenHeight * 0.15,
        title: const Text(OwnWord.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: itemBox.listenable(),
        builder: (BuildContext context, Box<ItemModel> itemBox, Widget? child) {
          if (itemBox.length > 0) {
            return buildListView(reversedItems);
          } else {
            return const SizedBox(
              child: Center(
                child: Text("Boş"),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              double screenHeight = MediaQuery.of(context).size.height;
              double screenWidth = MediaQuery.of(context).size.width;
              return OwnWordsDialog(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
