import 'package:flutter/material.dart';
import 'package:store_app/components/my_height.dart';

class MyProgress {
  Future loadingProgresstor(
      {required BuildContext context, required String title}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.transparent,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      const MyHeight(
                        height: 5.0,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
