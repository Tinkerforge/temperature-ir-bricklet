Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for object temperature callback (parameter has unit °C/10)
    Sub ObjectTemperatureCB(ByVal sender As BrickletTemperatureIR, _
                            ByVal temperature As Short)
        Console.WriteLine("Object Temperature: " + (temperature/10.0).ToString() + " °C")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register object temperature callback to subroutine ObjectTemperatureCB
        AddHandler tir.ObjectTemperature, AddressOf ObjectTemperatureCB

        ' Set period for object temperature callback to 1s (1000ms)
        ' Note: The object temperature callback is only called every second
        '       if the object temperature has changed since the last call!
        tir.SetObjectTemperatureCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
