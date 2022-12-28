class Book {
  Book(ISPN,title,category,publisher,publication_year,price,stock){
    this.ISPN=ISPN;
    this.title=title;
    this.category=category;
    this.publisher=publisher;
    this.publication_year=publication_year;
    this.price=price;
    this.stock=stock;
  }
  String ISPN = '';
  String title = '';
  String category = '';
  String publisher = '';
  int publication_year = 0;
  double price =0.0;
  int stock=0;
}
