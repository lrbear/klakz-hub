// Firebase SDK importları (CDN üzerinden)
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
import { getDatabase, ref, set, get, onValue, push, remove } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-database.js";

// Senin Firebase yapılandırma bilgilerin
const firebaseConfig = {
    apiKey: "AIzaSyAJuMNSxWFuNTO0xGriUo8QoaC9g-ie8WM",
    authDomain: "klakz-database.firebaseapp.com",
    databaseURL: "https://klakz-database-default-rtdb.firebaseio.com",
    projectId: "klakz-database",
    storageBucket: "klakz-database.firebasestorage.app",
    messagingSenderId: "437747915577",
    appId: "1:437747915577:web:f4ffa2f76d6d7a923966e8",
    measurementId: "G-JXRST4BRTE"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getDatabase(app);

export { db, ref, set, get, onValue, push, remove };
