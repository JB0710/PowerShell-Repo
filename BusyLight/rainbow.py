$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
Add-Type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)

from busylight.manager import LightManager
from busylight.effects import Effects

manager = LightManager()
for light in manager.lights:
   print(light.name)
   
rainbow = Effects.for_name("spectrum")(duty_cycle=0.01)

manager.apply_effect(rainbow)
...
manager.off()