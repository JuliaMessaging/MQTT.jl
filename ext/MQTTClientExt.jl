module MQTTClientExt

using MQTTClient: MQTTClient
using MQTT: MQTT

struct MQTTClientConfig <: MQTT.AbstractConnection
    client::MQTTClient.Client
    connection::MQTTClient.Connection
end
function MQTT.MQTTConnection(configuration::MQTTClient.Configuration)
    return MQTTClientConfig(configuration.client, configuration.connection)
end
MQTT.MQTTConnection(client::MQTTClient.Client, connection::MQTTClient.Connection) = MQTTClientConfig(client, connection)

function MQTT._resolve(async_object)
    return MQTTClient.resolve(async_object)
end

function MQTT._connect(c::MQTTClientConfig)
    return MQTTClient.connect_async(c.client, c.connection)
end

function MQTT._subscribe(callback::MQTT.OnMessage, c::MQTTClientConfig, topic::AbstractString, qos::MQTT.QOS)
    return MQTTClient.subscribe_async(c.client, topic, callback; qos=MQTTClient.QOS(UInt8(qos)))
end

function MQTT._publish(c::MQTTClientConfig, topic::AbstractString, payload, qos::MQTT.QOS, retain)
    return MQTTClient.publish_async(c.client, topic, payload; qos=MQTTClient.QOS(UInt8(qos)), retain=retain)
end

function MQTT._unsubscribe(c::MQTTClientConfig, topic::AbstractString)
    return MQTTClient.unsubscribe_async(c.client, topic)
end

function MQTT._disconnect(c::MQTTClientConfig)
    return MQTTClient.disconnect(c.client)
end

end # module
