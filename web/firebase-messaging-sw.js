importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js",
);

firebase.initializeApp({
  apiKey: "AIzaSyDO49neTt19NA2iXCiAuVUV99_pQdQluD4",
  authDomain: "cargoland-project.firebaseapp.com",
  projectId: "cargoland-project",
  storageBucket: "cargoland-project.firebasestorage.app",
  messagingSenderId: "194583925856",
  appId: "1:194583925856:web:d9e169bd0b6d2ad2491f05",
  measurementId: "G-XHDR7ZJGMX",

  databaseURL: "...",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      const title = payload.notification.title;
      const options = {
        body: payload.notification.score,
      };
      return registration.showNotification(title, options);
    });
  return promiseChain;
});
self.addEventListener("notificationclick", function (event) {
  console.log("notification received: ", event);
});
