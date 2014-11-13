#!/bin/bash

#This script gets 3 arguments IPA name, Provsion file, and Certificate name in keychain

IPA=$1
PROVISION=$2 # /Users/John/Downloads/automation_Provisioning.mobileprovision"
CERTIFICATE=$3 # must be in keychain (something like "iPhone Developer: John Smith (DLABC99W)")
# unzip the ipa
unzip -q "$IPA"
# remove the signature
rm -rf Payload/*.app/_CodeSignature Payload/*.app/CodeResources
# replace the provision
cp "$PROVISION" Payload/*.app/embedded.mobileprovision
#create entitlements
/usr/libexec/PlistBuddy -x -c "print :Entitlements " /dev/stdin <<< $(security cms -D -i Payload/*.app/embedded.mobileprovision) > entitlements.plist
/usr/libexec/PlistBuddy -c 'Set :get-task-allow true' entitlements.plist
# sign with the new certificate
/usr/bin/codesign -f -s "$CERTIFICATE" --resource-rules   Payload/*.app/ResourceRules.plist --entitlements entitlements.plist Payload/*.app
# zip it back up
zip -qr "$1-resigned.ipa" Payload
