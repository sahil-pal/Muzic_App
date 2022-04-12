import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/config/themes/dark_theme.dart';

class SearchAppBar extends StatelessWidget {

  late TextEditingController searchCtrl;
  late Function setValueFunc;
  SearchAppBar(this.searchCtrl,this.setValueFunc);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Search',
            style: GoogleFonts.openSans(fontSize: 30, color: appBarTextColor)),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autocorrect: false,
          controller: searchCtrl,
          onEditingComplete: (){
            setValueFunc();
          },
          cursorHeight: 18,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black54),
          decoration: InputDecoration(
            hintText: 'Artists, Songs, Lyrics and More',
            hintStyle: TextStyle(fontSize: 16),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black54,
              size: 22,
            ),
            fillColor: Colors.grey.shade400,
            filled: true,
            focusColor: Colors.grey,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
        )
      ],
    );
  }
}
