import 'package:flutter/material.dart';
import 'package:resetapi/api_service.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: posts,
          builder: (context, snapshot) {
            // Checking if the data is available
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Post ${index + 1}:', // Add label here
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data![index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(snapshot.data![index].body),
                        ],
                      ),
                    ),
                  );
                },
              );
            } 
            // Error state handling
            else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Failed to load posts: ${snapshot.error}",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            // Loading state
            else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Loading posts..."),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
