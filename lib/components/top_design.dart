import 'package:flutter/material.dart';

class TopDesign extends StatelessWidget {
  final String title;
  final String subtitle;
  // ignore: use_key_in_widget_constructors
  const TopDesign({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Builder(builder: (context)=>
                GestureDetector(
                  onTap: ()=>Scaffold.of(context).openDrawer(),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.list,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 40,
                        ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                     title,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                    subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
