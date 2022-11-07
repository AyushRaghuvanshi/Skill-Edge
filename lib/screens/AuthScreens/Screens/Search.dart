import 'package:flutter/material.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/searchCourse.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();
  List<dynamic> search_result = [];

  bool loading = false;

  var topic;

  var short_description;

  var thumbnail;

  var price;

  var rating;

  var eduname;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _search,
                onEditingComplete: () {
                  print('saved');
                  API api = new API();
                  setState(() {
                    loading = true;
                  });
                  api.getSearchresults(_search.text).then((value) {
                    search_result = value;
                    print(search_result);
                    setState(() {
                      loading = false;
                    });
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Search for Mentor or Courses',
                    border: OutlineInputBorder()),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: search_result.length,
                    itemBuilder: ((context, index) {
                      topic = search_result[index]['topic'];
                      short_description =
                          search_result[index]['short_description'];
                      thumbnail = search_result[index]['thumbnail'];
                      price = search_result[index]['price'];
                      rating = search_result[index]['rating'];
                      eduname = search_result[index]['educator_name'];
                      return SearchCourse(
                          rating: rating,
                          edu_name: eduname,
                          topic: topic,
                          short_description: short_description,
                          thumbnail: thumbnail,
                          price: price);
                    })),
              )
            ],
          ),
        ));
  }
}
