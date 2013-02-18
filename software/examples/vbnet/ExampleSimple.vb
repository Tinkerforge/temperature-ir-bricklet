Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "aNt" ' Change to your UID

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get current object and ambient temperatures (unit is °C/10)
        Dim obj As Short = tir.GetObjectTemperature()
        Dim amb As Short = tir.GetAmbientTemperature()

        System.Console.WriteLine("Object Temperature: " + (obj/10.0).ToString() + " C")
        System.Console.WriteLine("Ambient Temperature: " + (amb/10.0).ToString() + " C")

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
