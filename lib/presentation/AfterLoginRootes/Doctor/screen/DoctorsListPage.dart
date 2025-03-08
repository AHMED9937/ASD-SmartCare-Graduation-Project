import 'package:flutter/material.dart';


class DoctorsListPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ahmed Mahmoud",
      "specialty": "Speech-Language Pathologist",
      "image": "assets/doctor1.png",
    },
    {
      "name": "Dr. Omnia Mustafa",
      "specialty": "Speech-Language Pathologist",
      "image": "assets/doctor2.png",
    },
    {
      "name": "Dr. Muhammad Ahmed",
      "specialty": "Speech-Language Pathologist",
      "image": "assets/doctor3.png",
    },
    {
      "name": "Dr. Samir Faisal",
      "specialty": "Speech-Language Pathologist",
      "image": "assets/doctor4.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Find a Doctor", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Try search for doctor name...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Here are Doctors Near to you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(doctor["image"]!),
                      ),
                      title: Text(doctor["name"]!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctor["specialty"]!),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 10),
                              Icon(Icons.star, color: Colors.yellow, size: 10),
                              Icon(Icons.star, color: Colors.yellow, size: 10),
                              Icon(Icons.star, color: Colors.yellow, size: 10),
                              Icon(Icons.star_half, color: Colors.yellow, size: 10),
                              SizedBox(width: 5),
                              Text("(14 reviews)",
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text("see details", 
                              style: TextStyle(
                                  color: Colors.blue, 
                                  decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Reserve", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
