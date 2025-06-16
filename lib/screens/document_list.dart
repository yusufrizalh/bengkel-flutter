import 'package:flutter/material.dart';
import 'package:flutter_lab/models/document_model.dart';
import 'package:flutter_lab/screens/document_form.dart';
import 'package:flutter_lab/screens/document_view.dart';

import '../services/api_service.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({Key? key}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  late Future<List<Document>> futureDocuments;

  @override
  void initState() {
    super.initState();
    futureDocuments = ApiService.getDocuments();
  }

  void _refreshDocuments() {
    setState(() {
      futureDocuments = ApiService.getDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshDocuments,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DocumentForm(onSubmitted: _refreshDocuments),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Document>>(
        future: futureDocuments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No documents found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Document document = snapshot.data![index];
              return ListTile(
                title: Text(document.title),
                subtitle: Text(
                  '${document.fileType} • ${document.createdAt.toString().substring(0, 10)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentForm(
                              document: document,
                              onSubmitted: _refreshDocuments,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        try {
                          await ApiService.deleteDocument(document.id!);
                          _refreshDocuments();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Document deleted successfully'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error deleting document: $e'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentView(document: document),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
