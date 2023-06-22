import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_invoice/model/invoice.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
      (await rootBundle.load("assets/technical_logo.png"))
          .buffer
          .asUint8List());
  pdf.addPage(Page(build: (context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text("Attention to: ${invoice.customer}"),
            Text(invoice.address)
          ], crossAxisAlignment: CrossAxisAlignment.start),
          SizedBox(
            height: 150,
            width: 150,
            child: Image(imageLogo),
          ),
        ],
      ),
      Container(height: 50),
      Table(border: TableBorder.all(color: PdfColors.black), children: [
        TableRow(children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Item",
                  style: Theme.of(context).header4,
                  textAlign: TextAlign.center)),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Price",
                  style: Theme.of(context).header4,
                  textAlign: TextAlign.center))
        ]),
        ...invoice.items.map((e) => TableRow(children: [
              Expanded(child: paddedText(e.description, align: TextAlign.left)),
              Expanded(
                  child: paddedText(
                "\$ ${e.cost.toStringAsFixed(2)}",
              ))
            ])),
        TableRow(children: [
          paddedText("Tax", align: TextAlign.right),
          paddedText(
            "\$ ${(invoice.totalCost() * 0.1).toStringAsFixed(2)}",
          )
        ]),
        TableRow(
          children: [
            paddedText("TOTAL", align: TextAlign.right),
            paddedText("\$ ${(invoice.totalCost() * 1.1).toStringAsFixed(2)}")
          ],
        )
      ]),
      Padding(
          child: Text("THANK YOU FOR YOUR CUSTOM!",
              style: Theme.of(context).header2),
          padding: const EdgeInsets.all(20.0)),
      Text(
          "Please forward the below slip to your accounts payable department."),
      Divider(height: 1, borderStyle: BorderStyle.dashed),
      Container(height: 50),
      Table(border: TableBorder.all(color: PdfColors.black), children: [
        TableRow(
            children: [paddedText("Account number"), paddedText("622123566")]),
        TableRow(children: [
          paddedText("Account name"),
          paddedText("Tiger Park Limited")
        ]),
        TableRow(children: [
          paddedText("Total amount to be paid"),
          paddedText("\$ ${(invoice.totalCost() * 1.1).toStringAsFixed(2)}")
        ])
      ]),
      Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
              "Please ensure all cheques are payable to Tiger Park Limited",
              style: Theme.of(context)
                  .header3
                  .copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center))
    ]);
  }));
  return pdf.save();
}

Widget paddedText(final String text,
        {final TextAlign align = TextAlign.left}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text, textAlign: align),
    );
