import 'package:app_wallet/components/credit_card/credit_card_stack.dart';
import 'package:flutter/material.dart';

const _kCardHorizontalSpacing = 20.0;
const _kIndicatorSize = 6.0;
const _kIndicatorSpacing = 15.0;
const _kStackAspectRatio = 1.4228;

class CreditCardSlider extends StatefulWidget {
  const CreditCardSlider({Key? key}) : super(key: key);

  @override
  State<CreditCardSlider> createState() => _CreditCardSliderState();
}

class _CreditCardSliderState extends State<CreditCardSlider> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      final cardWidth = constraints.maxWidth - 2 * _kCardHorizontalSpacing;
      final cardStackHeight = cardWidth / _kStackAspectRatio;

      return Column(
        children: [
          SizedBox(
            height: cardStackHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedBuilder(
                    animation: pageController,
                    builder: (context, snapshot) {
                      final pageValue = pageController.hasClients &&
                              pageController.page != null
                          ? pageController.page!
                          : 0.0;
                      return CreditCardStack(
                          pageValue: pageValue,
                          horizontalSpacing: _kCardHorizontalSpacing);
                    }),
                PageView(
                  controller: pageController,
                  children: const [
                    SizedBox.expand(),
                    SizedBox.expand(),
                    SizedBox.expand(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          AnimatedBuilder(
              animation: pageController,
              builder: (context, snapshot) {
                final pageIndex =
                    pageController.hasClients && pageController.page != null
                        ? pageController.page!.round()
                        : 0;
                return _PageIndicator(
                    pageIndex: pageIndex,
                    totalPages: 3,
                    size: _kIndicatorSize,
                    spacing: _kIndicatorSpacing);
              })
        ],
      );
    }));
  }
}

class _PageIndicator extends StatelessWidget {
  final int pageIndex;
  final int totalPages;
  final double size;
  final double spacing;

  const _PageIndicator(
      {Key? key,
      required this.pageIndex,
      required this.totalPages,
      this.size = 6.0,
      this.spacing = 15.0})
      : assert(pageIndex < totalPages),
        super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size,
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildDots(),
        )),
      );

  List<Widget> _buildDots() {
    final result = <Widget>[];

    for (int i = 0; i < totalPages; i++) {
      result.add(Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == pageIndex ? const Color(0xFF00A6C2) : Colors.white),
      ));

      if (i != totalPages - 1) {
        result.add(SizedBox(width: spacing));
      }
    }

    return result;
  }
}
