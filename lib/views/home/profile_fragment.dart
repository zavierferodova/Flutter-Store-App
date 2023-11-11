import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [heading(), body(context)],
    )));
  }

  Widget heading() {
    return Text('Profil',
        textAlign: TextAlign.center,
        style: GoogleFonts.sourceSans3(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: const Color(0xff404040)));
  }

  Widget body(context) {
    return Expanded(
        child: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  const SizedBox(height: 14.0),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              color: const Color(0xffd5d5d5),
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xffdedede),
                                    offset: Offset(0, 2.0),
                                    blurRadius: 8.0)
                              ],
                              image: const DecorationImage(
                                  image:
                                      AssetImage('images/developer_logo.png'),
                                  fit: BoxFit.cover)))),
                  const SizedBox(height: 50.0),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
                          decoration: const BoxDecoration(
                              color: Color(0xff121212),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xffdedede),
                                    offset: Offset(0, -5.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              itemProfile('Nama', 'Zavier Ferodova Al Fitroh'),
                              itemProfile('Alamat', 'Surakarta'),
                              itemProfile('Jenis Kelamin', 'Laki-Laki'),
                            ],
                          )))
                ]))));
  }

  Widget itemProfile(String label, String body) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 14.0, right: 14.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: Colors.white),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            label,
            style: GoogleFonts.roboto(
                fontSize: 16.0, color: const Color(0xffa2a2a2)),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: GoogleFonts.roboto(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: const Color(0xff2c2c2c)),
          )
        ]));
  }
}
