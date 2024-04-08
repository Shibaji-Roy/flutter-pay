import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySquare extends StatelessWidget {
  const MySquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(77, 169, 190, 10),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        height: 180,
        child: Center(
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                alignment: Alignment.topRight,
                icon: const Icon(Icons.language),
                onPressed: () {
                  // Handle language change
                },
              ),
            ),
            //const SizedBox(height: 20),
            SvgPicture.asset('assets/svg/logo-no-background (1).svg',
                height: 120, width: 120)
          ]),
          // child: Container(
          //   child: IconButton(
          //   icon: const Icon(Icons.language),
          //   onPressed: () {
          //     // Handle language change
          //   },
          // ),
          //   height: 200,
          //   color: Colors.blue,
          // ),
        ),
      ),
    );
  }
}
