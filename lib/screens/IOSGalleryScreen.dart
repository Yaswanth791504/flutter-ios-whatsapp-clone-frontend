import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:textz/Api/sockets.dart';
import 'package:textz/components/IOSCircularProgressIndicator.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSGalleryImageViewer.dart';

class IOSGalleryScreen extends StatefulWidget {
  const IOSGalleryScreen(
      {super.key, required this.phoneNumber, required this.socketInstance, required this.updateChats});
  final updateChats;
  final String phoneNumber;
  final IosSocket? socketInstance;

  @override
  State<IOSGalleryScreen> createState() => _IOSGalleryScreenState();
}

class _IOSGalleryScreenState extends State<IOSGalleryScreen> {
  List<AssetEntity> assets = [];

  Future<void> _fetchImages() async {
    final albums = await PhotoManager.getAssetPathList();
    if (albums.isNotEmpty) {
      assets = await albums[0].getAssetListRange(start: 0, end: 1000000);
      setState(() {});
    }
  }

  @override
  void initState() {
    _fetchImages();
    super.initState();
  }

  void _modelSheetImageViewer(context, file, phoneNumber, socket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            builder: (ctx, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf0eef2),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: IOSGalleryImageViewer(
                      file: file, phoneNumber: phoneNumber, socketInstance: socket, updateChats: widget.updateChats),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0eef2),
      appBar: AppBar(
        title: const Text(
          'Gallery',
          style: TextStyle(
            color: blueAppColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: blueAppColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0), // Add padding around the grid
        child: GridView.builder(
          itemCount: assets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0, // Vertical spacing between items
            crossAxisSpacing: 4.0, // Horizontal spacing between items
          ),
          itemBuilder: (_, index) {
            return FutureBuilder<Uint8List?>(
              future: assets[index].thumbnailData,
              builder: (_, snapshot) {
                final bytes = snapshot.data;
                if (bytes == null) return const IOSCircularProgressIndicator();
                return GestureDetector(
                  onTap: () {
                    _modelSheetImageViewer(context, assets[index].file, widget.phoneNumber, widget.socketInstance);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (builder) => IOSGalleryImageViewer(
                    //         file: assets[index].file,
                    //         phoneNumber: widget.phoneNumber,
                    //         socketInstance: widget.socketInstance),
                    //   ),
                    // );
                  },
                  child: Builder(builder: (context) {
                    if (assets[index].type == AssetType.video) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Image.memory(
                              bytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Icon(
                              Icons.video_call,
                              color: blueAppColor,
                              size: 40,
                            ),
                          )
                        ],
                      );
                    }
                    return Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    );
                  }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
