import 'package:flutter/material.dart';

enum TLSVersion {
  tls12('TLS1.2'),
  tls13('TLS1.3');

  const TLSVersion(this.label);
  final String label;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLS Porting Mate',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'This is TLS Porting Mate for TLS packet analysis'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TLSVersion? tlsVersion;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),      
      body: Container(
        margin: const EdgeInsets.all(10.0),
        // color: Colors.cyan, //for layout test
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropdownMenuExample(),
            DropdownMenu<TLSVersion>(
              initialSelection: TLSVersion.tls12,
              // controller: colorController,
              // requestFocusOnTap is enabled/disabled by platforms when it is null.
              // On mobile platforms, this is false by default. Setting this to true will
              // trigger focus request on the text field and virtual keyboard will appear
              // afterward. On desktop platforms however, this defaults to true.
              // requestFocusOnTap: true,
              label: const Text('TLS version'),
              onSelected: (TLSVersion? ver) {
                setState(() {
                  tlsVersion = ver;
                });
              },
              dropdownMenuEntries: TLSVersion.values
                  .map<DropdownMenuEntry<TLSVersion>>(
                      (TLSVersion ver) {
                return DropdownMenuEntry<TLSVersion>(
                  value: ver,
                  label: ver.label,
                );
              }).toList(),
            ),
            Row(
              children: [
                Text('PSK:  '),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'PSK Label',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter PSK in Hexadecimal',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('x509: '),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Private Key',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Client Certificate',
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Client                                               Server'),
              ],
            ),
            if (tlsVersion == TLSVersion.tls12)
              Text('TLS 1.2  ~~~')
            else if (tlsVersion == TLSVersion.tls13)
              Text('TLS 1.3 is not yet supported')
            else
              Text('No TLS Version selected'),
          ],
        ),
      ),
    );
  }
}


// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Client'),
//                 Text('Server'),
//               ],
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 DropdownMenuExample(),
//                 DropdownMenuExample(),
//               ],
//             ),
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});

//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }

// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   String dropdownValue = listTlsVersion.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu<String>(
//       initialSelection: listTlsVersion.first,
//       onSelected: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       dropdownMenuEntries: listTlsVersion.map<DropdownMenuEntry<String>>((String value) {
//         return DropdownMenuEntry<String>(value: value, label: value);
//       }).toList(),
//     );
//   }
// }