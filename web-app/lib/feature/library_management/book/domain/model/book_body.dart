class BookBody {
  String? code;
  String? bookGroup;
  String? bookName;
  String? bookCopyNo;
  String? publisher;
  String? publishYear;
  String? provider;
  String? totalPage;
  String? identificationPage;
  String? author;
  String? edition;
  String? description;
  String? category;
  String? quantity;
  String? price;
  String? bookself;
  String? rack;
  String? path;
  int? status;
  String? method;

  BookBody(
      {
        this.code,
        this.bookGroup,
        this.bookName,
        this.bookCopyNo,
        this.publisher,
        this.publishYear,
        this.provider,
        this.totalPage,
        this.identificationPage,
        this.author,
        this.edition,
        this.description,
        this.category,
        this.quantity,
        this.price,
        this.bookself,
        this.rack,
        this.path,
        this.status,
        this.method,
      });

  BookBody.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    bookGroup = json['book_group'];
    bookName = json['book_name'];
    bookCopyNo = json['book_copy_no'];
    publisher = json['publisher'];
    publishYear = json['publish_year'];
    provider = json['provider'];
    totalPage = json['total_page'];
    identificationPage = json['identification_page'];
    author = json['author'];
    edition = json['edition'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    price = json['price'];
    bookself = json['bookself'];
    rack = json['rack'];
    path = json['path'];
    status = json['status'];
    method = json['_method'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'code': code,
      'book_group': bookGroup,
      'book_name': bookName,
      'book_copy_no': bookCopyNo,
      'publisher': publisher,
      'publish_year': publishYear,
      'provider': provider,
      'total_page': totalPage,
      'identification_page': identificationPage,
      'author': author,
      'edition': edition,
      'description': description,
      'category': category,
      'quantity': quantity,
      'price': price,
      'bookself': bookself,
      'rack': rack,
      'path': path,
      'status': status,
      '_method': method,
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
