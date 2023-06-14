import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    String _initialValue = "am";


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
             SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                          value: 'am',
                          child: Text(
                            'አማርኛ',
                            style: TextStyle(color:  Color.fromARGB(255, 15, 23, 43)),
                          ),
                        ),
                        DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              "ENGLISH",
                              style: TextStyle(color:  Color.fromARGB(255, 15, 23, 43)),
                            )),
                        // DropdownMenuItem(
                        //   value: "oro",
                        //   child: Text(
                        //     "Oro",
                        //     style: TextStyle(color: Colors.blue),
                        //   ),
                        // )
                      ],
                      value: _initialValue,
                      onChanged: (value) async {
                        setState(() {
                          _initialValue = value.toString();
                        });
                        await context.setLocale(Locale(value.toString()));
                      },
                    ),
                  ),
                    const SizedBox(height: 30),
            
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: SettingsPage(),
//   ));
// }
