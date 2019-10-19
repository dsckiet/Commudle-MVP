import 'package:flutter/material.dart';

class ShowDialog {
  showErrorDialogNetwork(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Check your Internet Connection!',
          style: TextStyle(fontFamily: 'Product Sans'),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Okay',
              style: TextStyle(
                fontFamily: 'Product Sans',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
