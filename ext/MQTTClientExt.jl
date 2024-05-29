module MQTTClientExt

using MQTTClient: MQTTClient
using MQTT: MQTT

struct MQTTConnection <: MQTT.AbstractConnection
    client::MQTTClient.Client
    connection::MQTTClient.Connection

    MQTTConnection(configuration::MQTTClient.Configuration) = new(configuration.client, configuration.connection)
end
MQTT.MQTTConnection(configuration::MQTTClient.Configuration) = MQTTConnection(configuration)

function MQTT._resolve(async_object)
    return MQTTClient.resolve(async_object)
end

function MQTT._connect(c::MQTTConnection)
    return MQTTClient.connect_async(c.client, c.connection)
end

function MQTT._subscribe(callback::MQTT.OnMessage, c::MQTTConnection, topic::AbstractString, qos::MQTT.QOS)
    return MQTTClient.subscribe_async(c.client, topic, callback; qos=MQTTClient.QOS(UInt8(qos)))
end

function MQTT._publish(c::MQTTConnection, topic::AbstractString, payload, qos::MQTT.QOS, retain)
    return MQTTClient.publish_async(c.client, topic, payload; qos=MQTTClient.QOS(UInt8(qos)), retain=retain)
end

function MQTT._unsubscribe(c::MQTTConnection, topic::AbstractString)
    return MQTTClient.unsubscribe_async(c.client, topic)
end

function MQTT._disconnect(c::MQTTConnection)
    return MQTTClient.disconnect(c.client)
end

end # module
