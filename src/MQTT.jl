module MQTT

export AbstractConnection, MQTTConnection

export QOS, AT_MOST_ONCE, AT_LEAST_ONCE, EXACTLY_ONCE

export connect!, connect_async!
export subscribe!, subscribe_async!
export publish!, publish_async!
export unsubscribe!, unsubscribe_async!
export disconnect!, disconnect_async!

## -- Types --

# An abstract type representing a MQTT Client and the connection to an MQTT broker.
abstract type AbstractConnection end

# A type alias
const OnMessage = Function

## -- Enums --

"""
    QOS

An enum representing the different Quality of Service (QoS) levels in MQTT.

# Values

  - `AT_MOST_ONCE`: QoS level 0, at most once delivery. The message is delivered at most once, or it may not be delivered at all. This is also known as "fire and forget".
  - `AT_LEAST_ONCE`: QoS level 1, at least once delivery. The message is guaranteed to be delivered at least once, but it may be delivered multiple times.
  - `EXACTLY_ONCE`: QoS level 2, exactly once delivery. The message is guaranteed to be delivered exactly once.
"""
@enum QOS::UInt8 AT_MOST_ONCE = 0x00 AT_LEAST_ONCE = 0x01 EXACTLY_ONCE = 0x02

## -- Interfaces --

"""
    connect_async!(c::AbstractConnection)

make a connection to a broker.
"""
connect_async!(c::AbstractConnection) = _connect(c)

"""
    connect!(c::AbstractConnection)

make a connection to a broker, and wait for the connection to be acknowleged.

## Example

```julia
mqttconnection = ...
connect!(mqttconnection)
```
"""
connect!(c::AbstractConnection) = _resolve(_connect(c))

"""
    subscribe_async!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS)

subscribe to a topic.
"""
subscribe_async!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS) =
    _subscribe(callback, connection, topic, qos)

"""
    subscribe_async!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS)

subscribe to a topic, and wait for subscription to be acknowleged.

## Example

use a previously defined callback function.

```julia
cb(topic, payload) = do_a_thing_for_device_one(payload)
subscribe!(cb, mqttconnection, "group1/device1", QOS.EXACTLY_ONCE)
```

define the callback in a `do` block

```julia
subscribe!(mqttconnection, "group1/device2", QOS.EXACTLY_ONCE) do (topic, payload)
    do_a_thing_for_device_two(payload)
end
```
"""
subscribe!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS) =
    _resolve(_subscribe(callback, connection, topic, qos))

"""
    publish_async!(connection::AbstractConnection, topic, payload, qos::QOS; retain = false)

publish to a topic.
"""
publish_async!(connection::AbstractConnection, topic, payload, qos::QOS; retain=false) =
    _publish(connection, topic, payload, qos, retain)

"""
    publish!(connection::AbstractConnection, topic, payload, qos::QOS; retain = false)

publish to a topic, and wait for message to be acknowleged.

## Example

```julia
publish!(mqttconnection, "group1/device1", "hello world", QOS.EXACTLY_ONCE)
```
"""
publish!(connection::AbstractConnection, topic, payload, qos::QOS; retain=false) =
    _resolve(_publish(connection, topic, payload, qos, retain))

"""
    unsubscribe_async!(connection::AbstractConnection, topic)

unsubscribe from a topic.
"""
unsubscribe_async!(connection::AbstractConnection, topic) = _unsubscribe(connection, topic)

"""
    unsubscribe!(connection::AbstractConnection, topic)

unsubscribe from a topic, and wait for unsubscription to be acknowleged.

## Example

```julia
unsubscribe!(mqttconnection, "group1/device1")
```
"""
unsubscribe!(connection::AbstractConnection, topic) = _resolve(_unsubscribe(connection, topic))

"""
    disconnect_async!(connection::AbstractConnection)

disconnect from a broker.
"""
disconnect_async!(connection::AbstractConnection) = _disconnect(connection)

"""
    disconnect!(connection::AbstractConnection)

disconnect from a broker, and wait for disconnect to be acknowleged.

## Example

```julia
disconnect!(mqttconnection)
```
"""
disconnect!(connection::AbstractConnection) = _resolve(_disconnect(connection))

## -- Internals --
MQTTConnection() = nothing
_resolve() = nothing
_connect() = nothing
_subscribe() = nothing
_unsubscribe() = nothing
_publish() = nothing
_disconnect() = nothing

end
