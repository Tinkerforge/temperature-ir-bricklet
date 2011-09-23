/*************************************************************
 * This file was automatically generated on 2011-09-20.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

namespace Tinkerforge
{
	public class BrickletTemperatureIR : Device 
	{
		private static byte TYPE_GET_AMBIENT_TEMPERATURE = 1;
		private static byte TYPE_GET_OBJECT_TEMPERATURE = 2;
		private static byte TYPE_SET_EMISSIVITY = 3;
		private static byte TYPE_GET_EMISSIVITY = 4;
		private static byte TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD = 5;
		private static byte TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD = 6;
		private static byte TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD = 7;
		private static byte TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD = 8;
		private static byte TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD = 9;
		private static byte TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD = 10;
		private static byte TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD = 11;
		private static byte TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD = 12;
		private static byte TYPE_SET_DEBOUNCE_PERIOD = 13;
		private static byte TYPE_GET_DEBOUNCE_PERIOD = 14;
		private static byte TYPE_AMBIENT_TEMPERATURE = 15;
		private static byte TYPE_OBJECT_TEMPERATURE = 16;
		private static byte TYPE_AMBIENT_TEMPERATURE_REACHED = 17;
		private static byte TYPE_OBJECT_TEMPERATURE_REACHED = 18;

		public delegate void AmbientTemperature(short temperature);
		public delegate void ObjectTemperature(short temperature);
		public delegate void AmbientTemperatureReached(short temperature);
		public delegate void ObjectTemperatureReached(short temperature);

		public BrickletTemperatureIR(string uid) : base(uid) 
		{
			messageCallbacks[TYPE_AMBIENT_TEMPERATURE] = new MessageCallback(CallbackAmbientTemperature);
			messageCallbacks[TYPE_OBJECT_TEMPERATURE] = new MessageCallback(CallbackObjectTemperature);
			messageCallbacks[TYPE_AMBIENT_TEMPERATURE_REACHED] = new MessageCallback(CallbackAmbientTemperatureReached);
			messageCallbacks[TYPE_OBJECT_TEMPERATURE_REACHED] = new MessageCallback(CallbackObjectTemperatureReached);
		}

		public void GetAmbientTemperature(out short temperature)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_AMBIENT_TEMPERATURE, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_AMBIENT_TEMPERATURE, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetAmbientTemperature in time");
			}

			temperature = LEConverter.ShortFrom(4, answer);

			writeEvent.Set();
		}

		public void GetObjectTemperature(out short temperature)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_OBJECT_TEMPERATURE, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_OBJECT_TEMPERATURE, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetObjectTemperature in time");
			}

			temperature = LEConverter.ShortFrom(4, answer);

			writeEvent.Set();
		}

		public void SetEmissivity(ushort emissivity)
		{
			byte[] data = new byte[6];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_EMISSIVITY, 1, data);
			LEConverter.To((ushort)6, 2, data);
			LEConverter.To(emissivity, 4, data);

			ipcon.Write(this, data, TYPE_SET_EMISSIVITY, false);
		}

		public void GetEmissivity(out ushort emissivity)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_EMISSIVITY, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_EMISSIVITY, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetEmissivity in time");
			}

			emissivity = LEConverter.UShortFrom(4, answer);

			writeEvent.Set();
		}

		public void SetAmbientTemperatureCallbackPeriod(uint period)
		{
			byte[] data = new byte[8];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD, 1, data);
			LEConverter.To((ushort)8, 2, data);
			LEConverter.To(period, 4, data);

			ipcon.Write(this, data, TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD, false);
		}

		public void GetAmbientTemperatureCallbackPeriod(out uint period)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetAmbientTemperatureCallbackPeriod in time");
			}

			period = LEConverter.UIntFrom(4, answer);

			writeEvent.Set();
		}

		public void SetObjectTemperatureCallbackPeriod(uint period)
		{
			byte[] data = new byte[8];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD, 1, data);
			LEConverter.To((ushort)8, 2, data);
			LEConverter.To(period, 4, data);

			ipcon.Write(this, data, TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD, false);
		}

		public void GetObjectTemperatureCallbackPeriod(out uint period)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetObjectTemperatureCallbackPeriod in time");
			}

			period = LEConverter.UIntFrom(4, answer);

			writeEvent.Set();
		}

		public void SetAmbientTemperatureCallbackThreshold(char option, short min, short max)
		{
			byte[] data = new byte[9];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD, 1, data);
			LEConverter.To((ushort)9, 2, data);
			LEConverter.To(option, 4, data);
			LEConverter.To(min, 5, data);
			LEConverter.To(max, 7, data);

			ipcon.Write(this, data, TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD, false);
		}

		public void GetAmbientTemperatureCallbackThreshold(out char option, out short min, out short max)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetAmbientTemperatureCallbackThreshold in time");
			}

			option = LEConverter.CharFrom(4, answer);
			min = LEConverter.ShortFrom(5, answer);
			max = LEConverter.ShortFrom(7, answer);

			writeEvent.Set();
		}

		public void SetObjectTemperatureCallbackThreshold(char option, short min, short max)
		{
			byte[] data = new byte[9];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD, 1, data);
			LEConverter.To((ushort)9, 2, data);
			LEConverter.To(option, 4, data);
			LEConverter.To(min, 5, data);
			LEConverter.To(max, 7, data);

			ipcon.Write(this, data, TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD, false);
		}

		public void GetObjectTemperatureCallbackThreshold(out char option, out short min, out short max)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetObjectTemperatureCallbackThreshold in time");
			}

			option = LEConverter.CharFrom(4, answer);
			min = LEConverter.ShortFrom(5, answer);
			max = LEConverter.ShortFrom(7, answer);

			writeEvent.Set();
		}

		public void SetDebouncePeriod(uint debounce)
		{
			byte[] data = new byte[8];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_SET_DEBOUNCE_PERIOD, 1, data);
			LEConverter.To((ushort)8, 2, data);
			LEConverter.To(debounce, 4, data);

			ipcon.Write(this, data, TYPE_SET_DEBOUNCE_PERIOD, false);
		}

		public void GetDebouncePeriod(out uint debounce)
		{
			byte[] data = new byte[4];
			LEConverter.To(stackID, 0, data);
			LEConverter.To(TYPE_GET_DEBOUNCE_PERIOD, 1, data);
			LEConverter.To((ushort)4, 2, data);

			ipcon.Write(this, data, TYPE_GET_DEBOUNCE_PERIOD, true);

			byte[] answer;
			if(!answerQueue.TryDequeue(out answer, IPConnection.TIMEOUT_ANSWER))
			{
				throw new TimeoutException("Did not receive answer for GetDebouncePeriod in time");
			}

			debounce = LEConverter.UIntFrom(4, answer);

			writeEvent.Set();
		}

		public int CallbackAmbientTemperature(byte[] data)
		{
			short temperature = LEConverter.ShortFrom(4, data);

			((AmbientTemperature)callbacks[TYPE_AMBIENT_TEMPERATURE])(temperature);
			return 6;
		}

		public int CallbackObjectTemperature(byte[] data)
		{
			short temperature = LEConverter.ShortFrom(4, data);

			((ObjectTemperature)callbacks[TYPE_OBJECT_TEMPERATURE])(temperature);
			return 6;
		}

		public int CallbackAmbientTemperatureReached(byte[] data)
		{
			short temperature = LEConverter.ShortFrom(4, data);

			((AmbientTemperatureReached)callbacks[TYPE_AMBIENT_TEMPERATURE_REACHED])(temperature);
			return 6;
		}

		public int CallbackObjectTemperatureReached(byte[] data)
		{
			short temperature = LEConverter.ShortFrom(4, data);

			((ObjectTemperatureReached)callbacks[TYPE_OBJECT_TEMPERATURE_REACHED])(temperature);
			return 6;
		}

		public void RegisterCallback(System.Delegate d)
		{
			if(d.GetType() == typeof(AmbientTemperature))
			{
				callbacks[TYPE_AMBIENT_TEMPERATURE] = d;
			}
			else if(d.GetType() == typeof(ObjectTemperature))
			{
				callbacks[TYPE_OBJECT_TEMPERATURE] = d;
			}
			else if(d.GetType() == typeof(AmbientTemperatureReached))
			{
				callbacks[TYPE_AMBIENT_TEMPERATURE_REACHED] = d;
			}
			else if(d.GetType() == typeof(ObjectTemperatureReached))
			{
				callbacks[TYPE_OBJECT_TEMPERATURE_REACHED] = d;
			}
		}
	}
}
