import 'dart:math';
import 'package:flutter/material.dart';

const double _containerHeight = 250.0;
const double _containerWidth = 300.0;
const double _tagHeight = 25.0;
const double _tagWidth = 90.0;
const double _borderWidth = 1.0;
int countMaxItemInRow = ((_containerWidth - 16) / (_tagWidth + 2)).floor();
int countMaxItemInColumn = ((_containerHeight - 16) / (_tagHeight + 2)).floor();
int showItemCount = countMaxItemInRow * countMaxItemInColumn;

String _generateRandomWord() {
  Random random = Random();
  String alphabet = 'abcdefghijklmnopqrstuvwxyz';
  int length = random.nextInt(10) + 1;

  return String.fromCharCodes(
    List.generate(
      length,
      (_) => alphabet.codeUnitAt(random.nextInt(alphabet.length)),
    ),
  );
}

class MainScreenViewStatic extends StatelessWidget {
  const MainScreenViewStatic({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> showItems = [];
    List<Widget> list = List.generate(
        40, (index) => _buildCustomTagTile(_generateRandomWord()));

    int hideItem = (list.length - showItemCount) + 1;
    if (showItemCount < list.length) {
      showItems.addAll(list.take(showItemCount - 1));
      showItems.add(_buildCustomTagTile('+ $hideItem'));
    } else {
      showItems.addAll(list);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('UBRAINIANS Test'),
        centerTitle: true,
      ),
      body: _buildBody(showItems),
    );
  }

  Widget _buildBody(List<Widget> showItems) {
    return Center(
        child: Container(
          height: _containerHeight,
          width: _containerWidth,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 1)
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 4,
              spacing: 4,
              children: showItems,
            ),
          ),
        ),
      );
  }

  Widget _buildCustomTagTile(String title) {
    return Container(
      alignment: Alignment.center,
      height: _tagHeight,
      width: _tagWidth,
      decoration: BoxDecoration(
        border: Border.all(width: _borderWidth),
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(title, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
