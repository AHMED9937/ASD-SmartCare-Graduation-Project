import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {

  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ahmed Mahmoud",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor1.png",
    },
    {
      "name": "Dr. Omnia Mustafa",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor2.png",
    },
    {
      "name": "Dr. Muhammad Ahmed",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor3.png",
    },
    {
      "name": "Dr. Samir Faisal",
      "specialty": "Speech-Language Pathologist",
      "image": "lib/appassets/images/doctor4.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             IconButton(
          icon: Icon(Icons.menu, color: Colors.blue),
          onPressed: () {},
        ),
            Image.asset(
              'lib/appassets/images/Homelogo.png',
              width: 60,
              height: 45,
            ),
            IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF133E87)),
            onPressed: () {},
          ),
          ],
        ),
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(21,12,21,12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Welcome ",
                      style: TextStyle(color: Color(0xFF133E87), fontSize: 18)),
                  Text("Ahmed,",
                      style: TextStyle(
                          color: Color(0xFF90AED4),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                
                decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(1),
          
                  hintText: "Try Search",
                  hintStyle: TextStyle(fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 8),
              TextUtils.textHeader("Our services",
                  fontSize: 20, headerTextColor: Color(0xFF082F71)),
              SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildServiceItem(
                      "lib/appassets/images/autism.png", "Autism Test"),
                  _buildServiceItem("lib/appassets/images/child_progress.png",
                      "Child progress"),
                  _buildServiceItem("lib/appassets/images/education.png",
                      "Educational Resources"),
                  _buildServiceItem(
                      "lib/appassets/images/chatbot.png", "Chat bot Help"),
                  _buildServiceItem("lib/appassets/images/medical.png",
                      "Medical and pharmacist"),
                  _buildServiceItem("lib/appassets/images/charity.png",
                      "Cooperative charities"),
                ],
              ),
              SizedBox(height: 9),
              TextUtils.textHeader("Specialists Lists",
                  fontSize: 20, headerTextColor: Color(0xFF082F71)),
              TextUtils.textDescription(
                  "We connect you with the best therapists in every department!",
                  fontSize: 10,
                  disTextColor: Color(0xFF082F71)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Specialist(),
                    SizedBox(width: 24),
                    Specialist(),
           SizedBox(width: 24),
                    Specialist(),
          
                    // You can add more specialist containers here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget Specialist() {
  return Container(
    width: 220, // increased width
    height: 280, // increased height
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(23),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Expanded(
          child: Container(
            width: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              ),
            ),
            // Optionally show an image here:
            child: Image.asset(
              doctors[0]["image"]!,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtils.textHeader(
                    doctors[0]["name"]!,
                    headerTextColor: Color(0xFF00225C),
                    fontSize: 14,
                  ),
                  TextUtils.textDescription(
                    doctors[0]["specialty"]!,
                    fontSize: 10,
                  ),
                ],
              ),
              Container(
                width: 46,
                height: 22,
                decoration: BoxDecoration(
                  color: Color(0xFF00225C),
                  borderRadius: BorderRadius.all(Radius.circular(36)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [Color(0xFFFFC80B), Color(0xFFE89318)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                    TextUtils.textDescription("5.0",
                        disTextColor: Colors.white, fontSize: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: AppButtons.containerTextButton(
            TextUtils.textHeader(
              "Book Now!",
              headerTextColor: Colors.white,
            ),
            () {},
            containerHeight: 30,
            containerWidth: 128,
            containerColor: Color(0xFF133E87),
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

  Widget _buildServiceItem(String iconPath, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 52,
                width: 52,
              ),
              SizedBox(height: 5),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
