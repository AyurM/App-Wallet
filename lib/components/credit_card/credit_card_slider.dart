import 'package:app_wallet/components/credit_card/credit_card_stack.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:flutter/material.dart';

const _kCardHorizontalSpacing = 20.0;
const _kIndicatorSize = 6.0;
const _kIndicatorSpacing = 15.0;
const _kStackAspectRatio = 1.4228;

class CreditCardSlider extends StatefulWidget {
  final List<CreditCardInput> cardsData;
  final void Function(int)? onChanged;

  const CreditCardSlider({Key? key, required this.cardsData, this.onChanged})
      : super(key: key);

  @override
  State<CreditCardSlider> createState() => _CreditCardSliderState();
}

class _CreditCardSliderState extends State<CreditCardSlider> {
  final PageController pageController = PageController();
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(_pageControllerListener);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
                    builder: (context, snapshot) => CreditCardStack(
                        cardsData: widget.cardsData,
                        pageValue: _pageValue,
                        horizontalSpacing: _kCardHorizontalSpacing)),
                PageView(
                  controller: pageController,
                  children: List<Widget>.generate(
                      widget.cardsData.length, (_) => const SizedBox.expand()),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          AnimatedBuilder(
              animation: pageController,
              builder: (context, snapshot) => _PageIndicator(
                  pageIndex: _pageIndex,
                  totalPages: widget.cardsData.length,
                  size: _kIndicatorSize,
                  spacing: _kIndicatorSpacing))
        ],
      );
    }));
  }

  void _pageControllerListener() {
    if (_pageIndex == _selectedPage) {
      return;
    }

    _selectedPage = _pageIndex;
    widget.onChanged?.call(_selectedPage);
  }

  int get _pageIndex => pageController.hasClients && pageController.page != null
      ? pageController.page!.round()
      : 0;

  double get _pageValue =>
      pageController.hasClients && pageController.page != null
          ? pageController.page!
          : 0.0;
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
