import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(BuildContext context, Size size);

class ResponsiveSafeArea extends StatelessWidget {
  final ResponsiveBuilder responsiveBuilder;
  const ResponsiveSafeArea({Key key, @required builder})
      : responsiveBuilder = builder,
        super(key: key);

  static const _screenContentPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(_screenContentPadding),
            child: responsiveBuilder(context, constraints.biggest),
          );
          // return responsiveBuilder(context, constraints.biggest);
        },
      ),
    );
  }
}
