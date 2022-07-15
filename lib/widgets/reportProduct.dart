import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentnow/widgets/rentItems.dart';

import '../providers/items.dart';

class ReportProduct extends StatefulWidget {
  static const routeName = "/report-product";
  const ReportProduct({Key? key}) : super(key: key);

  @override
  State<ReportProduct> createState() => _ReportProductState();
}

class _ReportProductState extends State<ReportProduct> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _reportData = {
    'report': '',
    'itemImage': "",
    'itemId': '',
    'itemOwnerEmail': '',
  };
  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      setState(() {
        _isLoading = true;
      });
      var data = Provider.of<Items>(context, listen: false);
      await data.reportPorduct(
          _reportData["report"]!,
          _reportData["itemImage"]!,
          _reportData["itemId"]!,
          _reportData["itemOwnerEmail"]!);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushNamed(RentItem.routeName);
    } catch (error) {
      print("Some thing went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Item"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 14.0, right: 14.0, top: 100.0, bottom: 8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Enter a report"),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Product Report";
                  }
                  return null;
                },
                onSaved: (value) {
                  final item = (ModalRoute.of(context)!.settings.arguments ??
                      <String, dynamic>{}) as Map;
                  final itemImage = item["image"];
                  _reportData["itemImage"] = itemImage!;
                  _reportData["itemId"] = item["itemID"];
                  _reportData["itemOwnerEmail"] = item['itemOwnerEmail'];
                  _reportData['report'] = value!;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: const Text("Submit"))
        ],
      ),
    );
  }
}
