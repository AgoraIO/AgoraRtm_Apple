# Troubleshooting

Learn how to enable detailed log output and handle error messages efficiently in your Agora Signaling application.

## Overview

During the development and testing stages of your application, you may need the SDK to output more detailed information to locate and fix issues. You can enable log output and set the log information level by setting the ``RtmClientConfig`` in ``RtmLogConfig`` when initializing the RTM instance. Afterwards, you can view the log information in the browser's console.

```swift
let rtmConfig = RtmClientConfig(appId: "your_appid", userId: "your_userid")

let logConfig = RtmLogConfig(
    level: .error,
    filePath: "file_path",
    fileSizeInKB: 512
)

rtmConfig.logConfig = logConfig
```

The level field can be set to one of the five levels: ``RtmLogLevel/info``, ``RtmLogLevel/warn``, ``RtmLogLevel/error``, ``RtmLogLevel/fatal``, ``RtmLogLevel/none``. Among them, ``RtmLogLevel/info`` outputs the most detailed log information, and ``RtmLogLevel/none`` does not output log information.

Using a build flag, you can set your log level to ``RtmLogLevel/none`` when your app goes to production.

---

When calling methods in Agora Signaling, if an error occurs, the SDK will execute the completionBlock callback and return an errorInfo value of type ``RtmErrorInfo``:

| Property | Type | Description |
|:-|:-|:-|
| ``RtmErrorInfo/errorCode`` | ``RtmErrorCode`` | The error code for this operation. |
| ``RtmErrorInfo/reason`` | `String` | The reason for the error in this operation. |
| ``RtmErrorInfo/operation`` | `String` | The type of operation. |

The errorCode and reason properties report the error code and error description respectively.

You can find out more in the ``RtmErrorCode`` documentation.

## Support 

If the above measures have not resolved your issue, or you need support for your solution, please send your requirements via email to [rtm@agora.io](mailto:rtm@agora.io).
