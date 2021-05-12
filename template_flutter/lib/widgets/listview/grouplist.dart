import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List _elements = [
    {
      'id': 13256,
      'createdDate': '2021-04-26T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Paid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Paid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-26T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Paid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-26T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Paid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-26T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Paid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-25T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
    {
      'id': 13256,
      'createdDate': '2021-04-26T09:44:50.784987',
      'status': "Completed",
      'statusPaid': 'Unpaid',
      'address': 'Del Sole x 2 , Tiramisu x 1, Sandw...',
      'price': 1000000,
      'statusOrder': 'Delivery'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: GroupedListView<dynamic, String>(
          elements: _elements,
          padding: EdgeInsets.only(bottom: 10),
          groupBy: (element) {
            DateTime group = DateTime.parse(element["createdDate"]);
            var date = DateFormat('E, dd MMM').format(group);
            return " $date";
          },
          order: GroupedListOrder.DESC,
          groupSeparatorBuilder: (String value) => Container(
            height: 50,
            color: Color(0xFFF6F6F6),
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF333333),
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  value,
                ),
              ],
            ),
          ),
          itemBuilder: (c, element) {
            return ListTile(
              title: Text(element["id"].toString()),
              subtitle: Text(element["address"]),
            );
          },
        ),
      ),
    );
  }
}
