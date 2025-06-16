import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lab/models/document_model.dart';
import 'package:flutter_lab/utils/validators.dart';
import 'dart:io';
import '../services/api_service.dart';

class DocumentForm extends StatefulWidget {
  final Document? document;
  final Function onSubmitted;

  const DocumentForm({Key? key, this.document, required this.onSubmitted})
    : super(key: key);

  @override
  _DocumentFormState createState() => _DocumentFormState();
}

class _DocumentFormState extends State<DocumentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  File? _selectedFile;
  bool _isLoading = false;
  bool _isEditMode = false;
  String? _filePathFromServer;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.document != null;
    _titleController = TextEditingController(
      text: widget.document?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.document?.description ?? '',
    );
    _filePathFromServer = widget.document?.filePath;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _filePathFromServer =
              null; // Reset server path if new file is selected
        });
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('File picker error: $e')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isEditMode && widget.document != null) {
        // Update existing document
        final updatedDocument = Document(
          id: widget.document!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          filePath: _filePathFromServer ?? widget.document!.filePath,
          fileType: widget.document!.fileType,
          createdAt: widget.document!.createdAt,
        );

        await ApiService.updateDocument(updatedDocument);
      } else {
        // Create new document
        if (_selectedFile == null) {
          throw Exception('Please select a file');
        }

        await ApiService.uploadDocument(
          title: _titleController.text,
          description: _descriptionController.text,
          file: _selectedFile!,
        );
      }

      widget.onSubmitted();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditMode
                ? 'Document updated successfully'
                : 'Document uploaded successfully',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Document' : 'Upload Document'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: Validators.validateDescription,
              ),
              const SizedBox(height: 16),
              if (!_isEditMode || _selectedFile != null)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _pickFile,
                      child: const Text('Select File'),
                    ),
                    const SizedBox(height: 8),
                    if (_selectedFile != null)
                      Text(
                        'Selected file: ${_selectedFile!.path.split('/').last}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedFile != null
                          ? 'File size: ${(_selectedFile!.lengthSync() / (1024 * 1024)).toStringAsFixed(2)} MB'
                          : 'Max file size: 8MB',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    if (_selectedFile != null)
                      Text(
                        Validators.validateFile(_selectedFile) ??
                            'File is valid',
                        style: TextStyle(
                          color: Validators.validateFile(_selectedFile) == null
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                  ],
                ),
              if (_isEditMode &&
                  _selectedFile == null &&
                  _filePathFromServer != null)
                Column(
                  children: [
                    const Text('Current file:'),
                    Text(
                      _filePathFromServer!.split('/').last,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: _pickFile,
                      child: const Text('Change file'),
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(_isEditMode ? 'Update Document' : 'Upload Document'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
