using MQTTClient: MQTTClient
using MQTT
using Sockets

using Aqua

@testset verbose = true "Code quality test with Aqua" begin
    @testset verbose = true "Test ambiguitie" begin
        Aqua.test_ambiguities([MQTT, Base, Core])
    end
    @testset verbose = true "Test unbound arguments" begin
        Aqua.test_unbound_args(MQTT)
    end
    @testset verbose = true "Test exports" begin
        Aqua.test_undefined_exports(MQTT)
    end
    @testset verbose = true "Test project extras" begin
        Aqua.test_project_extras(MQTT)
    end
    @testset verbose = true "Test stale dependancies" begin
        Aqua.test_stale_deps(MQTT; ignore=[:Aqua])
    end
    @testset verbose = true "Test dependancy compatability" begin
        Aqua.test_deps_compat(MQTT)
    end
end

@testset verbose = true "Extension  Functions for MQTTClient.jl" begin
    cb(args...) = nothing

    server = if Sys.iswindows()
        MQTTClient.MockMQTTBroker(ip"127.0.0.1", 1881)
    else
        MQTTClient.MockMQTTBroker("/tmp/testmqtt.sock")
    end

    conf = if Sys.iswindows()
        MQTTConnection(MQTTClient.MakeConnection(ip"127.0.0.1", 1881))
    else
        MQTTConnection(MQTTClient.MakeConnection("/tmp/testmqtt.sock"))
    end

    @testset "connect!" begin
        connect!(conf)
        @test MQTTClient.isconnected(conf.client)
    end
    @testset "subscribe!" begin
        res = subscribe!(cb, conf, "foo/bar", EXACTLY_ONCE)
        @test res == [0x01, 0x00]
    end
    @testset "publish!" begin
        res = publish!(conf, "bar/foo", "baz", EXACTLY_ONCE)
        @test isnothing(res)
        res = publish!(conf, "bar/foo", "baz", AT_MOST_ONCE)
        @test res === 0
    end
    @testset "unsubscribe!" begin
        res = unsubscribe!(conf, "foo/bar")
        @test isnothing(res)
    end
    @testset "disconnect!" begin
        res = disconnect!(conf)
        @test res == (0x00, 0x00, 0x00)
        @test MQTTClient.isclosed(conf.client)
    end
    @testset "reconnect" begin
        @test MQTTClient.isclosed(conf.client)
        connect!(conf)
        @test MQTTClient.isconnected(conf.client)
        res = disconnect!(conf)
        @test MQTTClient.isclosed(conf.client)
        @test res == (0x00, 0x00, 0x00)
    end

    close(server)
end
