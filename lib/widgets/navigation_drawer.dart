import 'package:first_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget implements PreferredSizeWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            buildHeader(context),
            const SizedBox(height: 20),
            buildMenuItem(context, "Dashboard", Icons.home_outlined, "/home"),
            buildMenuItem(context, "Search Earthquake", Icons.search_outlined, "/search"),
            buildMenuItem(context, "Air Pollution", Icons.air_outlined, "/home"),
            buildMenuItem(context, "Tsunami", Icons.tsunami_outlined, "/home"),
            buildMenuItem(context, "Wildfire", Icons.forest_outlined, "/home"),
            const Divider(),
            buildMenuItem(context, "Settings", Icons.settings_outlined, "/settings"),
            buildMenuItem(context, "Logout", Icons.logout_outlined, "/login"),
            buildMenuItem(context, "About", Icons.info_outline, "/about"),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    color: AppColors.font,
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top + 12,
      bottom: 12,
    ),
    child: const Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: NetworkImage(
            "https://media.shafaq.com/media/arcella/1697820719299.jpeg",
          ),
        ),
        SizedBox(height: 10),
        Text("Aziz Zouaghia", style: TextStyle(color: AppColors.white)),
        Text("azizzouaghia@gmail.com", style: TextStyle(color: AppColors.white)),
      ],
    ),
  );

  Widget buildMenuItem(BuildContext context, String title, IconData icon, String route) => ListTile(
    leading: Icon(icon, color: AppColors.font),
    title: Text(title),
    onTap: () {
      Navigator.of(context).pushReplacementNamed(route);
    },
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
