import 'package:flutter/material.dart';
import 'package:prueba/utils/database.dart';
import 'package:prueba/widgets/edit_form.dart';

class EditScreen extends StatefulWidget {
  final String currentName;
  final String currentCompany;
  final String currentAge;
  final String documentId;

  EditScreen(
      {Key? key,
      required this.currentName,
      required this.currentCompany,
      required this.currentAge,
      required this.documentId})
      : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _companyFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _companyFocusNode.unfocus();
        _ageFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar'),
          actions: [
            IconButton(
              onPressed: () async {
                await Database.deleteItem(
                  docId: widget.documentId,
                );
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: SafeArea(
          child: EditItemForm(
              nameFocusNode: _nameFocusNode,
              companyFocusNode: _companyFocusNode,
              ageFocusNode: _ageFocusNode,
              currentName: widget.currentName,
              currentCompany: widget.currentCompany,
              currentAge: widget.currentAge,
              documentId: widget.documentId),
        ),
      ),
    );
  }
}
