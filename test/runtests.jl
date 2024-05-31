using Test

@testset verbose = true "MQTTClient.jl" begin
    include("mqttclient.test.jl")
end

@testset verbose = true "AWSCRT.jl" begin
    include("awscrt.test.jl")
end
