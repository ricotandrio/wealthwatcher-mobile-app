import 'package:flutter/material.dart';
import 'package:wealthwatcher/utils/date_format.dart';
import 'package:wealthwatcher/utils/icon_category.dart';

class DashboardScreen extends StatefulWidget {
  final List<dynamic> listofExpenses;

  const DashboardScreen({Key? key, required this.listofExpenses})
      : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add new expense
          Navigator.pushNamed(context, '/expense');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rp. 342323,-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Total Expenses',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Rp. 342323,-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Total Income',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Rp. 342323,-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Expenses',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  // create list of expenses
                  Column(
                    children: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.listofExpenses.length,
                          itemBuilder: (BuildContext context, int index) {
                            final expense = widget.listofExpenses[index];

                            return ListTile(
                              shape: ShapeBorder.lerp(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  0.5),
                              leading: Icon(IconCategory.getCategoryIcon(
                                  expense['type'])),
                              title: Text(expense['name']),
                              subtitle: Text(expense['amount'].toString()),
                              trailing: Text(DateFormat.format(
                                  DateTime.parse(expense['date']))),
                            );
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
