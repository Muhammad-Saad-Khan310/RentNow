import 'package:flutter/material.dart';
import './categories_widgets.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final _form = GlobalKey<FormState>();
  // Widget presentText(String text) {
  //   return Column(
  //     children: [Text("Some text")],
  //   );
  // }
  InputDecoration _Decoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.blue,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(255, 255, 255, 100),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)));
  }

  int currentStep = 0;
  void _saveForm() {
    // This below line return boolean value
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      print("I am not excuting");
      return;
    }
    // _form.currentState!.save();
    // Provider.of<Items>(context, listen: false).addItem(_addItem);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Form(
        key: _form,
        child: Stepper(
          steps: [
            Step(
                isActive: currentStep >= 0,
                title: Text("Step1"),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: _Decoration("Product Title", Icons.add_box),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Product title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: _Decoration("Image Url", Icons.image),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please enter Product title";
                      //   }
                      //   return null;
                      // },
                    ),
                  ],
                )),
            Step(
                isActive: currentStep >= 1,
                title: Text("Step2"),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: _Decoration("Price", Icons.money),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Product title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: _Decoration("Phone Number", Icons.phone),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please enter Product title";
                      //   }
                      //   return null;
                      // },
                    ),
                  ],
                )),
            Step(
                isActive: currentStep >= 2,
                title: Text("Step3"),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: _Decoration("Address", Icons.house),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please enter Product title";
                      //   }
                      //   return null;
                      // },
                    ),
                    TextFormField(
                      decoration: _Decoration("Description", Icons.details),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onSaved: (value) {
                      //   _addItem = ProductItem(
                      //       id: "",
                      //       title: value!,
                      //       description: _addItem.description,
                      //       phoneNumber: _addItem.phoneNumber,
                      //       imageUrl: _addItem.imageUrl,
                      //       price: _addItem.price,
                      //       address: _addItem.address,
                      //       categoryId: _addItem.categoryId,
                      //       categoyTitle: selectedValue);
                      // },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please enter Product title";
                      //   }
                      //   return null;
                      // },
                    ),
                  ],
                )),
          ],
          onStepTapped: (int newIndex) {
            setState(() {
              currentStep = newIndex;
            });
          },
          currentStep: currentStep,
          onStepContinue: () {
            final isValid = _form.currentState!.validate();
            if (currentStep != 2 && isValid) {
              setState(() {
                currentStep += 1;
              });
            } else {
              _saveForm;
              print(isValid);
              print("dAta is send successfuly");
            }
          },
          onStepCancel: () {
            if (currentStep != 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
        ),
      ),
    );
  }
}
