import 'package:flutter/material.dart';
import '../../size_configs.dart';
import '../../app_styles.dart';

class LargeIconButton extends StatelessWidget {
  const LargeIconButton({
    Key? key,
    required this.buttonName,
    required this.iconImage,
    required Color color,
  }) : super(key: key);

  final String buttonName, iconImage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 30,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                // height: 25,
                child: Image.asset(iconImage),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 3,
              child: Text(
                buttonName,
                style: TextStyle(
                  color: Color(0xff201753),
                  fontSize: SizeConfig.blockSizeH! * 4.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
