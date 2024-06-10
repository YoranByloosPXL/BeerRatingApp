import 'package:beer_rating_app/data/wine.dart';
import 'package:beer_rating_app/screens/wine_detail_screen.dart';
import 'package:beer_rating_app/shared/menu_bottom.dart';
import 'package:flutter/material.dart';
import '../data/http_helper.dart';

class WinesScreen extends StatefulWidget {
  const WinesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WinesScreenState createState() => _WinesScreenState();
}

class _WinesScreenState extends State<WinesScreen> {
  List<Wine> wines = [];
  bool isLoading = true;
  final HttpHelper httpHelper = HttpHelper();
  final TextEditingController searchController = TextEditingController();
  List<bool> isSelected = [true, false, false];
  Wine? selectedWine;

  @override
  void initState() {
    super.initState();
    fetchWines();
  }

  void fetchWines() async {
    setState(() {
      isLoading = true;
    });

    List<Wine> result;
    if (isSelected[0]) {
      result = await httpHelper.getReds();
    } else if (isSelected[1]) {
      result = await httpHelper.getWhites();
    } else {
      result = await httpHelper.getRose();
    }

    setState(() {
      wines = result;
      isLoading = false;
    });
  }

  void searchWines(String query) async {
    setState(() {
      isLoading = true;
    });

    List<Wine> result;
    if (isSelected[0]) {
      result = await httpHelper.getReds();
    } else if (isSelected[1]) {
      result = await httpHelper.getWhites();
    } else {
      result = await httpHelper.getRose();
    }


    result = result
        .where((wine) => wine.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      wines = result;
      isLoading = false;
    });
  }

  void onWineSelected(Wine wine) {
    setState(() {
      selectedWine = wine;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: !isLandscape
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Wines',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color(0xFF2d2d2d),
            )
          : null,
      bottomNavigationBar: MenuBottom(),
      backgroundColor: Color(0xFF2d2d2d),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: !isLandscape
                      ? const EdgeInsets.only(top: 10)
                      : const EdgeInsets.only(top: 25),
                  child: ToggleButtons(
                    isSelected: isSelected,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Reds',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Whites',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Rose',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                        fetchWines();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: !isLandscape
                      ? const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20, top: 10)
                      : const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for wines',
                      hintStyle: TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          searchWines(searchController.text);
                        },
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemCount: wines.length,
                            itemBuilder: (context, index) {
                              final wine = wines[index];
                              return ListTile(
                                title: Text(wine.name,
                                    style: TextStyle(color: Colors.white)),
                                subtitle: Text(
                                    'Rating: ${wine.rating} (${wine.reviews})',
                                    style: TextStyle(color: Colors.white70)),
                                onTap: () {
                                  if (!isLandscape) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WineDetailScreen(wine: wine),
                                      ),
                                    );
                                  } else {
                                    onWineSelected(wine);
                                  }
                                },
                              );
                            }),
                      ),
              ],
            ),
          ),
          if (isLandscape)
            Expanded(
              flex: 5,
              child: selectedWine == null
                  ? Center(
                      child: Text(
                        'Select a wine to see details',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : WineDetailScreen(wine: selectedWine!),
            ),
        ],
      ),
    );
  }
}
