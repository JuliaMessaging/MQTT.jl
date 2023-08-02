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
client = MQTTClient.Client()
connection = MQTTClient.Connection()

mqtt_connection = MQTTConnection(client, connection)
```

Advanced Usage
--------------

## Getting started
To use this library you need to follow at least these steps:
1. Define any client data structures needed for a given backend.
2. Create an instance of the `MQTTConnection` struct passing the backend specific information.
3. Call the connect method with your `Client` instance.
4. Exchange data with the broker through publish, subscribe and unsubscribe. When subscribing, pass your callback function for that topic.
5. Disconnect from the broker. (Not strictly necessary, if you don't want to resume the session but considered good form and less likely to crash).

#### Basic example
Refer to the corresponding method documentation to find more options. Refer to the MQTT Client documentation for specifics about the client.

```julia
using MQTT, MQTTClient
broker = "test.mosquitto.org"

# Define the callback for receiving messages.
function on_msg(topic, payload)
    info("Received message topic: [", topic, "] payload: [", String(payload), "]")
end

# Instantiate a client.
client = MQTTClient.Client()
connection = MQTTClient.Connection()
mqtt_connection = MQTTConnection(client, connection)

connect!(mqtt_connection)

# Subscribe to the topic we will publish to.
subscribe!(mqtt_connection, "jlExample", on_msg, qos=AT_LEAST_ONCE))

publish!(mqtt_connection, "jlExample", "Hello World!")

# Unsubscribe from the topic
unsubscribe!(mqtt_connection, "jlExample")

# Disconnect from the broker. Not strictly needed as the broker will also
#   disconnect us if the socket is closed. But this is considered good form
#   and needed if you want to resume this session later.
disconnect!(mqtt_connection)
```