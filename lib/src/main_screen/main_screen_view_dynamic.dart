import 'dart:math';
import 'package:flutter/material.dart';

const double _containerHeight = 100.0;
const double _containerWidth = 300.0;
const double _tagHeight = 25.0;
double _tagsWidth = 0.0;
int _countWrapWidgets = 0;
const double _borderWidth = 1.0;
int _countMaxColumn = ((_containerHeight - 16) / (_tagHeight + 2)).floor();
int _countColumn = 1;

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

class MainScreenViewDynamic extends StatelessWidget {
  const MainScreenViewDynamic({super.key});

  @override
  Widget build(BuildContext context) {
    double containerWidth = _containerWidth - 16;
    List<Widget> showItems = [];
    List<String> stringList =
        List.generate(60, (index) => _generateRandomWord());

    List<Widget> list = [];

    for (var element in stringList) {
      list.add(_buildCustomTagTile(element));
    }

    for (var element in stringList) {
      TextPainter textPainter = TextPainter()
        ..text = TextSpan(text: element, style: null)
        ..textDirection = TextDirection.ltr
        ..layout(minWidth: 0, maxWidth: double.infinity);
      textPainter.size.width;

      if (containerWidth > _tagsWidth && _countMaxColumn > _countColumn) {
        _tagsWidth = _tagsWidth + (textPainter.size.width + 12);
        _countWrapWidgets++;
        if (containerWidth <= _tagsWidth && _countMaxColumn > _countColumn) {
          _tagsWidth = 0;
          _tagsWidth = _tagsWidth + (textPainter.size.width + 12);
          _countColumn++;
        }
      } else if (containerWidth > _tagsWidth &&
          _countMaxColumn <= _countColumn) {
        containerWidth = 235;
        _tagsWidth = _tagsWidth + (textPainter.size.width + 12);
        _countWrapWidgets++;
        if (containerWidth < _tagsWidth && _countMaxColumn == _countColumn) {
          _countWrapWidgets--;
        }
      }
    }

    int hideItem = list.length - (_countWrapWidgets - 1);

    if (_countWrapWidgets < list.length || _countMaxColumn > _countColumn) {
      showItems.addAll(list.take(_countWrapWidgets - 1));
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
                spacing: 4,
                runSpacing: 4,
                children: showItems,
              )),
        ),
      );
  }

  Widget _buildCustomTagTile(String title) {
    return Container(
      height: _tagHeight,
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
