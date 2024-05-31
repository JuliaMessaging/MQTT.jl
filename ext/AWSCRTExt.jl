module AWSCRTExt

using AWSCRT: AWSCRT
using MQTT: MQTT

struct AWSCRTConfig <: MQTT.AbstractConnection
    connection::AWSCRT.MQTTConnection
    endpoint::String
    port::Int
    id::String
    connect_kwargs::Dict{Symbol,Any}
end

function MQTT.MQTTConnection(connection, endpoint, port, id; connect_kwargs=Dict())
    return AWSCRTConfig(connection, endpoint, port, id, connect_kwargs)
end

function MQTT._resolve(async_object)
    return fetch(async_object)
end

function MQTT._connect(c::AWSCRTConfig)
    return AWSCRT.connect(c.connection, c.endpoint, c.port, c.id; c.connect_kwargs...)
end

function MQTT._subscribe(callback::AWSCRT.OnMessage, c::AWSCRTConfig, topic, qos)
    task, id = AWSCRT.subscribe(c.connection, topic; qos=AWSCRT.aws_mqtt_qos(Int(qos)), callback)
    return task
end

function MQTT._publish(c::AWSCRTConfig, topic, payload, qos, retain)
    task, id = AWSCRT.publish(c.connection, topic, payload; qos=AWSCRT.aws_mqtt_qos(Int(qos)), retain=retain)
    return task
end

function MQTT._unsubscribe(c::AWSCRTConfig, topic)
    task, id = AWSCRT.unsubscribe(c.connection, topic)
    return task
end

function MQTT._disconnect(c::AWSCRTConfig)
    return AWSCRT.disconnect(c.connection)
end

# function _adapt_on_message(cb::MQTT.OnMessage)
#     return function essage(topic, payload, dup, qos, retain)
#         return cb(topic, payload)
#     end
# end

MQTT.OnMessage = AWSCRT.OnMessage

end # module
