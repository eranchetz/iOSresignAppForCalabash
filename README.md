iOSresignAppForCalabash
=======================

This is a MacOS tool to resign iOS IPA with a development certificate.

In our case the build server builds our IPAs with a IN_HOUSE (Enterprise account) provision profile.
This makes testing the IPA impossible using calabash-ios

The soltuion we found was to resign and re-entitle the IPA.

### Example

        ./IPAresign  Myapp.ipa /Users/John/Downloads/automation_Provisioning.mobileprovision "iPhone Developer: John Smith (DLABC99W)"


