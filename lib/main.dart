// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.lime,
      ),
      home: RandomWords(),
    );
  }
}


// Builds the list and generates the Random Words

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // Main app scaffold / layout

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions()
    );
  }


  // List builder
  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return Divider();

      final index = i ~/ 2;

      if (index >= _suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestions[index]);

    });
  }


  // Row builder
  Widget _buildRow(WordPair pair) {

    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase.split(new RegExp(r"(?=[A-Z])")).join(' '),
        style: _biggerFont
      ),
      trailing: Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        color: alreadySaved ? Colors.amber : null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(

       builder: (BuildContext context) {

         final Iterable<ListTile> tiles = _saved.map(
             (WordPair pair) {
               return ListTile(
                 title: Text(
                     pair.asPascalCase.split(new RegExp(r"(?=[A-Z])")).join(' '),
                     style: _biggerFont
                 ),
               );
             },
         );

         final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

         return Scaffold(
           appBar: AppBar(
             title: Text('Saved Suggestions'),
           ),
           body: ListView(children: divided,)
         );
       }
      )
    );
  }

}


// Calls the class that builds the list view

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

