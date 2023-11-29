import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../../../models/custom_order/invoice.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to: ${invoice.customer}"),
                    Text("Phone: ${invoice.phone}"),
                    Text("Address: ${invoice.address}"),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),

              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),

                TableRow(
                  children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost()).toStringAsFixed(2)}')],
                )
              ],
            ),

          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
