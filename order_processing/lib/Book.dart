class Book {
  Book(ISPN,title,category,publisher,publication_year,price,stock,photoUrl){
    this.ISPN=ISPN;
    this.title=title;
    this.category=category;
    this.publisher=publisher;
    this.publication_year=publication_year;
    this.price=price;
    this.stock=stock;
    this.photoUrl=photoUrl;
    this.quantity = 0;
  }
  String ISPN = '';
  String title = '';
  String author_name = '';
  String category = '';
  String publisher = '';
  int publication_year = 0;
  double price =0.0;
  int stock=0;
  String photoUrl="";
  int quantity = 0;
  int orderedquantity=20;
}
