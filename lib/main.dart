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
        primarySwatch: Colors.orange,
      ),
      home: RandomWords(),
    );
  }
}


// Builds the list and generates the Random Words

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions()
    );
  }


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


  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase.split(new RegExp(r"(?=[A-Z])")).join(' '),
        style: _biggerFont
      )
    );
  }

}


// Calls the class that builds the list that generates the words

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

