# Hybrid SDK Documentation

## Integration Flow
- [Shield Instance](#shield-instance)
- [Device Fingerprint](#device-fingerprinting)
- [Alternative Integration Flow](#alternative-integration-flow)


## Shield Instance
In your newly created `Application` class, create the `Shield` instance via the `Builder` class. `siteId` is a merchant identifier provided to you and `sessionId` is a unique string to identify the user's current session.

`driverId` and `email` may be passed through the `sessionId` parameter when the `Shield` instance is created.
```
import android.app.Application
import com.shield.android.Shield

class ExampleApplication : Application() { {

    override fun onCreate() {
        super.onCreate()
        val siteId = "9823577ba1fca0c85ef4deecddc59e4887069e11"
        val driverId = "driver_001"
        val email = "driver001@gmail.com"

        var sessionId = "your_generated_session_id"
        sessionId = sessionId + "," + driverId + "," + email

        val shield = Shield.Builder(
                applicationContext,
                siteId)
                .setSessionId(sessionId)
                .isDedi(true)
                .build()
        Shield.createInstance(shield)
    }
}
```

## Device Fingerprint
Call the `sendSignature` function to trigger the device fingerprinting routine.
```
Shield.getInstance().sendSignature(object: ShieldCallback<Boolean> {
    override fun onSuccess(data: Boolean?) {
        Toast.makeText(
                applicationContext,
                "FP collection successful = $data",
                Toast.LENGTH_LONG
        ).show()
    }
    override fun onFailure(exception: ShieldException?) {
        Log.e("Shield", exception?.body ?: "something went wrong", exception)
    }
})
```

## Alternative Integration Flow
Alternatively, the `driverId` and `email` can be included in a transaction payload and sent through Shield's API to obtain a risk result. This proposed integration flow can also be used to send more transaction data points to Shield in the future.

### Create Shield instance
In your newly created `Application` class, create the `Shield` instance via the `Builder` class. `siteId` is a merchant identifier provided to you and `sessionId` is a unique string to identify the user's current session. `sessionId` will be generated automatically if it is excluded in the `Builder`.
```
import android.app.Application
import com.shield.android.Shield

class ExampleApplication : Application() { {

    override fun onCreate() {
        super.onCreate()
        val siteId = "9823577ba1fca0c85ef4deecddc59e4887069e11"
        val sessionId = "your_generated_session_id"

        val shield = Shield.Builder(
                applicationContext,
                siteId)
                .setSessionId(sessionId) // optional
                .isDedi(true)
                .build()
        Shield.createInstance(shield)
    }
}
```

### Trigger device fingerprinting
Call the `sendSignature` function to trigger the device fingerprinting routine.
```
Shield.getInstance().sendSignature(object: ShieldCallback<Boolean> {
    override fun onSuccess(data: Boolean?) {
        Toast.makeText(
                applicationContext,
                "FP collection successful = $data",
                Toast.LENGTH_LONG
        ).show()
    }
    override fun onFailure(exception: ShieldException?) {
        Log.e("Shield", exception?.body ?: "something went wrong", exception)
    }
})
```

### Consolidate transaction fields
Build the transaction payload with the following fields:

| Name          | Type   | Description                          | Example                                    |
| ------------- | ------ | ------------------------------------ | ------------------------------------------ |
| api_key       | string | Your API key                         | "sFfEhDOaZTN5bcMiIUp8gGBxHK3tWJdX"         |
| site_id       | string | Your site ID                         | "9823577ba1fca0c85ef4deecddc59e4887069e11" |
| session_id    | string | Unique ID to identify a user session | "session_001"                              |
| driver_id     | string | Unique ID to identify the driver     | "driver_001"                               |
| email         | string | Email address of the driver          | "driver001@gmail.com"                      |

```
val data = HashMap<String, Any>()
data["site_id"]     = "9823577ba1fca0c85ef4deecddc59e4887069e11"
data["session_id"]  = "session_001"
data["driver_id"]   = "driver_001"
data["email"]       = "driver001@gmail.com"

val payload = Payload.builder()
        .setAction(Payload.TRANSACTION)
        .additionalData(data)
        .setApiKey("your_api_key")
        .build()
```

### Obtain risk result
Call the `assessRisk` function with the `payload` to obtain a `riskStatus` from Shield.
```
Shield.getInstance().assessRisk(payload, object : ShieldCallback<RiskStatus> {
    override fun onSuccess(riskStatus: RiskStatus?) {
        Toast.makeText(
                applicationContext,
                riskStatus?.name,
                Toast.LENGTH_SHORT
        ).show()
    }
    override fun onFailure(exception: ShieldException?) {
        Log.e("Shield", exception?.body ?: "something went wrong", exception)
})
```
