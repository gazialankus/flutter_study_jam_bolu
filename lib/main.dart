import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Homee Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WordPair> myWordPairs;
  Set<WordPair> myFavourites;

  @override
  void initState() {
    super.initState();
    var firstPair = WordPair.random();
    var fourthPair = WordPair.random();
    myWordPairs = [
      firstPair,
      WordPair.random(),
      WordPair.random(),
      fourthPair,
      WordPair.random(),
    ];
    myFavourites = {
      firstPair,
      fourthPair
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

//    for(var vp in myWordPairs) {
//      widgetList.add(
//        ListTile(
//          title: Text(vp.asPascalCase)
//        )
//      );
//    }

    for(int i = 0; i < myWordPairs.length; i++) {
      var vp = myWordPairs[i];
      widgetList.add(
        ListTile(
          title: Text(vp.asPascalCase)
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("Favourited items")
                      ),
                      body: Center(
                        child: myFavourites.isEmpty
                          ? Text("Please favourite some items, first.")
                          : ListView(
                          children: myFavourites.map(
                              (pair) => ListTile(
                                title: Text(pair.asPascalCase),
                              )
                          ).toList(),
                        ),
                      )
                    );
                  }
                )
              );
              print("list!");
            },
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (index >= myWordPairs.length) {
              while(index >= myWordPairs.length) {
                print("adding a new element");
                myWordPairs.add(WordPair.random());
              }
            }
            var thePair = myWordPairs[index];
            var isFavourite = myFavourites.contains(thePair);

            return ListTile(
              title: Text(thePair.asPascalCase),
              trailing: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: isFavourite ? Colors.red : null,
              ),
              onTap: () {
                setState(() {
                  if (isFavourite) {
                    myFavourites.remove(thePair);
                  } else {
                    myFavourites.add(thePair);
                  }
                });
                print(myFavourites.length);
              },
            );


            return ListTile(
              title: Text("$index")
            );
          },
        ),
//        child: ListView(
////          children: <Widget>[
////            for(var vp in myWordPairs)
////              ListTile(
////                title: Text(vp.asPascalCase)
////              )
////          ],
////          children: myWordPairs.map((vp) =>
////              ListTile(
////                title: Text(vp.asPascalCase)
////              )
////          ).toList(),
//          children: widgetList
//        ),
      ),
    );
  }
}
