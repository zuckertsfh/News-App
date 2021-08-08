part of 'widgets.dart';

SnackBar snackbar(String title) => SnackBar(
      content: Text(title),
      behavior: SnackBarBehavior.floating,
      backgroundColor: null,
      action: SnackBarAction(
        label: "Dismiss",
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
