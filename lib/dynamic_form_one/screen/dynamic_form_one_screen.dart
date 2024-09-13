import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/dynamic_form_one_view_model.dart';
import '/utils/validator_util.dart' as validator;
import '../model/form_model.dart';

class DynamicFormOneScreen extends StatefulWidget {
  const DynamicFormOneScreen({super.key});

  @override
  State<DynamicFormOneScreen> createState() => _DynamicFormOneScreenState();
}

class _DynamicFormOneScreenState extends State<DynamicFormOneScreen> {
  late DynamicFormOneViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.getFromJson(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<DynamicFormOneViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Dynamic Form One"),
      ),
      body: SingleChildScrollView(
        child: _viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _viewModel.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics:const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        //  physics: const NeverScrollableScrollPhysics(),
                          itemCount: _viewModel.formResponse.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return
                            Column(
                              children: [
                               const SizedBox(height: 20,),
                                myFormType(index),
                              ],
                            );

                          }),

                      Center(
                        child: TextButton(
                            onPressed: () {
                              if (_viewModel.formKey.currentState?.validate() ==
                                  false) return;
                            },
                            child: const Text('submit')),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  myFormType(index) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
   //   physics: const ClampingScrollPhysics(),
      itemCount: _viewModel.formResponse[index].fields!.length,
      shrinkWrap: true,

      itemBuilder: (context, innerIndex) {
        return _viewModel.formResponse[index].fields![innerIndex].fieldType ==
                "DatetimePicker"
            ? myDatePicker()
            : _viewModel.formResponse[index].fields![innerIndex].fieldType ==
                    "TextInput"
                ? TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: _viewModel
                          .formResponse[index].fields![innerIndex].label,
                    ),
                  )
                : _viewModel.formResponse[index].fields![innerIndex]
                            .fieldType ==
                        "SelectList"
                    ? dropDownWidget(_viewModel
                        .formResponse[index].fields![innerIndex].options)
                    : _viewModel.formResponse[index].fields![innerIndex]
                                .fieldType ==
                            "SwitchInput"
                        ? SwitchListTile(
                            value: _viewModel.switchValue,
                            title: Text(_viewModel.formResponse[index]
                                .fields![innerIndex].label!),
                            onChanged: (value) {
                              setState(() {
                                _viewModel.switchValue = value;
                              });
                            })
                        : _viewModel.formResponse[index].fields![innerIndex]
                                    .fieldType ==
                                "SelectRadio"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    itemCount: _viewModel.formResponse[index]
                                        .fields![innerIndex].options?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) {
                                      return Card(
                                        elevation: 3,
                                        shadowColor: const Color(0xFFAAAAAA),
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 30, top: 15),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            setState(() {
                                              _viewModel.groupValue = _viewModel
                                                  .formResponse[index]
                                                  .fields![innerIndex]
                                                  .options![index2]
                                                  .index!;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Row(
                                                children: <Widget>[
                                                  Radio(
                                                    groupValue:
                                                        _viewModel.groupValue,
                                                    //  value: 1,
                                                    value: _viewModel
                                                        .formResponse[index]
                                                        .fields![innerIndex]
                                                        .options![index2]
                                                        .index,
                                                    onChanged: (index2) {
                                                      setState(() {
                                                        _viewModel.groupValue =
                                                            _viewModel
                                                                .formResponse[
                                                                    index!]
                                                                .fields![
                                                                    innerIndex]
                                                                .options![
                                                                    index2!]
                                                                .index!;
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                      child: Text(_viewModel
                                                          .formResponse[index]
                                                          .fields![innerIndex]
                                                          .options![index2]
                                                          .optionLabel!)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      //  ),;
                                    }),
                              )
                            : _viewModel.formResponse[index].fields![innerIndex]
                                        .fieldType ==
                                    "CheckBoxInput"
                                ?
                                InkWell(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      _viewModel.isChecked =
                                          !_viewModel.isChecked;
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          _viewModel.isChecked
                                              ? Icons.check_box_rounded
                                              : Icons
                                                  .check_box_outline_blank_rounded,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _viewModel.formResponse[index!]
                                                .fields![innerIndex].label!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : _viewModel.formResponse[index]
                                            .fields![innerIndex].fieldType ==
                                        "EmailInput"
                                    ? TextFormField(
                                        validator: validator.emailValidator,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          hintText: _viewModel
                                              .formResponse[index]
                                              .fields![innerIndex]
                                              .label,
                                        ),
                                      )
                                    : _viewModel
                                                .formResponse[index]
                                                .fields![innerIndex]
                                                .fieldType ==
                                            "PasswordInput"
                                        ? TextFormField(
                                            validator:
                                                validator.passwordValidator,
                                            obscureText:
                                                _viewModel.obscurePassword,
                                            decoration: InputDecoration(
                                              suffixIcon:
                                                  _buildPasswordVisibilityIcon(),
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: _viewModel
                                                  .formResponse[index]
                                                  .fields![innerIndex]
                                                  .label,
                                            ),
                                          )
                                        : Text('other type');
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
    );
  }

  Widget myDatePicker() {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _selectDate(context);
        },
        child: AbsorbPointer(
          child: TextFormField(
            onChanged: (value) {},
            controller: _viewModel.dateController,
            obscureText: false,
            cursorColor: Theme.of(context).primaryColor,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14.0,
            ),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              focusColor: Theme.of(context).primaryColor,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              labelText: "Date select",
              prefixIcon: const Icon(
                Icons.calendar_today,
                size: 18,
              ),
            ),
          ),
        ));
  }

  DateTime selectedDate = DateTime.now();

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        var date = DateTime.parse(picked.toString());
        var formatted = "${date.year}-${date.month}-${date.day}";
        _viewModel.dateController = TextEditingController();
        _viewModel.dateController =
            TextEditingController(text: formatted.toString());
      });
    }
  }

  dropDownWidget(List<Options>? items) {
    return DropdownButtonFormField<Options>(
      // Initial Value
      value: _viewModel.dropdownvalue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: items!.first.optionLabel!,
      ),
      borderRadius: BorderRadius.circular(10),

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((Options items) {
        return DropdownMenuItem<Options>(
          value: items,
          child: Text(items.optionValue!),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (newValue) {
        setState(() {
          _viewModel.dropdownvalue = newValue!;
        });
      },
    );
  }

  Widget _buildPasswordVisibilityIcon() {
    return IconButton(
      onPressed: _viewModel.onPasswordVisibilityTap,
      icon: Icon(
        _viewModel.obscurePassword
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        color: Colors.black,
        size: 18,
      ),
    );
  }
}
