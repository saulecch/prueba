import 'package:flutter/material.dart';
import 'package:prueba/Utils/database.dart';
import 'package:prueba/Utils/validator.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode companyFocusNode;
  final FocusNode ageFocusNode;
  final String currentName;
  final String currentCompany;
  final String currentAge;
  final String documentId;

  EditItemForm(
      {Key? key,
      required this.nameFocusNode,
      required this.companyFocusNode,
      required this.ageFocusNode,
      required this.currentName,
      required this.currentCompany,
      required this.currentAge,
      required this.documentId})
      : super(key: key);

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  // final _editItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  late TextEditingController _nameController;
  late TextEditingController _companyController;
  late TextEditingController _ageController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentName);
    _companyController = TextEditingController(text: widget.currentCompany);
    _ageController = TextEditingController(text: widget.currentAge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              focusNode: widget.nameFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateField(
                value: value.toString(),
              ),
              decoration: InputDecoration(
                label: Text('Nombre'),
                hintText: 'Ingrese un nombre',
              ),
            ),
            TextFormField(
              controller: _companyController,
              focusNode: widget.companyFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateField(
                value: value.toString(),
              ),
              decoration: InputDecoration(
                label: Text('Company'),
                hintText: 'Ingrese company',
              ),
            ),
            TextFormField(
              controller: _ageController,
              focusNode: widget.ageFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateField(
                value: value.toString(),
              ),
              decoration: InputDecoration(
                label: Text('Edad'),
                hintText: 'Ingrese edad',
              ),
            ),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isProcessing = true;
                        });
                        await Database.updateItem(
                            full_name: _nameController.text,
                            company: _companyController.text,
                            age: _ageController.text,
                            docId: widget.documentId);
                        setState(() {
                          _isProcessing = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Actualizar'),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
