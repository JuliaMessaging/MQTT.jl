# MQTT

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaMessaging.github.io/MQTT.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaMessaging.github.io/MQTT.jl/dev/)
[![Build Status](https://github.com/JuliaMessaging/MQTT.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaMessaging/MQTT.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaMessaging/MQTT.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/JuliaMessaging/MQTT.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![PkgEval](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/M/MQTT.svg)](https://JuliaCI.github.io/NanosoldierReports/pkgeval_badges/report.html)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)

This is an interface package for MQTT Messaging. See the [documentation](https://JuliaMessaging.github.io/MQTT.jl) for more information.

#### This is an interface package, it contains no functionality by itself.
You will need to use a MQTT backend to connect to a broker. This Package is intended to make it easier for developers to integrate with MQTT without locking themselves into the syntax of a specific MQTT Backend. 

## Example Useage

### AWSCRT.jl

```julia
using AWSCRT
using MQTT

mqttconnection = ...
```

### MQTTClient.jl

```julia
using MQTTClient
using MQTT

broker = "192.168.1.100" # address to mqtt broker
port = 1883

mqttconnection = MQTT.MQTTConnection(MQTTClient.MakeConnection(broker, port))
connect!(mqttconnection)

subscribe!(mqttconnection, "foo/test", EXACTLY_ONCE) do topic, payload
	println("MQTT[$topic]: $payload")
end

publish!(mqttconnection, "foo/test", "bar", EXACTLY_ONCE)

unsubscribe!(mqttconnection, "foo/test")

disconnect!(mqttconnection)
```

## Contributing

If you would like to contribute to the project, please submit a PR. All contributions are welcomed and appreciated.

If there is an MQTT package that you would like to see included please submit an issue. Or even better create the extension for it and submit a PR!

### TODO

- [x] add tests
- [ ] check if other clients can integrate
- [ ] register in Julia General
- [x] general doctrings for interface functions