Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "aNt" ' Change to your UID

    ' Callback for object temperature greater than 100 °C (parameter has unit °C/10)
    Sub ReachedCB(ByVal sender As BrickletTemperatureIR, ByVal temperature As Short)
        System.Console.WriteLine("The surface has a temperature of " + _
                                 (temperature/10.0).ToString() + " °C")
        System.Console.WriteLine("The water is boiling!")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim tir As New BrickletTemperatureIR(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set emissivity to 0.98 (emissivity of water)
        tir.SetEmissivity(&HFFFF*0.98)

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        tir.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler tir.ObjectTemperatureReached, AddressOf ReachedCB

        ' Configure threshold for "greater than 100 °C" (unit is °C/10)
        tir.SetObjectTemperatureCallbackThreshold(">"C, 100*10, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
