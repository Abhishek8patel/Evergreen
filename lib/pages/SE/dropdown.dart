import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final List<String> items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  final List<String> dropdownOptions = ['One', 'Two', 'Three', 'Four'];
  final Map<int, String> selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          trailing: DropdownButton<String>(
            value: selectedValues[index],
            hint: Text('Select'),
            onChanged: (String? newValue) {
              setState(() {
                selectedValues[index] = newValue!;
              });
            },
            items: dropdownOptions
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
