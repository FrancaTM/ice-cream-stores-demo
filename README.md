# ice_cream_stores_demo

Demo based on - [Build Mobile Apps With Flutter and Google Maps](https://www.youtube.com/watch?time_continue=1&v=RpQLFAFqMlw) (Cloud Next '19)

## Important steps to run the project
### 1 - Add api key for google maps services

You'll need to enable google maps services in a google cloud platform project and create an api key to access the services. After that, you'll have to insert your api key in 3 files inside the project (just serch for "api_key_here"). The files are:
- "api_key.dart"
- "ApiKey.m"
- "AndroidManifest.xml"
               
### 2 - Create a firebase project and replicate the cloud firestore database

You'll have to create a new firebase project and add apps for android and iOS. After that replace "google-services.json" (android) and "GoogleService-Info.plist" (iOS) files and replicate the database and data within Firebase's Cloud Firestore. Cloud Firestore is pretty straightforward and you won't have a hard time replicating the database shown in the demo on youtube, I guess :)

Just in case, here's a screenshot shot of my sample Firestore database:

![ice-cream-stores-demo-firestore](https://user-images.githubusercontent.com/14852938/67521629-a4f14480-f681-11e9-9f78-cb916a2fa8e1.png)

I hope this helps!
