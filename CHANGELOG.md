> **LoginRadius Ruby On Rails SDK Change Log** provides information regarding what has changed, more specifically what changes, improvements and bug fix has been made to the SDK. For more details please refer to the [LoginRadius API Documention](https://docs.loginradius.com/api/v2/sdk-libraries/ruby)

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
