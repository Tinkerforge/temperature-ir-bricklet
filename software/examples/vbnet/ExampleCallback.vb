Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "aNt" ' Change to your UID

    ' Callback functions for object/ambient temperature callback
    ' (parameters have unit °C/10)
    Sub ObjectCB(ByVal sender As BrickletTemperatureIR, ByVal temperature As Short)
        System.Console.WriteLine("Object Temperature: " + (temperature/10.0).ToString() + " °C")
    End Sub

    Sub AmbientCB(ByVal sender As BrickletTemperatureIR, ByVal temperature As Short)
        System.Console.WriteLine("Ambient Temperature: " + (temperature/10.0).ToString() + " °C")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set Period for temperature callbacks to 1s (1000ms)
        ' Note: The callbacks are only called every second if the
        '       value has changed since the last call!
        tir.SetObjectTemperatureCallbackPeriod(1000)
        tir.SetAmbientTemperatureCallbackPeriod(1000)

        ' Register object temperature callback to function ObjectCB
        AddHandler tir.ObjectTemperature, AddressOf ObjectCB
        ' Register ambient temperature callback to function AmbientCB
        AddHandler tir.AmbientTemperature, AddressOf AmbientCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
