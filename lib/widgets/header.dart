// * Shows the date and the location
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// * Misc.
final String settingsIconPath = '../../assets/icons/settings_icon.svg';

class Header extends StatelessWidget {
  final String subtitle;
  const Header({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "15 November 2025",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(subtitle, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
        IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            width: 32,
            height: 32,
            settingsIconPath,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }
}
