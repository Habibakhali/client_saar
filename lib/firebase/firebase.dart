import 'package:client_saar/firebase/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<ItemModel> getCollection(String collectionName) {
   return FirebaseFirestore.instance.collection(collectionName).withConverter(
      fromFirestore: (snapShot,option)=>ItemModel.fromJson(snapShot.data()!),
      toFirestore: (item,option)=>item.toJson());
}

Future<void> addImageToFirebase(String collectionName,ItemModel model) {

  var collection = getCollection(collectionName);
  var doc = collection.doc();
  model.id=doc.id;
  return doc.set(model);
}

Stream<QuerySnapshot<ItemModel>> getImageToFirebase(String collectionName) {
  return getCollection(collectionName).snapshots();
}
Future<void>Update(String collectionName,String id,String name,String price,String weight,String strength)async{
  var collection=getCollection(collectionName);
  var doc=collection.doc(id);
  var updateData = {
    "weight": weight,
    "price": price,
    'strength':strength,
    'name':name,
  };

  return await doc.update(updateData);
}