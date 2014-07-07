library deck;

import 'dart:math' show Random;
import 'card.dart' show Card;

final int CARDS_IN_DECK = 52;
final int DECKS_IN_SHOE = 4;
final int SUITS = 4;

class Deck {
  final Random indexGen = new Random();
  static int totalCards = DECKS_IN_SHOE * CARDS_IN_DECK;
  List<bool> deck = new List(totalCards);
  
  
  Card pickACard() {
      int index = indexGen.nextInt(totalCards);
      deck[index] = true;
      
      int cardInDeck = index % CARDS_IN_DECK;
      int cardValue = cardInDeck % 13;
      int suitValue = cardInDeck ~/ 13;
      
      return new Card(cardValue, suitValue);
  }
}
