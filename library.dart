import 'dart:io';

import 'project.dart';

abstract class Library {
  static String name = "SarLmeShmia"; // Library's name

//   --- Attributes ---
  late int? bookId;
  late String? bookTitle;
  late String? author;
  late num? price;
  late int? quantity;

//   --- Constructor ---
  Library(
      {this.bookId, this.bookTitle, this.author, this.price, this.quantity});

//getter
  get getName {
    return name;
  }

// setter
  set setLibraryName(String? libraryName) {
    libraryName = name;
  }
} //class Library end

// a class "Book" inherits the Library class
class Book extends Library {
  //    --- inherited constructor from Library ---
  Book(
      {required super.bookId,
      required super.bookTitle,
      required super.author,
      required super.price,
      required super.quantity});

// print accessable details from the super class
  printDetails() {
    print(
        "ID: ${super.bookId}\nTitle: ${super.bookTitle}\nby ${super.author}\nPrice: ${super.price}\n${super.quantity} in stock\n");
  }
} // class Book end

// List type Book initialization to contains the objects
List<Book> books = [];
// print the values of the list "books" row-by-row
printAll() {
  for (var i = 0; i < books.length; i++) {
    books[i].printDetails();
    print("-_-_-_-_-_-_-_-_-_-_-\n"); //spacing
  }
}

// Wellcoming message
welcoming() {
  print("\n\n ✐   Wellcome to the ${Library.name} BookStore ©   ✐ \n\n");
}

//the Menu
msgSelect() {
  print(
      "     ---- Plase select from the menu ---- \n\n 1: Show all Books \n 2: Search By > \n 3: Modify a Book by ID \n 4: Add a new Book \n 5: Delete a Book \n x: to exit\n\n     ------------------------------------");
}

selectedChoices({String? fromUser}) {
  switch (fromUser) {
    // Display case
    case "1":
      print("-_-_-_-_-_-_-_-_-_-_-\n"); // spacing
      printAll();
      break;
// Searching case
    case "2":
      print(
          "\nSearching By : \n1 > By ID \n2 > By Book title \n3 > By Author \n0 > GO BACK"); // nested menu
      var input = int.parse(stdin.readLineSync()!); // input from user
      // by ID
      if (input == 1) {
        print("\nEnter Book ID:");
        int bookId = int.parse(stdin.readLineSync()!);
        searchById(bookId: bookId); // send argument to the called method
        // by Title
      } else if (input == 2) {
        print("\nEnter Book Title:");
        var bookName = stdin.readLineSync()!;
        searchByName(title: bookName); // send argument to the called method
        // by Author
      } else if (input == 3) {
        print("\nEnter Author:");
        var authorName = stdin.readLineSync()!;
        searchByAuthor(bookAuthor: authorName);
      } else if (input == 0) {
        print("\nBack..\n");
      }
      break;
// Modifying case
    case "3":
      print("\nEnter Book's ID to Modify");
      int modifyId = int.parse(stdin.readLineSync()!);
      modify(modifyInput: modifyId);
      break;
// Adding case
    case "4":
      print("\nAdding a new Book!\nAuthor : ");
      var a = stdin.readLineSync();
      print("\nTitle : ");
      var t = stdin.readLineSync();
      print("\nPrice:");
      var p = num.parse(stdin.readLineSync()!);
      print("\nID: ");
      var i = int.parse(stdin.readLineSync()!);
      for (var x in books) {
        // checking
        if (i == x.bookId) {
          print("This ID is used\n Try Again");
          i = int.parse(stdin.readLineSync()!);
        }
      }
      print("Quantity : ");
      var q = int.parse(stdin.readLineSync()!);
// send the inputs to the called method to create an Object from the inputs
      addNewbook(author: a, id: i, price: p, quant: q, title: t);
      break;
    // Deleting
    case "5":
      print("\nEnter ID to Delete a Book\n ");
      deleteABook(
          bookId: int.parse(
              stdin.readLineSync()!)); // send ID type int to a deleting method
      break;
    case "x":
      exit(0);
      break;
    // exits(); is to stop the current program by terminating running Dart VM
    default:
      print("\n\n Not found..\n\n");
      break;
  }
} // end Selection - switch

// Searchin by ID
searchById({int? bookId}) {
  for (var x in books) {
    if (x.bookId == bookId) {
      print("\nresult : \n");
      x.printDetails();
    }
  }
}

// Searchin by Title
searchByName({String? title}) {
  for (var x in books) {
    if (x.bookTitle == title) {
      print("\nResult : \n");
      x.printDetails();
    }
  }
}

// Searchin by Author
searchByAuthor({String? bookAuthor}) {
  for (var x in books) {
    if (x.author == bookAuthor) {
      print("\n Result : \n");
      x.printDetails();
    }
  }
}

// Modifying
modify({int? modifyInput}) {
  for (var x in books) {
    // compare to check
    if (x.bookId == modifyInput) {
      print("\nPrevious name: ${x.bookTitle}\n"); // display previous
      print("Enter a new name");
      x.bookTitle = stdin.readLineSync();
      print("Title updated to '${x.bookTitle}'\n");
    }
  }
}

// Adding
addNewbook({int? id, String? title, String? author, num? price, int? quant}) {
  books.add(Book(
      bookId: id,
      bookTitle: title,
      author: author,
      price: price,
      quantity: quant));
}

// Deleting
deleteABook({int? bookId}) {
  bool notfound = false;
  for (var i = 0; i < books.length; i++) {
    if (books[i].bookId == bookId) {
      books.removeAt(i);
      notfound = true;
      print("\n Removed.. \n");
    }
  }
// otherwise
  if (notfound == false) {
    print("Not Found");
  }
}

void main() {
  // creating the objects and store it in a list from type Book
  books.add(Book(
      bookId: 1,
      bookTitle: "Start with why",
      author: "Simon Sinek",
      price: 80.0,
      quantity: 13));
  books.add(Book(
      bookId: 2,
      bookTitle: "But how do it know",
      author: "J. Clark Scott",
      price: 59.9,
      quantity: 22));
  books.add(Book(
      bookId: 3,
      bookTitle: "Clean Code",
      author: "Robert Cecil Martin",
      price: 50.0,
      quantity: 5));
  books.add(Book(
      bookId: 4,
      bookTitle: "Zero to One",
      author: "Peter Thiel",
      price: 45.0,
      quantity: 12));
  books.add(Book(
      bookId: 5,
      bookTitle: "You don't know JS",
      author: "Kyle Simpson",
      price: 39.9,
      quantity: 9));

// loop to display the welcoming message
  welcoming();
// loop to display the menu
  for (var i = 0; i < 34; i++) {
    msgSelect();
    var input = stdin.readLineSync(); // to get value from the user
    selectedChoices(fromUser: input); // send the value to the called method
  }
} // end main
