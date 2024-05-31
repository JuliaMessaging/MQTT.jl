using AWSCRT: AWSCRT
using MQTT

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

@testset verbose = true "Extension Functions for AWSCRT.jl" begin
    @testset "connect! exists" begin
        @test length(methods(MQTT._connect)) > 1
    end
    @testset "subscribe! exists" begin
        @test length(methods(MQTT._subscribe)) > 1
    end
    @testset "publish! exists" begin
        @test length(methods(MQTT._publish)) > 1
    end
    @testset "unsubscribe! exists" begin
        @test length(methods(MQTT._unsubscribe)) > 1
    end
    @testset "disconnect! exists" begin
        @test length(methods(MQTT._disconnect)) > 1
    end
end
