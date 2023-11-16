import 'package:first_app/styles/app_colors.dart';
import 'package:first_app/widgets/bar_widget.dart';
import 'package:first_app/widgets/location_row.dart';
import 'package:first_app/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class SearchEarthquack extends StatefulWidget {
  const SearchEarthquack({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SearchEarthquackState createState() => _SearchEarthquackState();
}

class _SearchEarthquackState extends State<SearchEarthquack> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BarWidget(title: "Earthquack Search"),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          SizedBox(height: 20),
          LocationRow(),
          SizedBox(height: 10),
          SizedBox(height: 5),
          DatePicker(),
          SizedBox(height: 20),
          SearchResult(
            searchData: [
              {
                'location': 'near the coast of Libya',
                'date': '2023-04-02, 23:40:42'
              },
              {'location': 'siliana beach', 'date': '2023-11-15, 22:22:22'},
              {'location': 'Tokyo, Japan', 'date': '2023-05-12, 12:34:56'},
              {'location': 'Los Angeles, USA', 'date': '2023-06-23, 01:23:45'},
              {
                'location': 'Rio de Janeiro, Brazil',
                'date': '2023-07-04, 15:30:00'
              },
              {'location': 'Sydney, Australia', 'date': '2023-08-16, 09:45:12'},
              {
                'location': 'Cape Town, South Africa',
                'date': '2023-09-27, 18:00:01'
              },
              {'location': 'Paris, France', 'date': '2023-10-08, 03:12:34'},
              {'location': 'Moscow, Russia', 'date': '2023-11-19, 11:11:11'},
              {'location': 'Beijing, China', 'date': '2023-12-31, 23:59:59'},
              {'location': 'New Delhi, India', 'date': '2024-01-01, 00:00:01'},
              {
                'location': 'Mexico City, Mexico',
                'date': '2024-02-14, 14:14:14'
              },
              {'location': 'Rome, Italy', 'date': '2024-03-17, 17:17:17'},
              {'location': 'Toronto, Canada', 'date': '2024-04-20, 20:20:20'},
              {'location': 'Cairo, Egypt', 'date': '2024-05-23, 23:23:23'},
              {'location': 'Bangkok, Thailand', 'date': '2024-06-26, 02:02:02'},
              {'location': 'Berlin, Germany', 'date': '2024-07-29, 05:05:05'},
              {
                'location': 'Seoul, South Korea',
                'date': '2024-08-31, 08:08:08'
              },
            ],
          )
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final List<Map<String, String>> searchData;

  const SearchResult({Key? key, required this.searchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchData.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final location = searchData[index]['location'];
          final date = searchData[index]['date'];

          return Card(
            child: ListTile(
              title: Text('Location: $location',
                  style: const TextStyle(fontSize: 13)),
              subtitle:
                  Text('Date: $date', style: const TextStyle(fontSize: 13)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
                onPressed: () {
                  print("details btn");
                },
                child: const Text('Details'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Select Date Range'),
        ),
        const SizedBox(height: 10),
        if (fromDate != null && toDate != null) // Check for null
          Text(
            'From ${fromDate!.toLocal().day}/${fromDate!.toLocal().month}/${fromDate!.toLocal().year} TO ${toDate!.toLocal().day}/${toDate!.toLocal().month}/${toDate!.toLocal().year}',
            style: const TextStyle(fontSize: 14, color: AppColors.white),
          ),
      ],
    );
  }
}
