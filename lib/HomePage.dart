import 'dart:async';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey
                ),
                child: Center(
                  child: Text('Сканировать',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            onTap: (){
              _scan();
            },
          )
      ),
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          android: AndroidOptions(
            aspectTolerance: 0.00,
            useAutoFocus: true,
          ),
        ),
      );

      if(result.format != BarcodeFormat.ean13){
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                height: 40,
                child: Center(child: Text('Неверный тип штрих-кода')),
              )
            );
          },
        );
      }else{
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Container(
                    height: 40,
                  child: Center(child: Text('Штрих_код: ' + result.rawContent,))
                )
            );
          },
        );
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}