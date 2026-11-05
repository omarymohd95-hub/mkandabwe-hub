import json
import os
import sys

ws = os.environ.get("GITHUB_WORKSPACE", ".")
out = sys.argv[1]
path = os.path.join(ws, "google-services.json")

if not os.path.exists(path):
    sys.exit("Hakuna google-services.json kwenye repository. Pakia faili hilo kwanza.")

j = json.load(open(path))
info = j["project_info"]
client = j["client"][0]

api_key = client["api_key"][0]["current_key"]
app_id = client["client_info"]["mobilesdk_app_id"]
sender = info["project_number"]
project = info["project_id"]
bucket = info.get("storage_bucket", "")

dart = f"""import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {{
  static FirebaseOptions get currentPlatform {{
    if (kIsWeb) return web;
    if (defaultTargetPlatform == TargetPlatform.android) return android;
    throw UnsupportedError('Jukwaa hili halitumiki.');
  }}

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHGwwEVvtcmGSX7oTJhCZynLfK2EUPbM4',
    authDomain: 'mkandabwe-hub.firebaseapp.com',
    projectId: 'mkandabwe-hub',
    storageBucket: 'mkandabwe-hub.firebasestorage.app',
    messagingSenderId: '570835819387',
    appId: '1:570835819387:web:6bef64714e8d4eb51b3bde',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '{api_key}',
    projectId: '{project}',
    storageBucket: '{bucket}',
    messagingSenderId: '{sender}',
    appId: '{app_id}',
  );
}}
"""
open(out, "w").write(dart)

if len(sys.argv) > 2:
    xml = f"""<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="google_app_id" translatable="false">{app_id}</string>
    <string name="gcm_defaultSenderId" translatable="false">{sender}</string>
    <string name="google_api_key" translatable="false">{api_key}</string>
    <string name="google_crash_reporting_api_key" translatable="false">{api_key}</string>
    <string name="project_id" translatable="false">{project}</string>
    <string name="google_storage_bucket" translatable="false">{bucket}</string>
</resources>
"""
    open(sys.argv[2], "w").write(xml)

print("firebase_options.dart imeandikwa kwa Android:", app_id)
