import 'package:flutter/material.dart';
import 'package:pdf_invoice/model/invoice.dart';

import 'detail_page.dart';

class Invoices extends StatelessWidget {
  const Invoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoices = [
      Invoice(
          customer: "Shahed",
          address: "Dhaka",
          items: [
            LineItem(description: "Mouse", cost: 400.00),
            LineItem(description: "Keyboard", cost: 600),
            LineItem(description: "Monitor", cost: 4000.00)
          ],
          name: 'Create and deploy software package'),
      Invoice(
          customer: "Joy",
          address: "Pallabi, Mirpur, Dhaka",
          items: [
            LineItem(description: "Speaker", cost: 400.00),
            LineItem(description: "Microphone", cost: 700),
          ],
          name: "Provide remote support after lunch"),
      Invoice(
          customer: "Amin",
          address: "Kazipara, Mirpur, Dhaka",
          items: [LineItem(description: "Teamviewer charge", cost: 500)],
          name: "Create software to teach robots how to dance")
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ...invoices.map((e) => ListTile(
                title: Text(e.name),
                subtitle: Text(e.customer),
                trailing: Text('\$ ${e.totalCost().toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => DetailPage(invoice: e)));
                },
              ))
        ],
      ),
    );
  }
}
