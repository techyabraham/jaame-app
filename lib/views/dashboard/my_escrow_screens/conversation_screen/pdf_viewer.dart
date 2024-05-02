import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';


import '../../../../backend/download_file.dart';
import '../../../../language/english.dart';
import '../../../../utils/custom_color.dart';
import '../../../../widgets/appbar/primary_appbar.dart';

class PDFViewer extends StatefulWidget with DownloadFile{
  final String pdfUrl, pdfName;

  const PDFViewer({super.key, required this.pdfUrl, required this.pdfName});

  @override
  PDFViewerState createState() => PDFViewerState();
}

class PDFViewerState extends State<PDFViewer> {
  late PDFViewController _pdfViewController;
  Uint8List? pdfData;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Strings.pdfViewer,
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Theme.of(context).primaryColor),
            onPressed: ()async{
              if(!_isLoading){
                await widget.downloadFile2(pdfData: pdfData!, name: widget.pdfName);
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CustomLoadingWidget())
          : PDFView(
        // filePath: _pdfViewController.,
        pdfData: pdfData,
        autoSpacing: true,
        pageSnap: true,
        swipeHorizontal: true,
        nightMode: false,
        onViewCreated: (PDFViewController pdfViewController) {
          setState(() {
            _pdfViewController = pdfViewController;
          });
        },
        onPageChanged: (pages, total) {
          setState(() {
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _pdfViewController.setPage(0);
                },
        child: const Icon(Icons.first_page, color: CustomColor.whiteColor),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final Uint8List data = response.bodyBytes;
    pdfData = data;

    setState(() {
      _isLoading = false;
    });
  }
}