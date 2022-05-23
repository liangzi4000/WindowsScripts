 %SystemRoot%\Microsoft.NET\Framework\v4.0.30319\installutil.exe C:\ePortering\AppServer\WindowsService\EPM.WindowsService.RecurringRequest\RecurringRequestService.exe
 Net Start EPMRecurringRequest
 sc config EPMRecurringRequest start= auto
 
 PAUSE