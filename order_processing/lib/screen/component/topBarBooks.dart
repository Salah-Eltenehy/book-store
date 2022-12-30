import 'package:flutter/material.dart';
import '../../Book.dart';

Widget topBarBook(Book book)
{
  return Container(
    width: 122.0,
    margin: EdgeInsets.only(right: 12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 121.66,
          height: 180.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(book.photoUrl),
              fit: BoxFit.cover,
            )
          ),
        ),
        SizedBox(
          height: 12.0,
        ),

        Text(book.title,
        style: TextStyle(
          fontSize: 18,
        ),
        ),
      ],
    ),
  );
}