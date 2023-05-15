import 'dart:developer';

import 'package:flutter/material.dart';

class DynamicFormPage extends StatefulWidget {
  const DynamicFormPage({super.key});

  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  final _formGlobal = GlobalKey<FormState>();

  final List<TextEditingController> listController = [];

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Form"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () => addNewField(),
        //   ),
        //   FilledButton(
        //     child: const Text("Submit"),
        //     onPressed: () => getTextFieldValues(),
        //   )
        // ],
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formGlobal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                child: const Text('Login'),
                onPressed: () {
                  // Validate & Submit the form
                  if (_formGlobal.currentState!.validate()) {
                    // Unfocus the Keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamicTextFieldListView() {
    final theme = Theme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: listController.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    key: ValueKey(index),
                    controller: listController[index],
                    decoration: const InputDecoration(
                      hintText: "Textfield",
                    ),
                  ),
                ),
                index != 0
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 5),
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: theme.colorScheme.error,
                            ),
                            onPressed: () => removeAddedField(index),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }

  addNewField() {
    setState(() {
      listController.add(TextEditingController());
    });
  }

  removeAddedField(int index) {
    setState(() {
      listController[index].clear();
      listController[index].text = '';
      listController.removeAt(index);
    });
  }

  getTextFieldValues() {
    if (_formGlobal.currentState!.validate()) {
      final finalData = {};

      for (var i = 0; i < listController.length; i++) {
        log(listController[i].text);
        finalData.addAll(
          {
            'index $i': listController[i].text,
          },
        );
      }

      log("finalData --> $finalData");
    }
  }
}
