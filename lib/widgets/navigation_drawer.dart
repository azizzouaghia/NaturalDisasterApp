import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:first_app/auth_provider.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appAuthProvider =
        Provider.of<AppAuthProvider>(context, listen: false);

    return Drawer(
      width: 280,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context, appAuthProvider),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, AppAuthProvider appAuthProvider) =>
      Container(
        color: AppColors.font,
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 12, bottom: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  "https://media.shafaq.com/media/arcella/1697820719299.jpeg"),
            ),
            SizedBox(height: 10),
            Text(
              appAuthProvider.username, // Access user's username
              style: TextStyle(color: AppColors.white),
            ),
            Text(
              appAuthProvider.user?.email ??
                  "", // Access user's email if needed
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //dashboard tile
            ListTile(
              leading: const Icon(Icons.home_outlined, color: AppColors.font),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            //earthquake tile
            ListTile(
              leading: const Icon(Icons.search_outlined, color: AppColors.font),
              title: const Text("Search Earthquake"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/search");
              },
            ),
            //air pollution tile
            ListTile(
              leading: const Icon(Icons.air_outlined, color: AppColors.font),
              title: const Text("Air Pollution"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            //flood tile
            ListTile(
              leading:
                  const Icon(Icons.tsunami_outlined, color: AppColors.font),
              title: const Text("Tsunami"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            //wildfire tile
            ListTile(
              leading: const Icon(Icons.forest_outlined, color: AppColors.font),
              title: const Text("Wildfire"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            const Divider(),
            //settings tile
            ListTile(
              leading:
                  const Icon(Icons.settings_outlined, color: AppColors.font),
              title: const Text("Settings"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/settings");
              },
            ),
            //logout tile
            ListTile(
              leading: const Icon(Icons.logout_outlined, color: AppColors.font),
              title: const Text("Logout"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
            //about tile
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppColors.font),
              title: const Text("About"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/about");
              },
            ),
          ],
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
