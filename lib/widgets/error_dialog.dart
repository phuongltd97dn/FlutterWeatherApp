import 'package:flutter/cupertino.dart';

void errorDialog(BuildContext context, String errorMessage) {
  // if (Platform.isIOS) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      );
    },
  );
  // }
}
