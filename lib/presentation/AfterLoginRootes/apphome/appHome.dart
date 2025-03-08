import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.blue),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Text("Welcome ", style: TextStyle(color: Colors.black, fontSize: 18)),
            Text("Ahmed,", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Try Search",
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
            Text("Our services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1,
              physics: NeverScrollableScrollPhysics(),
              children: [
                 _buildServiceItem("lib/appassets/images/autism.png", "Autism Test"),
                 _buildServiceItem("lib/appassets/images/child_progress.png", "Child progress"),
                 _buildServiceItem("lib/appassets/images/education.png", "Educational Resources"),
                 _buildServiceItem("lib/appassets/images/chatbot.png", "Chat bot Help"),
                 _buildServiceItem("lib/appassets/images/medical.png", "Medical and pharmacist"),
                 _buildServiceItem("lib/appassets/images/charity.png", "Cooperative charities"),
              ],
            ),
            SizedBox(height: 20),
            Text("Specialists Lists", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildSpecialistItem("Developmental Pediatrician"),
            _buildSpecialistItem("Psychiatrist Child and Adolescent"),
            _buildSpecialistItem("Neuropsychologist"),
            _buildSpecialistItem("Speech-Language Pathologist"),
            _buildSpecialistItem("Pediatric Neurologist"),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String iconPath, String title) {
    return GestureDetector(
                onTap:(){} ,
                
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 52,width: 52,),
          SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSpecialistItem(String title) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        onTap: () {},
      ),
    );
  }
}
