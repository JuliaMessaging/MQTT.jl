module MQTT

export AbstractConnection, MQTTConnection

export QOS

export connect, connect!
export subscribe, subscribe!
export publish, publish!
export unsubscribe, unsubscribe!
export disconnect, disconnect!

## -- Types --

"""
    MQTTConnection

An abstract type representing a connection to an MQTT broker.

MQTT (Message Queuing Telemetry Transport) is a lightweight, publish-subscribe, machine-to-machine network protocol for message queue/message queuing service. It is designed for connections with remote locations that have devices with resource constraints or limited network bandwidth, such as in the Internet of Things (IoT). It must run over a transport protocol that provides ordered, lossless, bi-directional connections—typically, TCP/IP.

An MQTT client establishes a connection with the MQTT broker. Once connected, the client can either publish messages, subscribe to specific messages, or do both. When the MQTT broker receives a message, it forwards it to subscribers who are interested.
"""
abstract type AbstractConnection end

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

## -- Interfaces --

connect(c::AbstractConnection) = _connect(c)

connect!(c::AbstractConnection) = _resolve(_connect(c))


subscribe(callback, connection::AbstractConnection, topic, qos::QOS) = _subscribe(callback, connection, topic, qos)

subscribe!(callback, connection::AbstractConnection, topic, qos::QOS) = _resolve(_subscribe(callback, connection, topic, qos))


publish(connection::AbstractConnection, topic, payload, qos::QOS; retain=false) = _publish(connection, topic, payload, qos, retain)

publish!(connection::AbstractConnection, topic, payload, qos::QOS; retain=false) = _resolve(_publish(connection, topic, payload, qos, retain))


unsubscribe(connection::AbstractConnection, topic) = _unsubscribe(connection, topic)

unsubscribe!(connection::AbstractConnection, topic) = _resolve(_unsubscribe(connection, topic))


disconnect(connection::AbstractConnection) = _disconnect(connection)

disconnect!(connection::AbstractConnection) = _resolve(_disconnect(connection))


end
