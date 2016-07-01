Imports System
Imports Tinkerforge

Module ExampleWaterBoiling
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Temperature IR Bricklet

    ' Callback subroutine for object temperature reached callback (parameter has unit °C/10)
    Sub ObjectTemperatureReachedCB(ByVal sender As BrickletTemperatureIR, _
                                   ByVal temperature As Short)
        Console.WriteLine("Object Temperature: " + (temperature/10.0).ToString() + " °C")
        Console.WriteLine("The water is boiling!")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
        tir.SetEmissivity(64224)

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        tir.SetDebouncePeriod(10000)

        ' Register object temperature reached callback to subroutine ObjectTemperatureReachedCB
        AddHandler tir.ObjectTemperatureReached, AddressOf ObjectTemperatureReachedCB

        ' Configure threshold for object_temperature "greater than 100 °C" (unit is °C/10)
        tir.SetObjectTemperatureCallbackThreshold(">"C, 100*10, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
