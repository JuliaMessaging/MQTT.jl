module AWSCRTExt

import AWSCRT, MQTT

struct MQTT.MQTTConnection <: MQTT.AbstractConnection
    connection::AWSCRT.MQTTConnection
    endpoint::String
    port::Int
    id::String
    connect_kwargs::Dict{Symbol,Any}
end

MQTT.MQTTConnection(connection, endpoint, port, id; connect_kwargs = Dict()) =
    MQTT.MQTTConnection(connection, endpoint, port, id, connect_kwargs)

function MQTT._resolve(async_object)
    fetch(async_object)
end

function MQTT._connect(c::MQTT.MQTTConnection)
    return AWSCRT.connect(c.connection, c.endpoint, c.port, c.id; c.connect_kwargs...)
end

function MQTT._subscribe(callback, c::MQTT.MQTTConnection, topic, qos)
    task, id = AWSCRT.subscribe(c.connection, topic, qos = AWSCRT.aws_mqtt_qos(Int(qos)), _adapt_on_message(callback))
    return task
end

function MQTT._publish(c::MQTT.MQTTConnection, topic, payload, qos, retain)
    task, id = AWSCRT.publish(c.connection, topic, payload, qos = AWSCRT.aws_mqtt_qos(Int(qos)), retain = retain)
    return task
end

function MQTT._unsubscribe(c::MQTT.MQTTConnection, topic)
    task, id = AWSCRT.unsubscribe(c.connection, topic)
    return task
end

function MQTT._disconnect(c::MQTT.MQTTConnection)
    return AWSCRT.disconnect(c.connection)
end

function _adapt_on_message(cb::MQTT.OnMessage)
    return function _awscrt_on_message(topic, payload, dup, qos, retain)
        return cb(topic, payload)
    end
end

end # module
