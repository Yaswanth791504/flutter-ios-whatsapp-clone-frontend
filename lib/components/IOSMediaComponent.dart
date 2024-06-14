import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:textz/Api/sockets.dart';
import 'package:textz/components/IOSCamera.dart';
import 'package:textz/components/IOSListTile.dart';
import 'package:textz/main.dart';
import 'package:textz/screens/IOSGalleryScreen.dart';

class IOSMediaComponent extends StatelessWidget {
  const IOSMediaComponent(
      {super.key, required this.friendPhoneNumber, required this.socketInstance, required this.updateChats});
  final updateChats;
  final String friendPhoneNumber;
  final IosSocket? socketInstance;

  Future<void> _requestMediaPermission(BuildContext context) async {
    final state = await PhotoManager.requestPermissionExtend();
    if (state.isAuth) {
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
              initialChildSize: 0.93,
              builder: (ctx, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFf0eef2),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: IOSGalleryScreen(
                        phoneNumber: friendPhoneNumber, socketInstance: socketInstance, updateChats: updateChats),
                  ),
                );
              },
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Media permission is required to access the gallery.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              // _requestMediaPermission(context);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Card(
                child: ListView(
                  addRepaintBoundaries: false,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  shrinkWrap: true,
                  children: [
                    IOSListTile(
                        icon: Icons.camera_alt_outlined,
                        title: "Camera",
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const IOSCamera()));
                        }),
                    IOSListTile(
                      icon: Icons.image_outlined,
                      title: "Photos & Video Library",
                      onPressed: () => _requestMediaPermission(context),
                    ),
                    const IOSListTile(icon: Icons.note_add_outlined, title: "Document"),
                    const IOSListTile(icon: Icons.location_on_outlined, title: "Location"),
                    const IOSListTile(icon: Icons.contact_page_outlined, title: "Contact"),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Card(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: blueAppColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
