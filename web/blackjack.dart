import 'dart:html';

import 'game.dart';


ButtonElement restartButton;
ButtonElement splitButton;
ButtonElement doubleButton;
ButtonElement hitButton;
ButtonElement standButton;
ButtonElement userStandButton;

DivElement userCards;
DivElement userSum;
DivElement dealerCards;
Game game;

void main() {
  game = new Game();
  
  // game controls
  restartButton = querySelector('#userrestart');
  restartButton.onClick.listen(updateRestartGame);
  splitButton = querySelector('#usersplit');
  splitButton.onClick.listen(updateSplit);
  doubleButton = querySelector('#userdouble');
  doubleButton.onClick.listen(updateDouble);
  hitButton = querySelector('#userhit');
  hitButton.onClick.listen(updateUserHit);
  standButton = querySelector('#userstand');
  
  // attach game view
  userCards = querySelector('#usercards');
  userSum = querySelector('#usersum');
  dealerCards = querySelector('#dealercards');
  
  // update game view
  printUserState();
  printDealerState();
}

void updateRestartGame(Event e) {
  game.restart();
  enableButtons();
  printUserState();
  printDealerState();
}

void updateSplit(Event e) {
  if(game.isUserSplit()) {
    print('splitting');
  }
}

void updateDouble(Event e) {
  if(game.isUserDouble()) {
    print('double');
    game.userPickACard();
    printUserState();
    disableButtons();
  }
}

void updateUserHit(Event e) {
  game.userPickACard();
  printUserState();
}

void printDealerState() {
  dealerCards.text = "";
  dealerCards.appendHtml("cards: " + game.dealerCards);
}


void printUserState() {
  userCards.text = "";
  userCards.appendHtml("cards: " + game.userCards);
  userSum.text = "sum: " + game.userSum;
  
  if (game.isUserBusted){
    userSum.text += " BUSTED";
    disableButtons();  
  }
  else if (game.isUserBlackJack) {
    userSum.text = "21...blackjack!";
    disableButtons();
  }
  else if (game.isUser21) {
    userSum.text = "21...winner!";
    disableButtons();
  }
}

void disableButtons() {
  splitButton.disabled = true;
  doubleButton.disabled = true;
  hitButton.disabled = true;
  standButton.disabled = true;
}

void enableButtons() {
  splitButton.disabled = false;
  doubleButton.disabled = false;
  hitButton.disabled = false;
  standButton.disabled = false;
}




