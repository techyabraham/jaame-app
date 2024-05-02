import '../../../../backend/download_file.dart';
import '../../../../utils/basic_screen_imports.dart';




class ImageViewer extends StatelessWidget with DownloadFile{
  const ImageViewer({super.key, required this.imageUrl, required this.name});

  final String imageUrl, name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: InteractiveViewer(

            child: Image.network(
              imageUrl, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.download, color: CustomColor.whiteColor),
        onPressed: ()async{
            await downloadFile(url: imageUrl, name: name);
        },
      ),
    );
  }

}