module AWSCRTExt

import AWSCRT, MQTT

struct MQTT.MQTTConnection <: MQTT.AbstractConnection
    client::AWSCRT.MQTTClient
    connection::AWSCRT.MQTTConnection
    port::Int
    id::String
    will::AWSCRT.Will

    MQTT.MQTTConnection(client, port, id, will) = new(client, AWSCRT.MQTTConnection(client), port, id, will)
end

function MQTT._resolve(async_object)
    fetch(async_object)
end

function MQTT._connect(c::MQTT.MQTTConnection)
    AWSCRT.connect(
        c.connection,
        ENV["ENDPOINT"],
        c.port,
        c.id,
        c.will
    )
end

function MQTT._subscribe(callback, c::MQTT.MQTTConnection, topic, qos)
    task, id = AWSCRT.subscribe(
        c.connection,
        topic,
        qos = AWSCRT.aws_mqtt_qos(Int(qos)),
        callback,
    )
    return task
end

function MQTT._publish(c::MQTT.MQTTConnection, topic, payload, qos, retain)
    task, id = AWSCRT.publish(c.connection, topic, payload, qos=AWSCRT.aws_mqtt_qos(Int(qos)), retain=retain)
    return task
end

function MQTT._unsubscribe(c::MQTT.MQTTConnection, topic)
    task, id = AWSCRT.unsubscribe(c.connection, topic)
    return task
end

function MQTT._disconnect(c::MQTT.MQTTConnection)
    AWSCRT.disconnect(c.connection)
end

end # module
