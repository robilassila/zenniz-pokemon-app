import 'package:flutter/material.dart';

class SingleBrowsePage extends StatelessWidget {
  const SingleBrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/132.png'),

        SizedBox(height: 20),

        Card(
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Ditto',
              style: style,
              ),
          ),
        ),

        SizedBox(height: 20),

        Row(
          mainAxisSize: MainAxisSize.max,
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                print('puppo');
              }, 
              icon: Icon(Icons.skip_previous),
              label: Text('Prev'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print('puppo');
              }, 
              icon: Icon(Icons.favorite),
              label: Text('Like'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print('puppo');
              }, 
              label: Text('Next'),
              icon: Icon(Icons.skip_next),
            ),
          ],
        )
      ],
    );
  }
}