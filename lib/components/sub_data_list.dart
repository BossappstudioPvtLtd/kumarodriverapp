import 'package:flutter/material.dart';
import 'package:kumari_drivers/model/model1.dart';

List<SubscriptionModel> getSubscriptionList() {
  List<SubscriptionModel> subscriptionList = [];
  subscriptionList.add(
    SubscriptionModel(
        name: 'platinum',
        img: "assets/images/crown.png",
        price: 99,
        backgroundColor: Colors.grey[200],
        bannerColor: Colors.indigo),
        
  );
  subscriptionList.add(
    SubscriptionModel(
        name: 'Gold',
        img: "assets/images/crown.png",
        price: 199,
        backgroundColor: Colors.grey[200],
        bannerColor: Colors.indigo),
  );
  subscriptionList.add(
    SubscriptionModel(
        name: 'platinum',
        img: "assets/images/crown.png",
        price: 299,
        backgroundColor: Colors.grey[200],
        bannerColor: Colors.indigo),
  );
  return subscriptionList;
}
