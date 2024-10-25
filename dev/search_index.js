var documenterSearchIndex = {"docs":
[{"location":"api/","page":"MQTT API","title":"MQTT API","text":"","category":"page"},{"location":"api/","page":"MQTT API","title":"MQTT API","text":"QOS\nMQTTConnection\nconnect_async!\nconnect!\nsubscribe_async!\nsubscribe!\npublish_async!\npublish!\nunsubscribe_async!\nunsubscribe!\ndisconnect_async!\ndisconnect!","category":"page"},{"location":"api/#MQTT.QOS","page":"MQTT API","title":"MQTT.QOS","text":"QOS\n\nAn enum representing the different Quality of Service (QoS) levels in MQTT.\n\nValues\n\nAT_MOST_ONCE: QoS level 0, at most once delivery. The message is delivered at most once, or it may not be delivered at all. This is also known as \"fire and forget\".\nAT_LEAST_ONCE: QoS level 1, at least once delivery. The message is guaranteed to be delivered at least once, but it may be delivered multiple times.\nEXACTLY_ONCE: QoS level 2, exactly once delivery. The message is guaranteed to be delivered exactly once.\n\n\n\n\n\n","category":"type"},{"location":"api/#MQTT.MQTTConnection","page":"MQTT API","title":"MQTT.MQTTConnection","text":"MQTTConnection()\n\nThis function constructs the connection struct that a given backend needs for interfacing with the MQTT Broker.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.connect_async!","page":"MQTT API","title":"MQTT.connect_async!","text":"connect_async!(c::AbstractConnection)\n\nmake a connection to a broker.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.connect!","page":"MQTT API","title":"MQTT.connect!","text":"connect!(c::AbstractConnection)\n\nmake a connection to a broker, and wait for the connection to be acknowleged.\n\nExample\n\nmqttconnection = ...\nconnect!(mqttconnection)\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.subscribe_async!","page":"MQTT API","title":"MQTT.subscribe_async!","text":"subscribe_async!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS)\n\nsubscribe to a topic.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.subscribe!","page":"MQTT API","title":"MQTT.subscribe!","text":"subscribe_async!(callback::OnMessage, connection::AbstractConnection, topic, qos::QOS)\n\nsubscribe to a topic, and wait for subscription to be acknowleged.\n\nExample\n\nuse a previously defined callback function.\n\ncb(topic, payload) = do_a_thing_for_device_one(payload)\nsubscribe!(cb, mqttconnection, \"group1/device1\", QOS.EXACTLY_ONCE)\n\ndefine the callback in a do block\n\nsubscribe!(mqttconnection, \"group1/device2\", QOS.EXACTLY_ONCE) do (topic, payload)\n    do_a_thing_for_device_two(payload)\nend\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.publish_async!","page":"MQTT API","title":"MQTT.publish_async!","text":"publish_async!(connection::AbstractConnection, topic, payload, qos::QOS; retain = false)\n\npublish to a topic.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.publish!","page":"MQTT API","title":"MQTT.publish!","text":"publish!(connection::AbstractConnection, topic, payload, qos::QOS; retain = false)\n\npublish to a topic, and wait for message to be acknowleged.\n\nExample\n\npublish!(mqttconnection, \"group1/device1\", \"hello world\", QOS.EXACTLY_ONCE)\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.unsubscribe_async!","page":"MQTT API","title":"MQTT.unsubscribe_async!","text":"unsubscribe_async!(connection::AbstractConnection, topic)\n\nunsubscribe from a topic.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.unsubscribe!","page":"MQTT API","title":"MQTT.unsubscribe!","text":"unsubscribe!(connection::AbstractConnection, topic)\n\nunsubscribe from a topic, and wait for unsubscription to be acknowleged.\n\nExample\n\nunsubscribe!(mqttconnection, \"group1/device1\")\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.disconnect_async!","page":"MQTT API","title":"MQTT.disconnect_async!","text":"disconnect_async!(connection::AbstractConnection)\n\ndisconnect from a broker.\n\n\n\n\n\n","category":"function"},{"location":"api/#MQTT.disconnect!","page":"MQTT API","title":"MQTT.disconnect!","text":"disconnect!(connection::AbstractConnection)\n\ndisconnect from a broker, and wait for disconnect to be acknowleged.\n\nExample\n\ndisconnect!(mqttconnection)\n\n\n\n\n\n","category":"function"},{"location":"getting-started/#MQTT.jl","page":"Getting Started","title":"MQTT.jl","text":"","category":"section"},{"location":"getting-started/#Installation","page":"Getting Started","title":"Installation","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"Pkg.clone(\"https://github.com/JuliaMessaging/MQTT.jl.git\")","category":"page"},{"location":"getting-started/#Testing","page":"Getting Started","title":"Testing","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"Pkg.test(\"MQTT\")","category":"page"},{"location":"getting-started/#Usage","page":"Getting Started","title":"Usage","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"Import the library with the using keyword. This package has no default backend, so either AWSCRT or MQTTClient needs to be included.","category":"page"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"using MQTT, MQTTClient","category":"page"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"MQTT provides a MQTTConnection object for each backend, this struct is passed to the other included functions.","category":"page"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"client, connection = MQTTClient.MakeConnection(...)\n\nmqtt_connection = MQTTConnection(client, connection)","category":"page"},{"location":"getting-started/#Basic-example","page":"Getting Started","title":"Basic example","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"Refer to the corresponding method documentation to find more options. Refer to the MQTT Client documentation for specifics about the client.","category":"page"},{"location":"getting-started/#AWSCRT.jl-Example","page":"Getting Started","title":"AWSCRT.jl Example","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"TODO","category":"page"},{"location":"getting-started/#MQTTClient.jl-Example","page":"Getting Started","title":"MQTTClient.jl Example","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"using MQTT, MQTTClient\nbroker = \"test.mosquitto.org\"\n\n# Define the callback for receiving messages.\nfunction on_msg(topic, payload)\n    info(\"Received message topic: [\", topic, \"] payload: [\", String(payload), \"]\")\nend\n\n# Instantiate a client.\nmqttconnection = MQTTConnection(MQTTClient.MakeConnection(broker, 1883))\n\n# connect to the broker\nconnect!(mqttconnection)\n\n# Subscribe to the topic we will publish to.\nsubscribe!(on_msg, mqttconnection, \"foo/test\", EXACTLY_ONCE)\n\n# Publish some data to the topic, you should see this prionted by the on_msg function\npublish!(mqttconnection, \"foo/test\", \"bar\", EXACTLY_ONCE)\n\n# Unsubscribe from the topic\nunsubscribe!(mqttconnection, \"foo/test\")\n\n# Disconnect from the broker. Not strictly needed as the broker will also\n#   disconnect us if the socket is closed. But this is considered good form\n#   and needed if you want to resume this session later.\ndisconnect!(mqttconnection)\n\n# Unsubscribe from the topic\nunsubscribe!(mqtt_connection, \"jlExample\")\n\n\ndisconnect!(mqtt_connection)","category":"page"},{"location":"getting-started/#Developer-Usage","page":"Getting Started","title":"Developer Usage","text":"","category":"section"},{"location":"getting-started/#Adding-a-new-backend","page":"Getting Started","title":"Adding a new backend","text":"","category":"section"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"To use a new MQTT backend with MQTT.jl you need to follow at least these steps:","category":"page"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"Create a MyMQTTClientExt.jl in ext/ \nDefine the 6 internal functions _resolve, _connect, _subscribe, _unsubscribe, _publish, _disconnect for your package.\nDefine a struct that is a subtype of AbstractConnection and extend the MQTTConnection to construct your struct. This struct should contain all the information for making connections, publishing etc.\nAdd some documentation for how to use your package.\nAdd some tests (optional).","category":"page"},{"location":"getting-started/","page":"Getting Started","title":"Getting Started","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = MQTT","category":"page"},{"location":"#MQTT","page":"Home","title":"MQTT","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for MQTT.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This Package is a interface package for generic use functions with the goal of making MQTT package backends interchangeable.","category":"page"},{"location":"#Table-of-Contents","page":"Home","title":"Table of Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Pages = [\n  \"getting-started.md\",\n  \"extensions.md\",\n  \"api.md\"\n]\nDepth = 3","category":"page"},{"location":"#API-Index","page":"Home","title":"API Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"extensions/#Creating-MQTT-Backend-Extensions","page":"Extending MQTT.jl","title":"Creating MQTT Backend Extensions","text":"","category":"section"},{"location":"extensions/#How-it-works","page":"Extending MQTT.jl","title":"How it works","text":"","category":"section"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"MQTT.jl uses the Weak Deps features to allow multiple MQTT packages to be added as weak dependancies. ","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"Each MQTT client implimentation needs to have a extension added in the ext directory (and registered in the Project.toml).","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"These extensions and their packages they implement are only loaded if the end-user of this package adds it as a dependancy (only loading what you need).","category":"page"},{"location":"extensions/#Creating-an-Extension","page":"Extending MQTT.jl","title":"Creating an Extension","text":"","category":"section"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"To make a new Client functional an extension is created. The extension needs to implement the following interface functions that return asynchronous objects such as Tasks or Futures:","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"_connect(c::MQTTConnection): connect to a broker\n_subscribe(callback::Function, c::MQTTConnection, topic, qos::QOS): subscribe to a topic\n_publish(c::MQTTConnection, topic::String, payload::Vector{UInt8}, qos::QOS, retain::Bool): publish to a topic\n_unsubscribe(c::MQTTConnection, topic::String): unsubscribe from a topic\n_disconnect(c::MQTTConnection): disconnect from a broker","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"Aditionally the following utility function(s) need to be implemented:","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"_resolve(f): wrapper function for fetching a async result.","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"Most importantly the connection struct needs to be created with the standard constructor function.","category":"page"},{"location":"extensions/","page":"Extending MQTT.jl","title":"Extending MQTT.jl","text":"MQTTConnection needs to to construct your struct, that is a subtype of AbstractConnection. The struct must contain all information specific to the MQTT Client that is being used.","category":"page"}]
}