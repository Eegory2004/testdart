/*import 'dart:io';

// Класс для представления игрока
class Player {
  String name;
  String symbol;

  Player(this.name, this.symbol);
}

// Класс для представления игры "Крестики-нолики"
class TicTacToe {
  List<List<String>> board;
  Player player1;
  Player player2;
  Player currentPlayer;

  TicTacToe(this.player1, this.player2)
      : board = List.generate(3, (_) => List.filled(3, ' ')),
        currentPlayer = player1;

  // Метод для отображения игрового поля
  void displayBoard() {
    print('  0 1 2');
    for (int i = 0; i < 3; i++) {
      stdout.write('$i ');
      for (int j = 0; j < 3; j++) {
        stdout.write(board[i][j]);
        if (j < 2) stdout.write('|');
      }
      print('');
      if (i < 2) print('  -----');
    }
  }

  // Метод для выполнения хода
  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != ' ') {
      print('Неверный ход. Попробуйте снова.');
      return false;
    }
    board[row][col] = currentPlayer.symbol;
    return true;
  }

  // Метод для проверки победителя
  bool checkWinner() {
    // Проверка строк, столбцов и диагоналей
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer.symbol &&
          board[i][1] == currentPlayer.symbol &&
          board[i][2] == currentPlayer.symbol) return true;
      if (board[0][i] == currentPlayer.symbol &&
          board[1][i] == currentPlayer.symbol &&
          board[2][i] == currentPlayer.symbol) return true;
    }
    if (board[0][0] == currentPlayer.symbol &&
        board[1][1] == currentPlayer.symbol &&
        board[2][2] == currentPlayer.symbol) return true;
    if (board[0][2] == currentPlayer.symbol &&
        board[1][1] == currentPlayer.symbol &&
        board[2][0] == currentPlayer.symbol) return true;
    return false;
  }

  // Метод для смены текущего игрока
  void switchPlayer() {
    currentPlayer = currentPlayer == player1 ? player2 : player1;
  }

  // Метод для проверки ничьей
  bool checkDraw() {
    for (var row in board) {
      if (row.contains(' ')) return false;
    }
    return true;
  }

  // Метод для запуска игры
  void startGame() {
    while (true) {
      displayBoard();
      print('${currentPlayer.name}, ваш ход. Введите строку и столбец (например, 1 1):');
      List<String> input = stdin.readLineSync()!.split(' ');
      int row = int.parse(input[0]);
      int col = int.parse(input[1]);

      if (makeMove(row, col)) {
        if (checkWinner()) {
          displayBoard();
          print('Поздравляем, ${currentPlayer.name}! Вы победили!');
          break;
        } else if (checkDraw()) {
          displayBoard();
          print('Ничья!');
          break;
        }
        switchPlayer();
      }
    }
  }
}

void main() {
  print('Добро пожаловать в игру "Крестики-нолики"!');
  print('Введите имя первого игрока:');
  String player1Name = stdin.readLineSync()!;
  print('Введите имя второго игрока:');
  String player2Name = stdin.readLineSync()!;

  Player player1 = Player(player1Name, 'X');
  Player player2 = Player(player2Name, 'O');

  TicTacToe game = TicTacToe(player1, player2);
  game.startGame();
}*/

import 'dart:async';
import 'dart:math';

class Citizen {
  String name = 'Аноним';
  int balanceCash = 100;
  List<String> listOfPurchase = [];

  Citizen({required this.name, required this.balanceCash, required this.listOfPurchase});
}

class Shop {
  String name = 'магазин';
  Map<String, int> listOfItems = {'яблоко': 1, 'банан': 2, 'апельсин': 3};

  Shop({required this.name, required this.listOfItems});
}

class Weather {
  List<String> weather = ['солнечно', 'дождливо', 'облачно'];
  String currentWeather;

  Weather() : currentWeather = 'солнечно';

  void generateRandomWeather() {
    Random random = Random();
    currentWeather = weather[random.nextInt(weather.length)];
  }
}

void main() async {
  Weather weather = Weather();
  List<Citizen> citizens = [
    Citizen(name: 'Алиса', balanceCash: 150, listOfPurchase: []),
    Citizen(name: 'Боб', balanceCash: 200, listOfPurchase: []),
    Citizen(name: 'Чарли', balanceCash: 50, listOfPurchase: []),
  ];

  Shop shop = Shop(name: 'магазин', listOfItems: {'яблоко': 1, 'банан': 2, 'апельсин': 3});

  for (int day = 1; day <= 10; day++) {
    weather.generateRandomWeather();
    print('День $day: Сегодня погода: ${weather.currentWeather}.');

    for (var citizen in citizens) {
      if (shouldGoOut(weather.currentWeather)) {
        print('${citizen.name} идет в магазин.');
        String item = chooseRandomItem(shop.listOfItems);
        if (citizen.balanceCash >= shop.listOfItems[item]!) {
          citizen.balanceCash -= shop.listOfItems[item]!;
          citizen.listOfPurchase.add(item);
          print('${citizen.name} купил(а) $item за ${shop.listOfItems[item]}.');
        } else {
          print('${citizen.name} не хватает денег на $item.');
        }
      } else {
        print('${citizen.name} остается дома.');
      }
    }

    await Future.delayed(Duration(seconds: 1));
  }

  print('\nИтоговый отчет:');
  for (var citizen in citizens) {
    int totalSpent = citizen.balanceCash;
    print('Имя: ${citizen.name}, Потрачено денег: $totalSpent, Покупки: ${citizen.listOfPurchase}');
  }
}

bool shouldGoOut(String weather) {
  Random random = Random();
  if (weather == 'солнечно') {
    return random.nextInt(100) < 80; // 80% вероятность выйти
  } else if (weather == 'облачно') {
    return random.nextInt(100) < 50; // 50% вероятность выйти
  } else if (weather == 'дождливо') {
    return random.nextInt(100) < 20; // 20% вероятность выйти
  }
  return false;
}

String chooseRandomItem(Map<String, int> items) {
  Random random = Random();
  List<String> keys = items.keys.toList();
  return keys[random.nextInt(keys.length)];
}
