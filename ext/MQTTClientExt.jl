module MQTTClientExt

using MQTTClient, MQTT

struct MQTT.MQTTConnection <: MQTT.AbstractConnection
    client::MQTTClient.Client
    connection::MQTTClient.MQTTConnection
end

function MQTT._resolve(async_object)
    MQTTClient.resolve(async_object)
end

function MQTT._connect(c::MQTT.MQTTConnection)
    MQTTClient.connect_asyc(c.client, c.connection)
end

function MQTT._subscribe(callback, c::MQTT.MQTTConnection, topic, qos::MQTT.QOS)
    MQTTClient.subscribe_async(c.client, topic, on_msg, qos=MQTTClient.QOS(UInt8(qos)))
end

function MQTT._publish(c::MQTT.MQTTConnection, topic, payload, qos::MQTT.QOS, retain)
    publish_async(c.client,
            topic,
            payload,
            qos=MQTTClient.QOS(UInt8(qos)),
            retain = retain)
end

function MQTT._unsubscribe(c::MQTT.MQTTConnection, topic)
    unsubscribe_async(c.client, topic)
end

function MQTT._disconnect(c::MQTT.MQTTConnection)
    disconnect(c.client)
end

end # module
