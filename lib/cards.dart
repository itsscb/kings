import 'dart:math';

import 'package:flutter/material.dart';

class Card {
  Card({required this.path, required this.text});
  String path;
  String text;

  void setCard({required String path, String text=''}) {
    this.path = path;
    this.text = text;
  }
}

class Game {
  Card deckCard = Card(path: 'back.png',text: '');
  Card currCard = Card(path: 'back.png',text: 'Ready to start');
  List<String> allCards = [
    '2_of_clubs.png',
    '2_of_diamonds.png',
    '2_of_hearts.png',
    '2_of_spades.png',
    '3_of_clubs.png',
    '3_of_diamonds.png',
    '3_of_hearts.png',
    '3_of_spades.png',
    '4_of_clubs.png',
    '4_of_diamonds.png',
    '4_of_hearts.png',
    '4_of_spades.png',
    '5_of_clubs.png',
    '5_of_diamonds.png',
    '5_of_hearts.png',
    '5_of_spades.png',
    '6_of_clubs.png',
    '6_of_diamonds.png',
    '6_of_hearts.png',
    '6_of_spades.png',
    '7_of_clubs.png',
    '7_of_diamonds.png',
    '7_of_hearts.png',
    '7_of_spades.png',
    '8_of_clubs.png',
    '8_of_diamonds.png',
    '8_of_hearts.png',
    '8_of_spades.png',
    '9_of_clubs.png',
    '9_of_diamonds.png',
    '9_of_hearts.png',
    '9_of_spades.png',
    '10_of_clubs.png',
    '10_of_diamonds.png',
    '10_of_hearts.png',
    '10_of_spades.png',
    'Jack_of_clubs.png',
    'Jack_of_diamonds.png',
    'Jack_of_hearts.png',
    'Jack_of_spades.png',
    'Queen_of_clubs.png',
    'Queen_of_diamonds.png',
    'Queen_of_hearts.png',
    'Queen_of_spades.png',
    'King_of_clubs.png',
    'King_of_diamonds.png',
    'King_of_hearts.png',
    'King_of_spades.png',
    'Ace_of_clubs.png',
    'Ace_of_diamonds.png',
    'Ace_of_hearts.png',
    'Ace_of_spades.png',
  ];
  List<String> availableCards = [];
  List<String> playedCards = [];

  Map<String, String> helpTexts = {
    'King': 'The Drawer takes the Fall.',
    'Queen': 'Left has to loosen up.',
    'Jack': 'Right, get ready to rumble!',
    'Ace': 'One Rule to rule them all,\nOne Rule to find them,\nOne Rule to bring them all\nand in the darkness bind them.',
    '10': 'Thumbs up!',
    '9': 'GECKO!',
    '8': 'Let\'s talk about...',
    '7': 'Seven is Heaven',
    '6': 'I have never...',
    '5': '5',
    '4': '4',
    '3': '3',
    '2': '2',
  };
  int ruleCount = 0;
  int counter = -1;

  String getText() {
    if (currCard.path.contains('Ace')) {
      String id = 'One Rule';
      switch (ruleCount) {
        case 2: {
          id = 'Two Rules';
        }break;
        case 3: {
          id = 'Three Rules';
        }break;
        case 4: {
          id = 'Four Rules';
        }break;
        default: {
          id = 'One Rule';
        }
      }
      return currCard.text.replaceAll('One Rule', id);
    }
    return currCard.text;
    return helpTexts[currCard.path.split('_')[0]].toString();
  }

  void updateText() {
    currCard.text = helpTexts[currCard.path.split('_')[0]].toString();
  }

  void nextCard() {
    if (playedCards.length >= allCards.length &&
        counter >= playedCards.length - 1) {
      currCard.setCard(path: deckCard.path, text: 'Game Over');
      return;
    }

    if (counter != -1 && counter < playedCards.length - 1) {
      counter++;
      currCard.setCard(path: playedCards[counter]);
      updateText();

      return;
    }

    //if (counter == playedCards.length - 1 || counter == -1) {
    counter++;
    int random = Random().nextInt(availableCards.length);
    playedCards.add(availableCards[random]);
    availableCards.removeAt(random);
    currCard.setCard(path: playedCards[playedCards.length - 1]);
    updateText();
    if (currCard.path.contains('Ace')) {
      ruleCount++;
    }
    return;
    //}
  }

  void prevCard() {
    if (counter > 0) {
      counter--;
      currCard.setCard(path: playedCards[counter]);
      updateText();
      return;
    } else {
      currCard.setCard(path: playedCards[counter]);
      updateText();
      return;
    }
  }

  void resetGame() {
    playedCards = [];
    availableCards = allCards.toList();
    counter = -1;
    ruleCount = 0;
    currCard.setCard(path: deckCard.path, text: 'Ready to rumble');
    return;
  }
}