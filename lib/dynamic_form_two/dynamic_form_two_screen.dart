import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form_demo/dynamic_form_two/view_model/dynamic_form_two_view_model.dart';
import 'package:provider/provider.dart';

class DynamicFormTwoScreen extends StatefulWidget {
  const DynamicFormTwoScreen({super.key});

  @override
  _DynamicFormTwoScreenState createState() => _DynamicFormTwoScreenState();
}

class _DynamicFormTwoScreenState extends State<DynamicFormTwoScreen> {
  late DynamicFormTwoViewModel _viewModel;

  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.loadFormFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<DynamicFormTwoViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Dynamic Form Two"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ..._viewModel.fields.map<Widget>((field) {
                switch (field['type']) {
                  case 'text':
                  case 'email':
                  case 'password':
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: field['label'],
                          hintText: field['placeholder'],
                        ),
                        keyboardType: field['type'] == 'email'
                            ? TextInputType.emailAddress
                            : field['type'] == 'password'
                                ? TextInputType.text
                                : TextInputType.text,
                        obscureText: field['type'] == 'password',
                        onSaved: (value) {
                          _viewModel.formData[field['key']] = value;
                        },
                      ),
                    );
                  case 'dropdown':
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: field['label'],
                        ),
                        items:
                            (field['options'] as List<dynamic>).map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _viewModel.formData[field['key']] = value;
                          });
                        },
                      ),
                    );
                  case 'checkbox':
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          _viewModel.isChecked = !_viewModel.isChecked;
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _viewModel.isChecked
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                field['label'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  case 'radio':
                    return Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(field['label']),
                          ...((field['options'] as List<dynamic>).map((option) {
                            return RadioListTile<String>(
                              title: Text(option),
                              value: option,
                              groupValue: _viewModel.formData[field['key']],
                              onChanged: (value) {
                                setState(() {
                                  _viewModel.formData[field['key']] = value;
                                });
                              },
                            );
                          }).toList())
                        ],
                      ),
                    );
                  default:
                    return Container();
                }
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    print('Form Data: ${_viewModel.formData}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
