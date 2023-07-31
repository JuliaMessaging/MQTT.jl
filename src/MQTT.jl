module MQTT

export MQTTClient, MQTTConnection

export QOS

export subscribe, subscribe!
export publish, publish!
export unsubscribe, unsubscribe!
export disconnect, disconnect!

export resolve

## -- Types --

"""
    MQTTConnection

An abstract type representing a connection to an MQTT broker.

MQTT (Message Queuing Telemetry Transport) is a lightweight, publish-subscribe, machine-to-machine network protocol for message queue/message queuing service. It is designed for connections with remote locations that have devices with resource constraints or limited network bandwidth, such as in the Internet of Things (IoT). It must run over a transport protocol that provides ordered, lossless, bi-directional connections—typically, TCP/IP.

An MQTT client establishes a connection with the MQTT broker. Once connected, the client can either publish messages, subscribe to specific messages, or do both. When the MQTT broker receives a message, it forwards it to subscribers who are interested.
"""
abstract type MQTTConnection end

## -- Enums --

"""
    QOS

An enum representing the different Quality of Service (QoS) levels in MQTT.

# Values
- `AT_MOST_ONCE`: QoS level 0, at most once delivery. The message is delivered at most once, or it may not be delivered at all. This is also known as "fire and forget".
- `AT_LEAST_ONCE`: QoS level 1, at least once delivery. The message is guaranteed to be delivered at least once, but it may be delivered multiple times.
- `EXACTLY_ONCE`: QoS level 2, exactly once delivery. The message is guaranteed to be delivered exactly once.
"""
@enum QOS::UInt8 AT_MOST_ONCE=0x00 AT_LEAST_ONCE=0x01 EXACTLY_ONCE=0x02

## -- Structs

"""
    struct MQTTException <: Exception
        msg::AbstractString
    end

    A custom exception type for MQTT errors.

    # Examples
    ```julia-repl
    julia> throw(MQTTException(\"Connection refused: Not authorized\"))
    MQTTException(\"Connection refused: Not authorized\")
    ```
"""
struct MQTTException <: Exception
    msg::AbstractString
end

## -- Interfaces --

connect(client <: MQTTConnection) = _connect(client)

connect!(client <: MQTTConnection) = resolve(_connect(client))


subscribe(callback, connection <: MQTTConnection, topic, qos::QOS) = _subscribe(callback, connection, topic, qos)

subscribe!(callback, connection <: MQTTConnection, topic, qos::QOS) = resolve(_subscribe(callback, connection, topic, qos))


publish(connection <: MQTTConnection, topic, payload, qos::QOS; retain=false) = _publish(connection, topic, payload, qos, retain)

publish!(connection <: MQTTConnection, topic, payload, qos::QOS; retain=false) = resolve(_publish(connection, topic, payload, qos, retain))


unsubscribe(connection <: MQTTConnection, topic) = _unsubscribe(connection, topic)

unsubscribe!(connection <: MQTTConnection, topic) = resolve(_unsubscribe(connection, topic))


disconnect(connection <: MQTTConnection) = _disconnect(connection)

disconnect!(connection <: MQTTConnection) = resolve(_disconnect(connection))


## -- Utils --

"""
    resolve(future)

Fetch the result of a `Future` object and return it. If the result is an exception, throw the exception, otherwise return the result.

# Arguments
- `future`: The `Future` object to fetch the result from.

# Returns
- The result of the `Future`, or throws an exception if the result is an exception.
"""
function resolve(future)
    r = fetch(future)
    return (typeof(r) <: Exception) ? throw(r) : r
end

end
