import 'package:flutter/material.dart';
import '../components/bottom_design.dart';

import '../components/top_design.dart';


class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopDesign(
          title: 'About App',
          subtitle: '...apps\'s functionalities and developer',
        ),
        BottomDesign(
          widget: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 33,
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'APP PURPOSE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors. A theme showcase widget shows the theme with several common Material widgets.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                )),
                Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                        child: Column(children: const [
                      ExpansionTile(
                        initiallyExpanded: true,
                        childrenPadding: EdgeInsets.all(10),
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Text(
                            'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                          )
                        ],
                      ),
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ),
                       ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ), ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ), ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ), ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ), ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        leading: Icon(Icons.help),
                        title: Text('Is this App good?'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This example shows how you can use all the built-in color schemes, plus three custom schemes. How to interactively select which one of these schemes is used to define the active theme. The example also uses medium branded background and surface colors.',
                            ),
                          )
                        ],
                      ),
                    ]))),
              ],
            ),
          ),
        )
      ],
    );
  }
}
