module AWSCRTExt

import AWSCRT, MQTT

function MQTT._connect(c::AWSCRT.MQTTClient)
    AWSCRT.MQTTConnection(c)
end

function MQTT._subscribe(callback, connection::AWSCRT.MQTTConnection, topic, qos)
    task, id = AWSCRT.subscribe(
        connection,
        topic,
        qos,
        callback,
    )
    return task
end

function MQTT._publish(connection::AWSCRT.MQTTConnection, topic, payload, qos, retain)
    task, id = AWSCRT.publish(connection, topic, payload, qos, retain=retain)
    return task
end

function MQTT._unsubscribe(connection::AWSCRT.MQTTConnection, topic)
    task, id = AWSCRT.unsubscribe(connection, topic)
    return task
end

function MQTT._disconnect(connection::AWSCRT.MQTTConnection)
    AWSCRT.disconnect(connection)
end

end # module
