import 'package:flutter/material.dart';

class ReportProduct extends StatefulWidget {
  static const routeName = "/report-product";
  const ReportProduct({Key? key}) : super(key: key);

  @override
  State<ReportProduct> createState() => _ReportProductState();
}

class _ReportProductState extends State<ReportProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Item"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
                left: 14.0, right: 14.0, top: 100.0, bottom: 8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter a report"),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              textInputAction: TextInputAction.done,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                print("s");
              },
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
