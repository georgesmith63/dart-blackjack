library card;

final List cardValues = ['A','2','3','4','5','6','7','8','9','10','J','Q','K'];
final List suitValues = ['&clubs;','&diams;','&hearts;','&spades;'];

class Card {
  int cardIndex;
  int suitIndex;
  
  Card(int cardIndex, int suitIndex) {
    this.cardIndex = cardIndex;
    this.suitIndex = suitIndex;
  }
  String toString() {
    return cardValues[cardIndex] + suitValues[suitIndex];
  }
  String getValue() {
    return cardValues[cardIndex];
  }
}