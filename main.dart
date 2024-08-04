import 'package:dart_application_2/dart_application_2.dart' as dart_application_2;

typedef BookFilter = bool Function(Book);

class Book{
  String title;
  String author;
  int yearPublished;
  bool isCheckout;

  Book({required this.title,required this.author,required this.yearPublished,required this.isCheckout});
  Book.unkwonAuthor():
    title='',
    author = 'Unknown',
    yearPublished = 0,
    isCheckout = false;
  factory Book.fromMap(Map<String,dynamic> map){
    return Book(
      title: map['title']as String,
      author: map['author']as String,
      yearPublished: map['yearPublished']as int,
      isCheckout: map['isCheckout']as bool,
      );
  }
  String isCheckedout(){
    switch(isCheckout){
      case true:
        return 'Checked Out!';
      case false:
        return 'Available';
      default:
        return 'Unknown Status!';
    }
  }
}
  int countCheckedOutBooks(List<Book>books){
    return books.map((books)=>books.isCheckout?1:0).reduce((count,element)=>count+element);

  }
  
  int totalBooksPublishedAfter(List<Book>books , int year){
    return books.fold(0, (int count , book){
      return book.yearPublished>year? count+1 : count;
    });
  }
List<Book> filterBook(List<Book>books ,BookFilter filter){
      return books.where(filter).toList();
  }
void main(List<String> arguments) {
  List<Book> books =[
    Book(title: 'Book1', author: 'Hassan', yearPublished: 2010, isCheckout: true),
    Book(title: 'Book2', author: 'Hassan', yearPublished: 2010, isCheckout: true),
    Book(title: 'Book3', author: 'Muhammed', yearPublished: 2015, isCheckout: false),
  ];
  List<Book> booksByHassan = filterBook(books , (book)=> book.author == 'Hassan');
  print('Books by Hassan: ${booksByHassan.map((book)=>book.title).toList()}');
  
  int checkedOutCount = countCheckedOutBooks(books);
  print('Number of checked out books: $checkedOutCount');

  int booksAfter2010 = totalBooksPublishedAfter(books, 2010);
  print('Number of books published after 2010: $booksAfter2010');

  books.forEach((book) => print('${book.title}: ${book.isCheckedout()}'));
  

}
