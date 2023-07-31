module MQTTClientExt

using MQTTClient, MQTT

function MQTT._connect(c::MQTTClient.MQTTConnection)
    MQTTClient.connect_asyc(c)
end

function MQTT._subscribe(callback, c::MQTTClient.MQTTClient, topic, qos)
    MQTTClient.subscribe_async(c, topic, on_msg qos=qos)
end

function MQTT._publish(c::MQTTClient.MQTTClient, topic, payload, qos, retain)
    publish_async(c,
            topic,
            payload,
            qos=qos,
            retain = retain)
end

function MQTT._unsubscribe(c::MQTTClient.MQTTClient, topic)
    unsubscribe_async(client, topic)
end

function MQTT._disconnect(c::MQTTClient.MQTTClient)
    disconnect(c)
end

end # module
