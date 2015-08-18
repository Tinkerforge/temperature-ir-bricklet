Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for ambient temperature callback (parameter has unit °C/10)
    Sub AmbientTemperatureCB(ByVal sender As BrickletTemperatureIR, ByVal ambientTemperature As Short)
        System.Console.WriteLine("Ambient Temperature: " + (ambientTemperature/10.0).ToString() + " °C")
    End Sub

    ' Callback function for object temperature callback (parameter has unit °C/10)
    Sub ObjectTemperatureCB(ByVal sender As BrickletTemperatureIR, ByVal objectTemperature As Short)
        System.Console.WriteLine("Object Temperature: " + (objectTemperature/10.0).ToString() + " °C")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set period for ambient temperature callback to 1s (1000ms)
        ' Note: The ambient temperature callback is only called every second
        '       if the ambient temperature has changed since the last call!
        tir.SetAmbientTemperatureCallbackPeriod(1000)

        ' Register ambient temperature callback to function AmbientTemperatureCB
        AddHandler tir.AmbientTemperature, AddressOf AmbientTemperatureCB

        ' Set period for object temperature callback to 1s (1000ms)
        ' Note: The object temperature callback is only called every second
        '       if the object temperature has changed since the last call!
        tir.SetObjectTemperatureCallbackPeriod(1000)

        ' Register object temperature callback to function ObjectTemperatureCB
        AddHandler tir.ObjectTemperature, AddressOf ObjectTemperatureCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
