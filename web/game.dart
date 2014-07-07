library game;

import 'deck.dart';
import 'card.dart';


class Game {
  Deck _deck;
  List<Card> _dealerCards;
  List<Card> _userCards;
  
  Game() {
    init();
  }

  // start the game
  void init() {
      _deck = new Deck();
      _userCards = new List();
      _userCards.add(_deck.pickACard());
      _userCards.add(_deck.pickACard());
      _dealerCards = new List();
      _dealerCards.add(_deck.pickACard());
      _dealerCards.add(_deck.pickACard());
  }
  
  void restart() {
    _userCards.clear();
    _userCards.add(_deck.pickACard());
    _userCards.add(_deck.pickACard());
    _dealerCards.clear();
    _dealerCards.add(_deck.pickACard());
    _dealerCards.add(_deck.pickACard());
  }
  
  // get the state of the game.
  bool get isUserBusted => userState() == -1;
  bool get isUser21 => userState() == 1;
  bool get isUserBlackJack => isUser21 && _userCards.length == 2;
  
  int userState() {
    List<int> summation = addCards(_userCards);
    for (int i = 0; i < summation.length; ++i) {
      int sum = summation[i];
      if (i == 0 && sum == null) {
        return -1;
      }
      if (sum == null) {
        continue;
      }
      if (i == 0 && sum > 21) {
        return -1;
      }
      if (sum == 21) {
        return 1;
      }
    }
    return 0;
  }
  
  bool isUserSplit() {
    return _userCards.length == 2 && _userCards[0].getValue() == _userCards[1].getValue(); 
  }
  bool isUserDouble() {
    return _userCards.length == 2;
  }
  
  // is the comma delimited string of the cards 
  String listUserCards() {
    return listCards(_userCards, false);
  }
  String listDealerCards() {
    return listCards(_dealerCards, true);
  }
  
  String listCards(List<Card> cards, bool dealer) {
    String ret = "";
    for (int i = 0; i < cards.length; ++i) {
      Card c = cards[i];
      
      if (ret != "") 
        ret += ", ";
      
      if (i == 0 && dealer) 
        ret = "??";
      else 
        ret += c.toString();
    }
    return ret;
  }
  
  String get userCards => listUserCards();
  String get dealerCards => listDealerCards();
  
  // game activity: user picks a card
  void userPickACard() {
    _userCards.add(_deck.pickACard());
  }
  
  String get userSum => cardSummation(addCards(_userCards));
  String get dealerSum => cardSummation(addCards(_dealerCards));
  
  // adds the cards and returns an array of ints
  // when the user gets an ace, the size of the array will
  // double based on ace having a value of 1 or 11.
  List<int> addCards(List<Card> cards) {
    List<int> summation = new List();
    for (Card c in cards) {
      int length = summation.length;
      
      // 1 and 11
      if (c.getValue() == 'A') {
        // copy the values
        for (int i = 0; i < length; ++i) {
          summation.add(summation[i]);
        }
        
        // half of these add 1 and the other half add 11
        for (int i = 0; i < length; ++i) {
          if (summation[i] == null) {
            continue;
          }
          int sum = summation[i] + 1;
          if (sum > 21) {
            summation[i] = null;
          }
          else {
            summation[i] = sum;
          }
        }
        for (int i = length; i < length*2; ++i) {
          if (summation[i] == null) {
            continue;
          }
          int sum = summation[i] + 11;
          if (sum > 21) {
            summation[i] = null;
          }
          else {
            summation[i] = sum;
          }
        }
        // not instantiated
        if(length == 0) {
          summation.add(1);
          summation.add(11);
        }
      }
      else if (c.getValue() == 'K' || 
               c.getValue() == 'Q' || 
               c.getValue() == 'J') {
        if (length == 0) 
          summation.add(10);
        for (int i = 0; i < length; ++i) {
          if (summation[i] == null) {
            continue;
          }
          int sum = summation[i] + 10;
          if (sum > 21) {
            summation[i] = null;
          }
          else {
            summation[i] = sum;  
          }
          
        }
      }
      else {
        if (length == 0) 
          summation.add(int.parse(c.getValue()));
        for (int i = 0; i < length; ++i) {
          if (summation[i] == null) {
            continue;
          }
          int sum = summation[i] + int.parse(c.getValue());
          if (sum > 21) {
            summation[i] = null;
          }
          else {
            summation[i] = sum;
          }
        }
      }
    }
    return summation;
  }

  // list of card summations as a comma delimited string 
  String cardSummation(List<int> summation) {
    String sum = "";
    for (int s in summation) {
      if (s == null) {
        continue;
      }
      if (sum != "") {
        sum += ", ";
      }
      sum += s.toString();  
    }
    return sum;
  }

}