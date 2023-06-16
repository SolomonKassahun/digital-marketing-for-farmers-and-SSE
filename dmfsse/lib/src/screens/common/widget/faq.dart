import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
 final List<Item> _faqs = [
    Item(
      'Why to use Shemeta?',
      'The system allows direct communication between sellers and buyers'
      'It also pave a way for digitized future.',
    ),
    Item(
      'What does it gain?',
      'The system will be one part of national agricultural marketing transformation.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
    Item(
      'What is new with it?',
      'Previously marketing is run by brokers, it cuts the line.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const  EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: const EdgeInsets.all(0),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _faqs[index].isExpanded = !isExpanded;
              });
            },
            children: _faqs.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      item.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    item.answer,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  String question;
  String answer;
  bool isExpanded;

  Item(this.question, this.answer, {this.isExpanded = false});
}


