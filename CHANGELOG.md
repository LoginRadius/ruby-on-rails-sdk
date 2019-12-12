> **LoginRadius Ruby On Rails SDK Change Log** provides information regarding what has changed, more specifically what changes, improvements and bug fix has been made to the SDK. For more details please refer to the [LoginRadius API Documention](https://docs.loginradius.com/api/v2/sdk-libraries/ruby)

### Version 10.0.0-beta
Released on **Dec 12, 2019**

##### Enhancements
This full version release includes major breaking changes with several improvements and optimizations :

 - Enhanced the coding standards of SDK to follow industry programming styles and best practices.
 - Enhanced security standards of SDK.
 - Reduced code between the business layer and persistence layer for optimization of SDK performance.
 - Added internal parameter validations in the API function.
 - ApiKey and ApiSecret usage redundancy removed.
 - All LoginRadius related features need to be defined once only and SDK will handle them automatically.
 - Improved the naming conventions of API functions for better readability.
 - Better Exception Handling for LoginRadius API Response in SDK.
 - Revamped complete SDK and restructured it with latest API function names and parameters.
 - Added detailed description to API functions and parameters for better understanding.
 - Updated the demo according to latest SDK changes.
 - Implemented API Region Feature.
 - Added PIN Authentication feature APIs.
 - Added Consent Management feature APIs.


## Added new multiple APIs for better user experience

 - Update Phone ID by UID
 - Upsert Email
 - Role Context profile
 - MFA Resend OTP
 - User Registration By Captcha
 - Get Access Token via Linkedin Token
 - Get Access Token By Foursquare Access Token
 - Get Active Session By Account Id
 - Get Active Session By Profile Id
 - Delete User Profiles By Email
 - Verify Multifactor OTP Authentication
 - Verify Multifactor Password Authentication
 - Verify Multifactor PIN Authentication
 - Update UID
 - MFA Re-authentication by PIN
 - PIN Login
 - Forgot PIN By Email
 - Forgot PIN By UserName
 - Reset PIN By ResetToken
 - Reset PIN By SecurityAnswer And Email
 - Reset PIN By SecurityAnswer And Username
 - Reset PIN By SecurityAnswer And Phone
 - Forgot PIN By Phone
 - Change PIN By Token
 - Reset PIN by Phone and OTP
 - Reset PIN by Email and OTP
 - Reset PIN by Username and OTP
 - Set PIN By PinAuthToken
 - Invalidate PIN Session Token
 - Submit Consent By ConsentToken
 - Get Consent Logs
 - Submit Consent By AccessToken
 - Verify Consent By AccessToken
 - Update Consent Profile By AccessToken
 - Get Consent Logs By Uid
 - Album With Cursor
 - Audio With Cursor
 - Check In With Cursor
 - Event With Cursor
 - Following With Cursor
 - Group With Cursor
 - Like With Cursor


## Removed APIs:

 - GetCompanies API
 - Getstatus API

### Version 4.0.0
Released on **March 26, 2019**

##### Enhancements

  - Reorganized and cleaned up project structure.
  - Added Custom API Domain option.
  - Added local SOTT generation method.
  - Added Passwordless Login API module:
    - Passwordless Login by Email
    - Passwordless Login by Username
    - Passwordless Login Verification
  - Added One Touch Login API module:
    - One Touch Login by Email
    - One Touch Login by Phone
    - One Touch Verify OTP by Email
    - One Touch Verify OTP
  - Added Smart Login API module:
    - Smart Login by Email
    - Smart Login by Username
    - Smart Login Ping
    - Smart Login Verify Token
  - Updated endpoints for:
    - Authentication Module:
      - Auth Change Password
    - MFA Module:
      - Validate Backup Code
      - Get Backup Code By Access Token
      - MFA Update Phone Number
      - MFA Update Phone Number by Token
    - Roles Module:
      - Account Delete Role
    - Token Management Module:
      - Refresh Token
  - Added new endpoints:
    - Authentication Module:
      - Auth Privacy Policy Accept
      - Auth Send Welcome Email
      - Auth Verify Email by OTP
      - Auth Reset Password by OTP
    - Social Module:
      - Get Message API
      - Status Posting
    - Phone Authentication:
      - Phone Login Using OTP
      - Phone Send OTP
      - Remove Phone ID by Access Token
    - MFA Module:
      - MFA Validate Google Auth Code
      - MFA Validate OTP
      - Update MFA by Access Token
      - Update MFA Setting
    - Token Management Module:
      - Access Token via Google Token

##### Bug Fixes
  - Fixed error handling.

##### Breaking Changes
  - This is a rewrite of the previous SDK version. As such, method names and return types have been changed:
  	- Top level client class has been broken up into individual modules, check readme for how to instantiate each.
  	- Client response changed from generic hash to `LoginRadius::Response`.
  	- Client errors renamed from `LoginRadiusRaas::Exception` to `LoginRadius::Error`.
  	- Most method names have been amended.
  - Please review the SDK documentation for more information.

### Version 3.0.0
Released on **March 22,  2018**

##### Enhancements

  - Updated with [api-v2](https://docs.loginradius.com/api/v2/getting-started/introduction)
  - Added new multiple APIs for better user experience.
  - EndUser add and remove multiple Emails.
  - Added update profile feature in SDK.
  - Significantly improved code performance.
  - Reduce number of library from SDK.
  - Added phonenuber and username login.
