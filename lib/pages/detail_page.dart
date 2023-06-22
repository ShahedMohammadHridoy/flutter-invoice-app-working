import 'package:flutter/material.dart';
import 'package:pdf_invoice/model/invoice.dart';
import 'package:pdf_invoice/pages/pdf_preview_page.dart';

class DetailPage extends StatelessWidget {
  final Invoice invoice;

  const DetailPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PdfPreviewPage(
              invoice: invoice,
            ),
          ));
        },
      ),
      appBar: AppBar(title: Text(invoice.name)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    'Customer',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  Expanded(
                      child: Text(
                    invoice.customer,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    "Invoice Item",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ...invoice.items.map((e) => ListTile(
                        title: Text(e.description),
                        trailing: Text(e.cost.toStringAsFixed(2)),
                      )),
                  DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.headlineMedium,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Total"),
                          Text(invoice.totalCost().toStringAsFixed(2))
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
