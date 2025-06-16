import 'package:flutter/material.dart';
import 'package:flutter_lab/models/document_model.dart';

class DocumentView extends StatelessWidget {
  final Document document;

  const DocumentView({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(document.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Uploaded on: ${document.createdAt.toString().substring(0, 10)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(height: 32),
            Text(
              document.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            if (document.fileType == 'image')
              Image.network(
                document.filePath,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.4,
                fit: BoxFit.cover,
              )
            else
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening PDF file...')),
                  );
                },
                child: const Text('View PDF File'),
              ),
          ],
        ),
      ),
    );
  }
}
