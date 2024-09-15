Add-Type -TypeDefinition @"
      using System;
      using System.Runtime.InteropServices;

      public class DisplayOrientationHelper
      {
          [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
          public static extern int ChangeDisplaySettings(ref DEVMODE devMode, int flags);

          [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
          public struct DEVMODE
          {
              public const int CCHDEVICENAME = 32;
              public const int CCHFORMNAME = 32;
              [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CCHDEVICENAME)]
              public string dmDeviceName;
              public ushort dmSpecVersion;
              public ushort dmDriverVersion;
              public ushort dmSize;
              public ushort dmDriverExtra;
              public uint dmFields;

              public int dmPositionX;
              public int dmPositionY;
              public uint dmDisplayOrientation;
              public uint dmDisplayFixedOutput;
              public short dmColor;
              public short dmDuplex;
              public short dmYResolution;
              public short dmTTOption;
              public short dmCollate;
              [MarshalAs(UnmanagedType.ByValTStr, SizeConst = CCHFORMNAME)]
              public string dmFormName;
              public ushort dmLogPixels;
              public uint dmBitsPerPel;
              public uint dmPelsWidth;
              public uint dmPelsHeight;
              public uint dmDisplayFlags;
              public uint dmDisplayFrequency;
              public uint dmICMMethod;
              public uint dmICMIntent;
              public uint dmMediaType;
              public uint dmDitherType;
              public uint dmReserved1;
              public uint dmReserved2;
              public uint dmPanningWidth;
              public uint dmPanningHeight;
          }

          public static void SetLandscapeOrientation()
          {
              DEVMODE dm = new DEVMODE();
              dm.dmSize = (ushort)Marshal.SizeOf(typeof(DEVMODE));
              dm.dmFields = 0x00000080; // DM_DISPLAYORIENTATION
              dm.dmDisplayOrientation = 0; // 0 = Landscape

              ChangeDisplaySettings(ref dm, 0);
          }
      }
      "@

      [DisplayOrientationHelper]::SetLandscapeOrientation()
