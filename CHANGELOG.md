> **LoginRadius Ruby On Rails SDK Change Log** provides information regarding what has changed, more specifically what changes, improvements and bug fix has been made to the SDK. For more details please refer to the [LoginRadius API Documention](https://docs.loginradius.com/api/v2/sdk-libraries/ruby)


# Version 11.5.0
Release on January 20, 2023

## Enhancements

- We have updated some of the dependencies to the latest Version.
- Added `email_template` parameter in `user_registration_by_phone` Api

## Removed (Deprecated) APIs:
- `auth_get_registration_data`
- `validate_registration_data_code`
- `get_registration_data`
- `add_registration_data`
- `update_registration_data`
- `delete_registration_data`
- `delete_all_records_by_data_source`
- `get_access_token_by_vkontakte_access_token`
- `get_albums`
- `get_albums_with_cursor`
- `get_audios`
- `get_audios_with_cursor`
- `get_check_ins`
- `get_check_ins_with_cursor`
- `get_contacts`
- `get_events`
- `get_events_with_cursor`
- `get_followings`
- `get_followings_with_cursor`
- `get_groups`
- `get_groups_with_cursor`
- `get_likes`
- `get_likes_with_cursor`
- `get_mentions`
- `post_message`
- `get_page`
- `get_photos`
- `get_posts`
- `status_posting`
- `trackable_status_posting`
- `get_trackable_status_stats`
- `trackable_status_fetching`
- `get_videos`
- `get_refreshed_social_user_profile`

# Version 11.4.0
Release on June 3, 2022

## Enhancements

 - We are introducing a new manual Sott generation method `get_sott()` with additional parameter `start_time` & `end_time` , we recomend using this method to generate SOTT manually , the old function `local_generate_sott()` will also exist but it is deprecated and will be removed in a future version of SDK.
 - Enhancement in README.md file.


# Version 11.3.0
Release on January 28, 2022

## Enhancements

 - Added a feature to add ApiKey and ApiSecret directly in LoginRadius manual SOTT generation method.
 - Added Licence and Contribution Guideline file.


## Breaking Changes

For developers migrating from v11.2.2, there will be 1 minor breaking change in terms of SDK implementation. In this version, we have added a feature to add ApiKey & ApiSecret directly into the manual SOTT generation method `local_generate_sott()`.

# Version 11.2.2
Release on September 15, 2021

## Enhancements

 - Added X-Origin-IP header support.
 - Added 429 error code handling for "Too Many Request in a particular time frame".


## Added new multiple APIs for better user experience

 - Get Profile By Ping.
 - Passwordless Login Verification By Email And OTP.
 - Passwordless Login Verification By User Name And OTP.
 - MFAEmailOtpByAccessToken
 - MFAValidateEmailOtpByAccessToken
 - MFAResetEmailOtpAuthenticatorByAccessToken
 - MFASecurityQuestionAnswerByAccessToken
 - MFAResetSecurityQuestionAuthenticatorByAccessToken
 - MFAEmailOTP
 - MFAValidateEmailOtp
 - MFASecurityQuestionAnswer
 - MFASecurityQuestionAnswerVerification
 - MFAResetEmailOtpAuthenticatorByUid
 - MFAResetSecurityQuestionAuthenticatorByUid
 - ReAuthValidateEmailOtp
 - ReAuthSendEmailOtp
 - ReAuthBySecurityQuestion

## Removed APIs :

- GetSocialUserProfile

Added `EmailTemplate2FA` parameter in the following API

- MFALoginByEmail
- MFALoginByUserName
- MFALoginByPhone


Added `RbaBrowserEmailTemplate`, `RbaCityEmailTemplate` ,`RbaCountryEmailTemplate` , `RbaIpEmailTemplate` parameter in the following API

- MFAValidateOTPByPhone
- MFAValidateGoogleAuthCode
- MFAValidateBackupCode

Added `emailTemplate`, `verificationUrl` ,`welcomeEmailTemplate`  parameter in the following API

- GetProfileByAccessToken

## Removed `smsTemplate2FA`  parameter from the following API

- mfaValidateGoogleAuthCode

### Version 11.0.0
Release on **July 28,2020**

## Enhancements:
- Added a parameter isWeb in "RefreshAccessToken" API.
- Added a parameter SocialAppName in "getAccessTokenByFacebookAccessToken,  getAccessTokenByTwitterAccessToken,
  getAccessTokenByGoogleAccessToken, getAccessTokenByLinkedinAccessToken, getAccessTokenByAppleIdCode, 
  getAccessTokenByGoogleAuthCode" Native Social login APIs.

## Added new multiple APIs for better user experience:
- Added linkSocialIdentites(POST) API.
- Added linkSocialIdentitiesByPing(POST) API.
- Added getAccessTokenByAppleIdCode API.
- Added getAccessTokenByWeChatCode API.

## Removed APIs:
 - linkSocialIdentity API(PUT)
 - getSocialIdentity API(GET)
 

### Version 10.0.0
Released on **Dec 19, 2019**

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
