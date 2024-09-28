import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incrementer_app/pages/login_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int value = 0;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchIncrementValue();
  }

  //fecth the previous incremented value
  void fetchIncrementValue() async {
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          value = snapshot['value'] ?? 0;
        });
      } else {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .set({
          'value': 0,
        });
        setState(() {
          value = 0;
        });
      }
    }
  }

  void incrementCounter() {
    setState(() {
      value++;
    });
  }

  // Save the current value to Firestore when the user logs out
  void saveValueToFirestore() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update({'user': user?.email, 'value': value});
    }
  }

  // Logout the user
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const Loginpage();
      },
    ));
  }

  //Dialogue box
  void decisionBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: const Text("Do you want to save the data?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Logout without saving the data
                  logout();
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .set({'value': 0});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 89, 137),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("No"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Save the incremented value
                  saveValueToFirestore();
                  logout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 89, 137),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Yes"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Increment Counter"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[200],
        actions: [
          IconButton(
            onPressed: decisionBox,
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          incrementCounter();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
