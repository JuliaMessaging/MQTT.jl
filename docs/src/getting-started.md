# MQTT.jl

Installation
------------
```julia
Pkg.clone("https://github.com/JuliaMessaging/MQTT.jl.git")
```
Testing
-------
```julia
Pkg.test("MQTT")
```
Usage
-----
Import the library with the `using` keyword. This package has no default backend, so either `AWSCRT` or `MQTTClient` needs to be included.

```julia
using MQTT, MQTTClient
```

MQTT provides a `MQTTConnection` object for each backend, this struct is passed to the other included functions.

```julia
client, connection = MQTTClient.MakeConnection(...)

mqtt_connection = MQTTConnection(client, connection)
```

### Basic example
Refer to the corresponding method documentation to find more options. Refer to the MQTT Client documentation for specifics about the client.

#### AWSCRT.jl Example

TODO

#### MQTTClient.jl Example

```julia
using MQTT, MQTTClient
broker = "test.mosquitto.org"

# Define the callback for receiving messages.
function on_msg(topic, payload)
    info("Received message topic: [", topic, "] payload: [", String(payload), "]")
end

# Instantiate a client.
mqttconnection = MQTTConnection(MQTTClient.MakeConnection(broker, 1883))

# connect to the broker
connect!(mqttconnection)

# Subscribe to the topic we will publish to.
subscribe!(on_msg, mqttconnection, "foo/test", EXACTLY_ONCE)

# Publish some data to the topic, you should see this prionted by the on_msg function
publish!(mqttconnection, "foo/test", "bar", EXACTLY_ONCE)

# Unsubscribe from the topic
unsubscribe!(mqttconnection, "foo/test")

# Disconnect from the broker. Not strictly needed as the broker will also
#   disconnect us if the socket is closed. But this is considered good form
#   and needed if you want to resume this session later.
disconnect!(mqttconnection)

# Unsubscribe from the topic
unsubscribe!(mqtt_connection, "jlExample")


disconnect!(mqtt_connection)
```

Developer Usage
--------------

## Adding a new backend
To use a new MQTT backend with MQTT.jl you need to follow at least these steps:
1. Create a `MyMQTTClientExt.jl` in `ext/` 
2. Define the 6 internal functions `_resolve`, `_connect`, `_subscribe`, `_unsubscribe`, `_publish`, `_disconnect` for your package.
3. Define a struct that is a subtype of `AbstractConnection` and extend the `MQTTConnection` to construct your struct. This struct should contain all the information for making connections, publishing etc.
4. Add some documentation for how to use your package.
5. Add some tests (optional).
 