import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String name = '';
// String email = '';
_fetch() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    try {
      final DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (ds.exists) {
        final data = ds.data() as Map<String, dynamic>; // Type cast to Map
        name = data['name']; // Access the data using the [] operator
        print(name);
      } else {
        // Handle the case where the document does not exist
        print("Document does not exist.");
      }
    } catch (e) {
      print(e);
    }
  }
}
