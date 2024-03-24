import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

List<String> _typesList = [
  'food',
  'transportation',
  'entertainment',
  'clothing',
  'bills',
  'shopping',
  'education',
  'other',
];

class AddExpenseScreen extends StatefulWidget {

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  String uniqueId = Uuid().v4();

  String _name = '', _description = '', _type = '', _paidmethod = '';

  DateTime _selectedDate = DateTime.now();

  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Select Date and Time',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _amount = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 20),
                Text('Type of Expenses', style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _typesList.map((type) {
                    return RadioListTile<String>(
                      title: Text('$type'),
                      value: '$type',
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Paid Method'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a paid method';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _paidmethod = value!;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          print('formkey: ${_formKey.currentState}');
                          print('Date: $_selectedDate');
                          print('Type: $_type');
                          print('Amount: $_amount');
                          print('Description: $_description');
                          print('Paid Method: $_paidmethod');
                          print('Name: $_name');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5.0), // Rounded corners
                        ),
                      ),
                      child: Text('Submit', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = selectedDateTime;
        });
        print('Selected date and time: $selectedDateTime');
      }
    }
  }
}
