import 'package:ccms/entities/document_model.dart';
import 'package:ccms/main.dart';
import 'package:ccms/providers/doc_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentCollectionDialogBox extends ConsumerStatefulWidget {
  const DocumentCollectionDialogBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocumentCollectionDialogBoxState();
}

class _DocumentCollectionDialogBoxState
    extends ConsumerState<DocumentCollectionDialogBox> {
  TextEditingController? _docController;
  TextEditingController? _yearController;
  FocusNode? _focusnod;

  @override
  void initState() {
    super.initState();
    _docController = TextEditingController();
    _yearController = TextEditingController();
    _focusnod = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusnod!.dispose();
  }

  int selectedBookValue = 1;
  bool isYearCorrect = false;
  String? docWithYearAndBook;
  String? collectedDoc;
  String? docError;

  bool checkYear(String year) {
    bool isCorrect;
    int nYear = int.tryParse(year) ?? 0;
    int currentYear = DateTime.now().year;
    if (nYear < 1800 || nYear > currentYear) {
      isCorrect = true;
    } else {
      isCorrect = false;
    }
    return isCorrect;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Document Number'),
      content: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //-------- Document field
              TextField(
                controller: _docController,
                decoration: InputDecoration(
                    labelText: 'Document No',
                    errorText: docError != null ? 'Invalid Document' : null),
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      docError = null;
                    });
                    collectedDoc = value;
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[gGfF0-9]')),
                  LengthLimitingTextInputFormatter(6)
                ],
              ),
              const SizedBox(height: 10),
              // ------------------- year field
              TextField(
                onChanged: (value) {
                  if (checkYear(value)) {
                    setState(() {
                      isYearCorrect = true;
                    });
                    _focusnod!.requestFocus();
                  } else {
                    setState(() {
                      isYearCorrect = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Year',
                  errorText: isYearCorrect ? 'Invalid year' : null,
                ),
                onEditingComplete: () {
                  if (!isYearCorrect) {
                    _focusnod!.requestFocus();
                  }
                  // print(_yearController!.text);
                },
                onSubmitted: (value) {
                  // print('completed');
                  // print(_yearController!.text);
                  if (_yearController!.text.isEmpty &&
                      !checkYear(_docController!.text)) {
                    setState(() {
                      isYearCorrect = false;
                    });
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(4)
                ],
                controller: _yearController,
              ),

              // ---------------bood number
              // const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('Book No'),
                  const SizedBox(width: 20),
                  DropdownButton(
                    value: selectedBookValue,
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        selectedBookValue = value!;
                      });
                    },
                    items: <int>[1, 2, 3, 4]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(value.toString()),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_docController!.text.isEmpty) {
              setState(() {
                docError = 'Invalid Document';
              });
              _focusnod!.requestFocus();
            } else if (isYearCorrect && _docController!.text.isNotEmpty) {
              _focusnod!.requestFocus();
            } else {
              String doc = _docController!.text;
              String book = selectedBookValue.toString();
              String year = _yearController!.text;
              int id = int.parse(doc + book + year);
              print('id is $id');
              Document collectedDoc =
                  Document(numner: doc, year: year, book: book, id: id);
              databox.addDocument(doc: collectedDoc);
              ref.read(docAddProvider.notifier).addDoc(collectedDoc);
              _docController!.clear();
              _yearController!.clear();
            }

            // Process the collected input data
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
