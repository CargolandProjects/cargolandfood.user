importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyAyRNAQrjYedBaggD27vbc1kvMlaH6LgVw",
    authDomain: "cargoland--food.firebaseapp.com",
    projectId: "cargoland--food",
    storageBucket: "cargoland--food.firebasestorage.app",
    messagingSenderId: "860443497637",
    appId: "1:860443497637:web:fdcbeb796fe5056a3c694c",
    measurementId: "G-CL4JV3DWL9"
  databaseURL: "...",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});