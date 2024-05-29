# Creating MQTT Backend Extensions

## How it works

MQTT.jl uses the Weak Deps features to allow multiple MQTT packages to be added as weak dependancies. 

Each MQTT client implimentation needs to have a extension added in the `ext` directory (and registered in the `Project.toml`).

These extensions and their packages they implement are only loaded if the end-user of this package adds it as a dependancy (only loading what you need).

## Creating an Extension

To make a new Client functional an extension is created. The extension needs to implement the following interface functions that return asynchronous objects such as Tasks or Futures:

* `_connect(c::MQTTConnection)`: connect to a broker
* `_subscribe(callback::Function, c::MQTTConnection, topic, qos::QOS)`: subscribe to a topic
* `_publish(c::MQTTConnection, topic::String, payload::Vector{UInt8}, qos::QOS, retain::Bool)`: publish to a topic
* `_unsubscribe(c::MQTTConnection, topic::String)`: unsubscribe from a topic
* `_disconnect(c::MQTTConnection)`: disconnect from a broker

Aditionally the following utility function(s) need to be implemented:

* `_resolve(f)`: wrapper function for fetching a async result.

Most importantly the connection struct needs to be created.

* `MQTTConnection` this needs to be a subtype of `AbstractConnection` and contain all information specific to the MQTT Client that is being used.