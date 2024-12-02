import 'package:flutter/material.dart';

class AlphabeticalScrollbar extends StatelessWidget {
  final List<String> alphabet;
  final Function(String) onLetterTap;

  const AlphabeticalScrollbar({
    super.key,
    required this.alphabet,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: alphabet.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onLetterTap(alphabet[index]),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  alphabet[index],
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
