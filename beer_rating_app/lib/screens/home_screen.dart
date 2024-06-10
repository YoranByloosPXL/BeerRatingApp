import 'package:beer_rating_app/shared/menu_bottom.dart';
import 'package:flutter/material.dart';
import '../data/beer.dart';
import '../data/http_helper.dart';
import 'beer_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Beer> beers = [];
  bool isLoading = true;
  final HttpHelper httpHelper = HttpHelper();
  final TextEditingController searchController = TextEditingController();
  List<bool> isSelected = [true, false];
  Beer? selectedBeer;

  @override
  void initState() {
    super.initState();
    fetchBeers();
  }

  void fetchBeers() async {
    setState(() {
      isLoading = true;
    });

    List<Beer> result;
    if (isSelected[0]) {
      result = await httpHelper.getAles();
    } else {
      result = await httpHelper.getStouts();
    }

    setState(() {
      beers = result;
      isLoading = false;
    });
  }

  void searchBeers(String query) async {
    setState(() {
      isLoading = true;
    });

    List<Beer> result;
    if (isSelected[0]) {
      result = await httpHelper.getAles();
    } else {
      result = await httpHelper.getStouts();
    }

    result = result
        .where((beer) => beer.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      beers = result;
      isLoading = false;
    });
  }

  void onBeerSelected(Beer beer) {
    setState(() {
      selectedBeer = beer;
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
                'Beers',
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
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text(
                          'Ales',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text(
                          'Stouts',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                        fetchBeers();
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
                      hintText: 'Search for beers',
                      hintStyle: TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          searchBeers(searchController.text);
                        },
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemCount: beers.length,
                            itemBuilder: (context, index) {
                              final beer = beers[index];
                              return ListTile(
                                title: Text(beer.name,
                                    style: TextStyle(color: Colors.white)),
                                subtitle: Text(
                                    'Rating: ${beer.rating.toStringAsFixed(2)} (${beer.reviews} reviews)',
                                    style: TextStyle(color: Colors.white70)),
                                onTap: () {
                                  if (!isLandscape) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BeerDetailScreen(beer: beer),
                                      ),
                                    );
                                  } else {
                                    onBeerSelected(beer);
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
              child: selectedBeer == null
                  ? Center(
                      child: Text(
                        'Select a beer to see details',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : BeerDetailScreen(beer: selectedBeer!),
            ),
        ],
      ),
    );
  }
}
